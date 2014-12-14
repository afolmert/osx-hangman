//
//  CKWindowController.m
//  Hangman
//
//  Created by Adam Folmert on 11/22/14.
//  Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CKWindowController.h"
#import "CKPaintView.h"

@interface CKWindowController ()

@end

@implementation CKWindowController
{
    NSUInteger _counter;
    NSTimer *_timer;
}



- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"awakeFromNib START");
    
    self.window.backgroundColor = [NSColor whiteColor];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    // Insert code here to initialize your application
    _timer = nil;
    [_hudLabel setAlphaValue:0.0];
    _counter = 0;
    
    [self.window makeFirstResponder:self];
    [self becomeFirstResponder];
    
    [self resetGame];

}


- (void)showWindow:(id)sender
{
    NSLog(@"showWindow START!");
    [super showWindow:sender];
}




- (BOOL)acceptsFirstResponder
{
    return YES;
}


- (BOOL)resignFirstResponder
{
    return YES;
}


- (BOOL)becomeFirstResponder
{
    return YES;
}

-(void)windowWillLoad
{
    NSLog(@"Window will load !");
    [super windowWillLoad];
}


- (void)windowDidBecomeKey:(NSNotification *)notification
{
    NSLog(@"Window did become key %@", notification);
    
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self != nil) {

    }
    return self;

    
}


- (void)windowDidLoad
{
    [super windowDidLoad];
}

- (void)windowWillClose:(NSNotification *)notification
{
}


- (void)keyDown:(NSEvent *)theEvent
{
    
    NSLog(@"Window controller keyDown for %@ ", theEvent);
    
    if ([_wordView tryEvent:theEvent]) {
        [_hangmanView decreaseHangman];
        [self showHudMessage:@"Correct, yay!"];
    } else {
        [_hangmanView increaseHangman];
        [self showHudMessage:@"Ouch..."];
        
    }

    [_hangmanView setNeedsDisplay:YES];

}

- (void)keyUp:(NSEvent *)theEvent
{
    NSLog(@"Window controller keyUp event %@", theEvent);
}



- (void)targetMethod:(NSTimer *)timer
{
    NSArray *arr = [timer userInfo];
    for (id obj in arr) {
        NSLog(@"User info : %@", obj);
    }
    NSLog(@"Timer launched ! ");
}

- (IBAction)testTimerClicked:(id)sender 
{
    
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:@[@1, @8]
                                    repeats:NO];
}

// create textlabel dynamically 

// change fade out 



// http://stackoverflow.com/questions/22314509/nsviewanimations-used-in-os-x-10-6-stopped-working-in-os-x-10-9-subsequent-anim


- (void)animateHudWithViewAnimation {
    // anim 
    NSMutableDictionary *animDict = [NSMutableDictionary new];
    
    NSRect origFrame = [_hudLabel frame];
    NSRect destFrame = [_hudLabel frame];
    destFrame.origin.x += 50;
    destFrame.origin.y += 50;
    
    
    animDict[NSViewAnimationTargetKey] = _hudLabel;
    animDict[NSViewAnimationStartFrameKey] = [NSValue valueWithRect:origFrame];
    
    
    //animDict[NSViewAnimationEffectKey] = NSViewAnimationFadeOutEffect;
    
    animDict[NSViewAnimationEndFrameKey] = [NSValue valueWithRect:destFrame];
    
    NSViewAnimation *anim = [[NSViewAnimation alloc] initWithViewAnimations:@[animDict]];
    
    [anim setAnimationBlockingMode: NSAnimationBlocking];
    [anim setDuration:0.2];
    [anim setAnimationCurve:NSAnimationEaseIn];

    
    // anim2 
    NSMutableDictionary *anim2Dict = [NSMutableDictionary new];
    anim2Dict[NSViewAnimationTargetKey] = _hudLabel;
    anim2Dict[NSViewAnimationStartFrameKey] = [NSValue valueWithRect:destFrame];
    anim2Dict[NSViewAnimationEndFrameKey] = [NSValue valueWithRect:origFrame];
    
    anim2Dict[NSViewAnimationEffectKey] = NSViewAnimationFadeOutEffect;
    
    NSViewAnimation *anim2 = [[NSViewAnimation alloc] initWithViewAnimations:@[anim2Dict]];
    [anim2 setDuration:1];
//    [anim2 startWhenAnimation:anim reachesProgress:1];
    [anim2 setAnimationBlockingMode:NSAnimationBlocking];
    [anim2 setAnimationCurve:NSAnimationEaseOut];
    
    
    
    [anim startAnimation];
    
 //  [anim2 startAnimation];
    ////[_hudLabel setAlphaValue:1];
    NSLog(@"Animation finished!");
}


// AnimatorProxy NSView animations ?! 
// http://swwritings.com/post/2010-05-23-core-animation-the-animator-proxy

// http://stackoverflow.com/questions/6728455/animation-doesnt-show




