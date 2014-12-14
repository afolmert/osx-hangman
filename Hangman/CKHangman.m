//
// Created by Adam Folmert on 11/21/14.
// Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import "CKHangman.h"


const int kMaxHangmanState = 6;
const int kImagePartWidth = 78;
const int kImagePartHeight = 92;


@implementation CKHangman
{

    NSImage *_image;
    NSUInteger _state;

}

- (instancetype)init
{
    self = [super init];
    if (self != nil) {

        _state = 0;
    }
    return self;


}


- (NSImage *)loadImage
{
    NSString *imageName = [[NSBundle mainBundle]
            pathForResource:@"hangman" ofType:@"jpg"];

    NSImage *image = [[NSImage alloc] initWithContentsOfFile:imageName];
    NSLog(@"Loaded image %@", _image);
    return image;

}


- (NSImage *)getImage
{
    if (_image == nil) {
        _image = [self loadImage];
    }
    return _image;
}


- (void)drawImagePart:(NSUInteger)part inRect:(NSRect)destRect
{
    UInt partsCount = 7;

    NSRect partRect;

    if (part <= partsCount) {
        partRect = NSMakeRect(part * kImagePartWidth, 0, kImagePartWidth, kImagePartHeight);
    } else {
        partRect = NSMakeRect(0, 0, kImagePartWidth, kImagePartHeight);
    }

    NSImage *image = [self getImage];
    [image drawInRect:destRect fromRect:partRect operation:NSCompositeSourceOver fraction:1];

}



- (BOOL)increase
{
    if (_state <= kMaxHangmanState) {
        _state++;
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)decrease
{
    if (_state > 0) {
        _state--;
        return YES;
    } else {
        return NO;

    }

}



- (void)drawInRect:(NSRect)destRect
{
    [self drawImagePart:(kMaxHangmanState - _state) inRect:destRect];

}




@end
