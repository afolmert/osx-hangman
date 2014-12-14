//
//  CKPaintView.m
//  Hangman
//
//  Created by Adam Folmert on 11/23/14.
//  Copyright (c) 2014 Adam Folmert. All rights reserved.
//

#import "CKPaintView.h"

@interface CKPaintView ()

@end


@implementation CKPaintView
{
    NSDictionary *_fontAttributes;
}



- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _counter = @0;
        _fontAttributes = [self initializeFontAttributes];
    }
    
    return self;
}



- (NSDictionary *)initializeFontAttributes
{
    NSMutableDictionary *result = [NSMutableDictionary new];
    [result setObject:[NSFont fontWithName:@"Courier"
                                      size:40]
               forKey:NSFontAttributeName];
    
    [result setObject:[NSColor blackColor]
               forKey:NSForegroundColorAttributeName];
    
    return result;
    
}

- (void)setCounter:(NSNumber*)counter
{
    _counter = counter;
    [self setNeedsDisplay:YES];
}


- (NSNumber *)getCounter
{
    return _counter;
}


- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor yellowColor] set];
    NSRectFill(dirtyRect);
    
    NSString *s = [NSString stringWithFormat:@"%d", [_counter intValue]];
    
    [s drawAtPoint:NSMakePoint(10, 10) withAttributes:_fontAttributes];    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // necessary for animations
    return;
}
@end
