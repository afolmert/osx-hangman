//
// Created by Adam Folmert on 11/22/14.
// Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import "CKWordAnimationStatus.h"

const NSUInteger kBlinkRepeats = 4;


@implementation CKWordAnimationStatus

- (instancetype)initWithCapacity:(NSUInteger)capacity
{
    self = [super init];
    if (self != nil)  {
        _isBlinkOn = NO;
        _blinksLeft = [NSMutableArray new];

        for (NSUInteger i = 0; i < capacity; i++) {
            _blinksLeft[i] = @0;
        }

    }
    return self;
}

- (void)addIndexesToBlink:(NSIndexSet *)indexSet
{
    NSLog(@"addIndexesToBlink START for %@", indexSet);
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        _blinksLeft[idx] = [NSNumber numberWithInt:kBlinkRepeats];
        NSLog(@"Setting index %ld to %d", (unsigned long)idx, [_blinksLeft[idx] intValue]);
    }];
}

- (BOOL)areAnyBlinksLeft
{
    BOOL result = false;
    for (NSUInteger i = 0; i < [_blinksLeft count]; i++) {
        if ([_blinksLeft[i] intValue]  > 0) {
            result = true;
            break;
        }
    }
    return result;

}

- (BOOL)isBlinkedCharacterAtIndex:(NSUInteger)index
{
    return [_blinksLeft[index] intValue]  > 0;

}

- (NSUInteger)getBlinksLeftForCharacterAtIndex:(NSUInteger)index
{
    return [_blinksLeft[index] intValue];
}


- (void)tick
{

    NSLog(@"CKWordAnimationStatus TICK ");
    _isBlinkOn = !_isBlinkOn;
    if (_isBlinkOn) {
        return;
    }
    for (NSUInteger i = 0; i < [_blinksLeft count]; i++) {
        if ([_blinksLeft[i] intValue] > 0) {
            _blinksLeft[i] = [NSNumber numberWithInt:[_blinksLeft[i] intValue] - 1];
        }
    }
}
@end


