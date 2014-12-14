//
// Created by Adam Folmert on 11/23/14.
// Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import "CKUtils.h"


@implementation CKUtils
{

}

- (void)listResources
{

    NSLog(@"Listing resources ... ");
    NSBundle *bundle = [NSBundle mainBundle];
    id result = [bundle pathsForResourcesOfType:nil inDirectory:nil];
    for (id res in result) {
        NSLog(@"Found %@", res);
    }

    NSLog(@"Done !");
}
@end