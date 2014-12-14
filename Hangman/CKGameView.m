//
//  CKGameView.m
//  Hangman
//
//  Created by Adam Folmert on 11/22/14.
//  Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import "CKGameView.h"

@implementation CKGameView




- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        
        NSLog(@"Game View initialized!");
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    [super drawRect:dirtyRect];
}



@end
