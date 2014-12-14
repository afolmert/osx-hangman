//
//  CKWordView.m
//  Hangman
//
//  Created by Adam Folmert on 11/22/14.
//  Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import "CKWordView.h"
#import "CKWordDictionary.h"
#import "CKWord.h"
#import "CKWordAnimationStatus.h"


const NSUInteger kCharacterSpacing = 5;
const NSTimeInterval kBlinkTimerInterval = 0.05;


const BOOL kDebug = NO;


@implementation CKWordView
{
    NSDictionary *_attributes;
    NSDictionary *_attributesForBlink;

    CKWord *_word;
    CKWordDictionary *_wordDictionary;

    CKWordAnimationStatus *_wordAnimationStatus;

    NSTimer *_animationTimer;
}




- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self reset];
    }
    
    return self;
}


- (void)reset
{
    _attributes = [self initializeAttributes];
    _attributesForBlink = [self initializeAttributesForBlink];
    _wordDictionary = [CKWordDictionary new];

    NSString *wordStr = [_wordDictionary randomWord];
    _word = [CKWord wordWithString:wordStr];
    _wordAnimationStatus =
            [[CKWordAnimationStatus alloc]
                    initWithCapacity:[wordStr length]];

    if (_animationTimer != nil) {
        [_animationTimer invalidate];
    }
    _animationTimer = nil;
}


- (void)startAnimationTimer
{
    if (_animationTimer != nil) {
        return;
    }
    _animationTimer = [NSTimer scheduledTimerWithTimeInterval:kBlinkTimerInterval
                                                       target:self
                                                     selector:@selector(animationTimerTick:)
                                                     userInfo:nil
                                                      repeats:YES];
}


- (void)stopAnimationTimer
{

    if (_animationTimer != nil) {
        [_animationTimer invalidate];
        _animationTimer = nil;

    }
}



- (NSDictionary *)initializeAttributes
{
    NSMutableDictionary *result = [NSMutableDictionary new];
    [result setObject:[NSFont fontWithName:@"Courier"
                                          size:40]
                   forKey:NSFontAttributeName];
    
    [result setObject:[NSColor blackColor]
                   forKey:NSForegroundColorAttributeName];
    
    return result;
    
}

- (NSDictionary *)initializeAttributesForBlink
{
    NSMutableDictionary *result = [[self initializeAttributes] mutableCopy];

    [result setObject:[NSColor grayColor]
               forKey:NSForegroundColorAttributeName];

    return result;

}


- (BOOL)tryEvent:(NSEvent *)event
{
    NSLog(@"Key down START %@ %@", event, [event className]);

    NSString *eventChars = [[event charactersIgnoringModifiers] uppercaseString];


    if ([eventChars length] > 0) {
        unichar eventChar = [eventChars characterAtIndex:0];

        NSLog(@"keyDown got char %c ", eventChar);
        NSIndexSet *revealedIndexes = [_word revealMaskForCharacter:eventChar];

        if ([revealedIndexes count] > 0) {
            NSLog(@"YES, char is found, revealing mask !  ");

            [_wordAnimationStatus addIndexesToBlink:revealedIndexes];
            [self startAnimationTimer];
            NSLog(@"Added indexes to blink, are any blinks left ? %d", [_wordAnimationStatus areAnyBlinksLeft]);
            return YES;
        } else {
            NSLog(@"No char found , sorry ");
            return NO;

        }

    }
    return NO;

}


- (NSSize)calculateStringSize:(NSString *)string withSpacing:(NSUInteger)spacing
{
    NSSize result = [string sizeWithAttributes:_attributes];

    if (string.length > 1) {
        result.width += (string.length - 1) * spacing;

    }
    return result;

}


- (void)drawWord:(NSString *)word inRect:(NSRect)rect
{
    NSSize wordSize = [self calculateStringSize:word withSpacing:kCharacterSpacing];
    NSPoint wordOrigin;
    
    wordOrigin.x = rect.origin.x + (rect.size.width - wordSize.width) / 2;
    wordOrigin.y = rect.origin.y + (rect.size.height - wordSize.height) / 2;



    for (NSUInteger i = 0; i < [word length]; i++) {
        unichar ch = [word characterAtIndex:i];
        NSString *chstr = [NSString stringWithFormat:@"%c", ch];

        NSPoint chOrigin = wordOrigin;

        if (i > 0) {
            NSSize wordSizeBefore = [self calculateStringSize:[word substringToIndex:i] withSpacing:kCharacterSpacing];
            chOrigin.x += wordSizeBefore.width + kCharacterSpacing;
        }


        if ([_wordAnimationStatus isBlinkedCharacterAtIndex:i]) {
            NSLog(@"Char at %d is blinked ! ", (unsigned long)i);

           if ([_wordAnimationStatus isBlinkOn]) {

               NSUInteger blinksLeft = [_wordAnimationStatus getBlinksLeftForCharacterAtIndex:i];
               [chstr drawAtPoint:chOrigin withAttributes:blinksLeft == 1 ? _attributes : _attributesForBlink];
           }

        } else {
            NSLog(@"Normal drawing char at %d ", (unsigned long)i);
            [chstr drawAtPoint:chOrigin withAttributes:_attributes];
        }
    }
}



- (void)animationTimerTick:(NSTimer *)timer
{
    NSLog(@"@CKWordView.animationTimerTick START ");
    [_wordAnimationStatus tick];
    if ([_wordAnimationStatus areAnyBlinksLeft]) {
        NSLog(@"There are  blinks LEFT ! ");
        [self setNeedsDisplay:YES];
    } else {
        [self stopAnimationTimer];
    }
}



- (void)drawRect:(NSRect)dirtyRect
{

    if (kDebug) {
        [[NSColor yellowColor] set];
        NSRectFill(dirtyRect);
       
    }
 
    // Drawing code here.
    NSRect bounds = [self bounds];
    [self drawWord:_word.maskedWord inRect:bounds];
}

@end
