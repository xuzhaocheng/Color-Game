//
//  SkipButton.m
//  ColorGame
//
//  Created by louis on 14-8-1.
//  Copyright (c) 2014年 louis. All rights reserved.
//

#import "SkipButton.h"

@implementation SkipButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    [self setTitle:@"" forState:UIControlStateNormal];
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self setNeedsDisplay];
}

#define STANDARD_WIDTH      60
#define STANDARD_OFFSETX    0
#define STANDARD_OFFSETY    7
#define STANDARD_ARROW_SIDE 8

- (CGFloat)scaleFactor { return self.frame.size.width / STANDARD_WIDTH; }
- (CGFloat)offsetX { return STANDARD_OFFSETX * [self scaleFactor]; }
- (CGFloat)offsetY { return STANDARD_OFFSETY * [self scaleFactor]; }
- (CGFloat)arrowSide { return STANDARD_ARROW_SIDE * [self scaleFactor]; }

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *skipArrow = [UIBezierPath bezierPath];
    
    if (self.enabled) {
        [[UIColor blackColor] setFill];
        [[UIColor blackColor] setStroke];
    } else {
        [[UIColor lightGrayColor] setFill];
        [[UIColor lightGrayColor] setStroke];
    }
    
    CGPoint a = CGPointMake([self offsetX], [self offsetY]);
    CGPoint b = CGPointMake(self.frame.size.width / 2, a.y);
    [skipArrow moveToPoint:a];
    [skipArrow addLineToPoint:b];
    
    CGPoint c = CGPointMake(b.x, self.frame.size.height - [self offsetY]);
    CGPoint d = CGPointMake(self.frame.size.width - [self offsetX], c.y);
    [skipArrow addLineToPoint:c];
    [skipArrow addLineToPoint:d];

    [skipArrow stroke];
    
    UIBezierPath *arrow = [UIBezierPath bezierPath];
    
    CGPoint e = CGPointMake(d.x - [self arrowSide] * 0.94, c.y - [self arrowSide] * 0.34);
    CGPoint f = CGPointMake(e.x, c.y + [self arrowSide] * 0.34);
    [arrow moveToPoint:e];
    [arrow addLineToPoint:f];
    [arrow addLineToPoint:d];
    [arrow stroke];
    [arrow fill];
    
    
}


@end