- (CAKeyframeAnimation *)fadeInfadeOutAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    [animation setKeyPath:@"alphaValue"];
    [animation setDuration:3.0];
    
    [animation setValues:@[@0, @1.0, @1.0, @0]];
    [animation setKeyTimes:@[@0, @0.1, @0.9, @1]];
    
    
    return animation;
    
}


- (void)showHudMessage:(NSString *)message
{
    
    [_hudLabel setStringValue:message];

    [_hudLabel setAnimations:@{@"alphaValue":[self fadeInfadeOutAnimation]}];
    [[_hudLabel animator] setAlphaValue:0];    
}

- (void)animateHud1
{
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:3.0f];
    
    
    [[_hudLabel animator] setFrameOrigin:NSMakePoint(300, 300)];
    
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.5f];
    [[_hudLabel animator] setAlphaValue:0.0];
    
//    [[NSAnimationContext currentContext] setCompletionHandler:^(void){
//        [NSAnimationContext beginGrouping];
//        [[NSAnimationContext currentContext] setDuration:2.0];
//        [[_hudLabel animator] setAlphaValue:1.0];
//        
//        [NSAnimationContext endGrouping];
//    }];
//    
    [NSAnimationContext endGrouping];
    
    [NSAnimationContext endGrouping];
    
}


- (CABasicAnimation *)counterAnimation       
//- HOW TOS specify here FROM and TO values to be passed as parameters ? ? ! !



 //HOE to move paint around the screen  , bugger and smaller , path animation 
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"counter"];
    [animation setDuration:1.0];
    [animation setFromValue:@0];
    [animation setToValue:@30];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]]; 
    return animation;
}


- (CAKeyframeAnimation *)keyframeAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    [animation setKeyPath:@"frameOrigin"];
    [animation setDuration:0.5];
    
    [animation setValues:@[[NSValue valueWithPoint:NSMakePoint(10, 10)],
     [NSValue valueWithPoint:NSMakePoint(330, 30)],
     [NSValue valueWithPoint:NSMakePoint(40, 340)]]];
     
    [animation setKeyTimes:@[@0.0, @0.1, @0.3, @0.5]];
     
     
    return animation;
    
}

- (void)animateHud3
{
    CKPaintView *paintView = [[CKPaintView alloc] initWithFrame:NSMakeRect(0, 0, 60, 60)];
    
    
    
    [_mainView addSubview:paintView];

    
    NSMutableDictionary *newAnimations = [NSMutableDictionary new];
    [newAnimations addEntriesFromDictionary:[paintView animations]];
    newAnimations[@"counter"] = [self counterAnimation];
  
    [paintView setAnimations:newAnimations];
    
    [[paintView animator] setCounter:@30];
    [[paintView animator] setFrameOrigin:NSMakePoint(100, 100)];
    //[[_hudLabel animator] setColor:[NSColor redColor]];
}

- (CABasicAnimation *)fadeOutAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"alphaValue"];
    [animation setDuration:0.3];
    [animation setFromValue:@1.0];
    [animation setToValue:@0.0];
    return animation;
    
}
                  
- (void)animateHud4
{

    CKPaintView *paintView = [[CKPaintView alloc] initWithFrame:NSMakeRect(0, 0, 60, 60)];
    [_mainView addSubview:paintView];

    [paintView setAnimations:@{@"test":[self keyframeAnimation]}];
    [[paintView animator] setValue:nil forKey:@"test"];
}
                  



- (void)animateHud5
{
    
    CKPaintView *paintView = [[CKPaintView alloc] initWithFrame:NSMakeRect(100, 100, 60, 60)];
    [_mainView addSubview:paintView];

    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    [group setAnimations:@[[self keyframeAnimation], [self fadeOutAnimation]]];
    [group setDuration:6.0];
     
    
    [paintView setAnimations:@{@"testAnimation":group}];
    [[paintView animator] setValue:nil forKey:@"testAnimation"];
}


- (IBAction)testClicked:(id)sender 
{
    NSLog(@"Test clicked START");

    [self showHudMessage:@"Hello Africa!"];
 //   [self animateHud5];
   // [self createLabel];
  //  [_hudLabel setStringValue:@"Another value is here , surprise!"];
 
}

- (IBAction)aboutClicked:(id)sender 
{
    NSAlert *alert = [[NSAlert alloc] init];
    
    [alert setMessageText:@"The Hangman Game"];
    [alert setInformativeText:@"Copyright (c) 2014 Adam Folmert\nMIT License"];
    [alert runModal];
}


- (IBAction)newClicked:(id)sender 
{
    [self resetGame];
}

- (IBAction)resetClicked:(id)sender 
{
    [self resetGame];
}


- (void)resetGame
{
    [_hangmanView reset];
    [_hangmanView setNeedsDisplay:YES];

    [_wordView reset];
    [_wordView setNeedsDisplay:YES];
 
    // Delay execution of my block for 10 seconds.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self showHudMessage:@"Try to guess the below word!"];
    });
    

}


@end
