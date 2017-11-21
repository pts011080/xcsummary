//
//  CMAttachment.m
//  xcsummary
//
//  Created by user on 10/11/2017.
//  Copyright © 2017年 MacPaw inc. All rights reserved.
//

#import "CMAttachment.h"

@implementation CMAttachment

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    //    NSLog(@"dictionary: %@",dictionary);
    self = [super init];
    if (self)
    {
        _hasPayload = [dictionary[@"HasPayload"] boolValue];
        
        _name = dictionary[@"Name"];
        _filename = dictionary[@"Filename"];
        _uniformTypeIdentifier = dictionary[@"UniformTypeIdentifier"];
        
        _lifetime = @([dictionary[@"Lifetime"] integerValue]);
        _inActivityIdentifier = @([dictionary[@"InActivityIdentifier"] integerValue]);;
        
        _timestamp = [dictionary[@"Timestamp"] doubleValue];
        
        NSDictionary *userInfo = dictionary[@"UserInfo"];
        _scale = @([userInfo[@"Scale"] integerValue]);
        
    }
    return self;
}

@end
