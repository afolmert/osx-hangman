//
// Created by Adam Folmert on 11/21/14.
// Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import "CKWord.h"
#import "NSString+CKUtils.h"


@implementation CKWord
{
    NSString *_word;
    NSMutableString *_wordMask;

    NSString *_hiddenMarker;
    NSString *_revealedMarker;
}

+ (instancetype)wordWithString:(NSString *)word
{
    return [[CKWord new] initWithString:word];
}

- (instancetype)init
{
    self = [self initWithString:@"NONE"];
    return self;
}

- (instancetype)initWithString:(NSString *)word
{
    self = [super init];
    if (self != nil) {

        _hiddenMarker = @"#";
        _revealedMarker = @"_";
        _word = [word copy];

        [self resetMask];

    }
    return self;

}


- (void)clearMask
{
    _wordMask = [[_revealedMarker repeatTimes:[_word length]] mutableCopy];

}

- (void)resetMask
{
    _wordMask = [[_hiddenMarker repeatTimes:[_word length]] mutableCopy];

}


- (NSMutableIndexSet *)revealMaskForCharacter:(unichar)character
{
    NSMutableIndexSet *result = [NSMutableIndexSet new];

    for (NSUInteger i = 0; i < [_word length]; i++) {

        if ([_word characterAtIndex:i] == character && [self isHiddenCharacterAtIndex:i]) {
            [self revealCharacterAtIndex:i];
            [result addIndex:i];
        }

    }
    return result;

}

- (BOOL)isHiddenCharacterAtIndex:(NSUInteger)index
{
    return ([_wordMask characterAtIndex:index] == [_hiddenMarker characterAtIndex:0]);
}


- (void)hideCharacterAtIndex:(NSUInteger)index
{
    [_wordMask replaceCharactersInRange:NSMakeRange(index, 1) withString:_hiddenMarker];
}


- (BOOL)isRevealedCharacterAtIndex:(NSUInteger)index
{
    return ![self isHiddenCharacterAtIndex:index];
}

- (void)revealCharacterAtIndex:(NSUInteger)index
{
    [_wordMask replaceCharactersInRange:NSMakeRange(index, 1) withString:_revealedMarker];
}



- (NSString *)getMaskedWord
{
    NSMutableString *result = [NSMutableString new];

    for (NSUInteger i = 0; i < [_word length]; i++) {
        if ([self isHiddenCharacterAtIndex:i]) {
            [result appendString:@"_"];
        } else {
            [result appendFormat:@"%c", [_word characterAtIndex:i]];
        }

    }

    return result;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"Word: >%@< Mask: >%@<",
                    _word,
                    _wordMask];
}

@end