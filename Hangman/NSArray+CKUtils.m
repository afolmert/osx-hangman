//
// Created by Adam Folmert on 11/22/14.
// Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import "NSArray+CKUtils.h"


@implementation NSArray (CKUtils)

- (id)randomObject
{
    NSUInteger count = [self count];
    if (count > 0) {
        return [self objectAtIndex:arc4random_uniform((u_int32_t)count)];
    } else {
        return nil;
    }

}


@end