//
//  RefreshButton.m
//  ColorGame
//
//  Created by louis on 14-8-1.
//  Copyright (c) 2014年 louis. All rights reserved.
//

#import "RefreshButton.h"

@implementation RefreshButton

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
    self.backgroundColor = nil;
    self.opaque = NO;
    [self setTitle:@"" forState:UIControlStateNormal];
    if (self.frame.size.width != self.frame.size.height) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.width);
    }
}

#define SCALE_FACTOR    0.6
#define TRIANGLE_SATANDARD_SIDE_LENGTH  10

- (CGFloat)triangleSideLength { return TRIANGLE_SATANDARD_SIDE_LENGTH * SCALE_FACTOR; }

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    [circle addClip];
    
    circle.lineWidth = 2.f;
    
    [[UIColor blackColor] setStroke];
    [circle stroke];
    
    UIBezierPath *arc = [UIBezierPath bezierPath];
    
    [arc addArcWithCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:self.frame.size.width / 2 * SCALE_FACTOR startAngle:0.3 * M_PI endAngle:2 * M_PI clockwise:YES];
    [arc stroke];
    
    UIBezierPath *triangle = [UIBezierPath bezierPath];
    CGPoint a = CGPointMake(self.frame.size.width / 2 + self.frame.size.width / 2 * SCALE_FACTOR - [self triangleSideLength] / 2, self.frame.size.height / 2);
    CGPoint b = CGPointMake(a.x + [self triangleSideLength], a.y);
    CGPoint c = CGPointMake(a.x + [self triangleSideLength] / 2, a.y + [self triangleSideLength] * 1.7 / 2);
    [triangle moveToPoint:a];
    [triangle addLineToPoint:b];
    [triangle addLineToPoint:c];
    [triangle addLineToPoint:a];
    [[UIColor blackColor] setFill];
    [triangle fill];

}


@end
