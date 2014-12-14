//
//  CKAppDelegate.h
//  Hangman
//
//  Created by Adam Folmert on 11/21/14.
//  Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CKHangmanView.h"
#import "CKGameView.h"

#import "CKWordView.h"

@interface CKAppDelegate : NSObject <NSApplicationDelegate>
{
    int _counter;
}



@property (assign) IBOutlet NSWindow *window;



@end
