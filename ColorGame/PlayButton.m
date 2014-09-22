//
//  PlayButton.m
//  ColorGame
//
//  Created by louis on 14-8-1.
//  Copyright (c) 2014年 louis. All rights reserved.
//

#import "PlayButton.h"

@interface PlayButton ()

@end

@implementation PlayButton

#pragma mark - Properties
- (void)setPaused:(BOOL)paused
{
    _paused = paused;
    [self setNeedsDisplay];
}

#pragma mark - Initialation
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.paused = NO;
    self.contentMode = UIViewContentModeRedraw;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
    [self addGestureRecognizer:tapGesture];
}

- (void)clickAction
{
    self.paused = !self.paused;
    if ([_delegate respondsToSelector:@selector(didButtonTurnToPause)] && self.paused) {
        [_delegate didButtonTurnToPause];
    } else if ([_delegate respondsToSelector:@selector(didButtonTurnToPlay)]) {
        [_delegate didButtonTurnToPlay];
    }
}



#pragma mark - Drawing



- (void)drawRect:(CGRect)rect
{
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    [circle addClip];
    
    circle.lineWidth = 2.f;
    
    [[UIColor blackColor] setStroke];
    if (self.paused) {
        UIBezierPath *triangle = [UIBezierPath bezierPath];
        CGPoint a = CGPointMake(self.frame.size.width / 3, self.frame.size.height / 4);
        CGPoint b = CGPointMake(self.frame.size.width / 3, self.frame.size.height / 4 * 3);
        CGPoint c = CGPointMake(self.frame.size.width * 0.76, self.frame.size.height / 2);
        [triangle moveToPoint:a];
        [triangle addLineToPoint:b];
        [triangle addLineToPoint:c];
        [triangle addLineToPoint:a];
        [[UIColor blackColor] setFill];
        [triangle fill];
    } else {
        [circle moveToPoint:CGPointMake(self.frame.size.width / 5 * 2, self.frame.size.height / 4)];
        [circle addLineToPoint:CGPointMake(self.frame.size.width / 5 * 2, self.frame.size.height / 4 * 3)];
        
        [circle moveToPoint:CGPointMake(self.frame.size.width / 5 * 3, self.frame.size.height / 4)];
        [circle addLineToPoint:CGPointMake(self.frame.size.width / 5 * 3, self.frame.size.height / 4 * 3)];
    }
    [circle stroke];
    
}


@end
