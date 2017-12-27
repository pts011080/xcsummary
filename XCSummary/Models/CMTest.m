//
//  CMTest.m
//  xcsummary
//
//  Created by Kryvoblotskyi Sergii on 12/12/16.
//  Copyright © 2016 MacPaw inc. All rights reserved.
//

#import "CMTest.h"
#import "NSArrayAdditions.h"
#import "CMActivitySummary.h"

CMTestStatus CMTestStatusFromString(NSString * string);

@implementation CMTest

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self)
    {
        
        NSString *uuid = [[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
        _divID = [NSString stringWithFormat:@"id%@",uuid];
        
        NSArray *rawTests = dictionary[@"Subtests"];
        NSString *status = dictionary[@"TestStatus"];
        NSArray *activities = dictionary[@"ActivitySummaries"];
        NSString *summaryGUIDString = dictionary[@"TestSummaryGUID"];
        __block NSString *name = @"";
//        _testName = dictionary[@"TestName"];
        NSArray *names = [dictionary[@"TestName"] componentsSeparatedByString:@"_"];
        [names enumerateObjectsUsingBlock:^(NSString* strs, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                if (strs.length >= 3 && [[[strs substringToIndex:3] uppercaseString] isEqualToString:@"CCC"]) {
                    name = [name stringByAppendingString:[strs substringFromIndex:3]];
                }else if (strs.length >= 7 && [[[strs substringToIndex:7] uppercaseString] isEqualToString:@"TESTFOR"]) {
                    name = [name stringByAppendingString:[strs substringFromIndex:7]];
                }else{
                    name = strs;
                }
            }else{
                name = [name stringByAppendingString:[NSString stringWithFormat:@"%@%@",[name isEqualToString:@""]?@"":@" ",strs]];
            }
        }];
        
        _testName = name;
        
        _testIdentifier = dictionary[@"TestIdentifier"];
        _testObjectClass = dictionary[@"TestObjectClass"];
        _duration = [dictionary[@"Duration"] doubleValue];
        _subTests = [rawTests map:^id(NSDictionary *rawTest, NSUInteger index, BOOL *stop) {
            CMTest *subTest = [[CMTest alloc] initWithDictionary:rawTest];
            subTest.parentID = _divID;
            return subTest;
        }];
        _activities = [activities map:^id(NSDictionary *rawActivity, NSUInteger index, BOOL *stop) {
            return [[CMActivitySummary alloc] initWithDictionary:rawActivity];
        }];
        _status = CMTestStatusFromString(status);
        _testSummaryGUID = [[NSUUID alloc] initWithUUIDString:summaryGUIDString];
        
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\n%@ %@ %@\n", [super description], self.testName, self.subTests];
}

@end

CMTestStatus CMTestStatusFromString(NSString * string)
{
    CMTestStatus status = CMTestStatusUnknown;
    if ([string isEqualToString:@"Failure"])
    {
        status = CMTestStatusFailure;
    }
    else if ([string isEqualToString:@"Success"])
    {
        status = CMTestStatusSuccess;
    }
    return status;
}
