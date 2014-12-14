//
//  CKWordView.h
//  Hangman
//
//  Created by Adam Folmert on 11/22/14.
//  Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CKWordView : NSView


- (void)reset;
- (BOOL)tryEvent:(NSEvent *)event;

@end
