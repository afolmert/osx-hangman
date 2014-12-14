//
//  CKWindowController.h
//  Hangman
//
//  Created by Adam Folmert on 11/22/14.
//  Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CKHangmanView.h"
#import "CKWordView.h"

@interface CKWindowController : NSWindowController <NSWindowDelegate>


@property (weak) IBOutlet NSView *mainView;

@property (weak) IBOutlet CKHangmanView *hangmanView;
@property (weak) IBOutlet CKWordView *wordView;

@property (weak) IBOutlet NSTextField *hudLabel;


- (IBAction)hangmanClicked:(id)sender;

- (IBAction)tipClicked:(id)sender;

- (IBAction)newGameClicked:(id)sender;
- (IBAction)testTimerClicked:(id)sender;

- (IBAction)testClicked:(id)sender;

- (IBAction)aboutClicked:(id)sender;
- (IBAction)newClicked:(id)sender;
- (IBAction)resetClicked:(id)sender;

@end
