//
// Created by Adam Folmert on 11/22/14.
// Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CKWordAnimationStatus : NSObject
{
}

- (instancetype)initWithCapacity:(NSUInteger)capacity;
- (void)addIndexesToBlink:(NSIndexSet *)indexSet;
- (BOOL)areAnyBlinksLeft;
- (NSUInteger)getBlinksLeftForCharacterAtIndex:(NSUInteger)index;
- (BOOL)isBlinkedCharacterAtIndex:(NSUInteger)index;
- (void)tick;

@property (nonatomic, assign) BOOL isBlinkOn;
@property (nonatomic, strong) NSMutableArray *blinksLeft;
@end

