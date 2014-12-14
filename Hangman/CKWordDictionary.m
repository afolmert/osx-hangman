//
// Created by Adam Folmert on 11/22/14.
// Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import "CKWordDictionary.h"
#import "NSArray+CKUtils.h"


@implementation CKWordDictionary
{
    NSArray *_words;

}

- (instancetype)init
{
    self = [super init];
    if (self != nil) {

        _words = [self loadWords];

        if ([_words count] == 0) {
            [NSException raise:@"Cannot load words" format:@"Problem encountered"];
        }

    }
    return self;
}

- (NSArray *)loadWords
{
    NSString *wordsFileName =
            [[NSBundle mainBundle] pathForResource:@"words_de" ofType:@"txt"];

    NSString *words = [NSString stringWithContentsOfFile: wordsFileName];

    NSArray *result = [words componentsSeparatedByString:@"\n"];
    return result;

}


- (void)dumpWords
{
    NSLog(@"Dumping words ");
    for (NSString *word  in _words) {
        NSLog(@"%@", word);
    }

}



- (NSString *)randomWord
{
    return [_words randomObject];
}

@end