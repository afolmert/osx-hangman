//
// Created by Adam Folmert on 11/21/14.
// Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CKWord : NSObject

+ (instancetype)wordWithString:(NSString *)word;
- (instancetype)initWithString:(NSString *)word;
- (NSMutableIndexSet *)revealMaskForCharacter:(unichar)character;

- (NSString *)description;

@property (nonatomic, copy, readonly) NSString *word;
@property (nonatomic, copy, readonly) NSString *wordMask;
@property (nonatomic, copy, readonly, getter=getMaskedWord) NSString *maskedWord;


@end
