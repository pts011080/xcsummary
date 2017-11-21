//
//  CMAttachment.h
//  xcsummary
//
//  Created by user on 10/11/2017.
//  Copyright © 2017年 MacPaw inc. All rights reserved.
//

#import "CMEntity.h"

@interface CMAttachment : CMEntity

@property (nonatomic, readonly) BOOL hasPayload;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *filename;
@property (nonatomic, copy, readonly) NSString *uniformTypeIdentifier;

@property (nonatomic, strong, readonly) NSNumber *scale;
@property (nonatomic, strong, readonly) NSNumber *lifetime;
@property (nonatomic, strong, readonly) NSNumber *inActivityIdentifier;

@property (nonatomic, readonly) NSTimeInterval timestamp;


@end
