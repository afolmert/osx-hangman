//
//  CKHangmanView.m
//  Hangman
//
//  Created by Adam Folmert on 11/21/14.
//  Copyright (c) 2014 Adam Folmert. All rights reserved.
//


#import "CKHangmanView.h"
#import "CKHangman.h"


@implementation CKHangmanView
{
    NSImage *_image;
    NSUInteger _currentPart;
    CKHangman *_hangman;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        [self reset];
    }
    
    return self;
}

- (void)reset
{
    _currentPart = 0;
    _hangman = [CKHangman new];

}


- (void)setColor:(NSUInteger)color
{
    _color = color;
}



- (void)increaseHangman
{
    [_hangman increase];
}

- (void)decreaseHangman
{
    [_hangman decrease];
}


- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    [[NSColor whiteColor] set];
    NSRectFill([self bounds]);
    
    [_hangman drawInRect:[self bounds]];
}


@end
