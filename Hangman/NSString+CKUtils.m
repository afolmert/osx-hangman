//
// Created by Adam Folmert on 11/22/14.
// Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import "NSString+CKUtils.h"


@implementation NSString (CKUtils)


- (NSString *)repeatTimes:(NSUInteger)times
{
    return [@"" stringByPaddingToLength:[self length] * times
                             withString:self
                        startingAtIndex:0];
}



@end