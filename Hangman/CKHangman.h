//
// Created by Adam Folmert on 11/21/14.
// Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CKHangman : NSObject

- (BOOL)increase;
- (BOOL)decrease;
- (void)drawInRect:(NSRect)destRect;

@end