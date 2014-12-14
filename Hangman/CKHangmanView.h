//
//  CKHangmanView.h
//  Hangman
//
//  Created by Adam Folmert on 11/21/14.
//  Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define COLOR_RED 1
#define COLOR_YELLOW 2
#define COLOR_BLUE 3


@interface CKHangmanView : NSView
{
    NSUInteger _color; 
}


- (void)reset;
- (void)setColor:(NSUInteger)color;
- (void)increaseHangman;
- (void)decreaseHangman;
- (void)listResources;

@end
