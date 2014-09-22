//
//  GridView.m
//  ColorGame
//
//  Created by louis on 14-7-31.
//  Copyright (c) 2014年 louis. All rights reserved.
//

#import "GridView.h"
#import "GridTable.h"
#import "Grid.h"
#import <QuartzCore/QuartzCore.h>

@interface GridView ()

@property (nonatomic, strong) NSArray *gridButtons;
@property (nonatomic, readwrite) BOOL paused;

@end

@implementation GridView

- (void)awakeFromNib
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

#pragma mark - Properties
- (NSArray *)gridButtons
{
    if (!_gridButtons) {
        _gridButtons = [[NSArray alloc] init];
    }
    return _gridButtons;
}

- (void)setGridTable:(GridTable *)gridTable
{
    _gridTable = gridTable;
    [self setupGrids];
}


- (void)setupGrids
{
    self.paused = NO;
    NSUInteger size = self.gridTable.size;
    CGFloat sideLength = (self.frame.size.width - [self gridTableOffset] * 2 - (size - 1) * [self gridTableInset]) / size;
    CGFloat x = [self gridTableOffset];
    CGFloat y = x;
    
    // Clear
    for (UIButton *buttons in self.gridButtons) {
        [buttons removeFromSuperview];
    }
    
    NSMutableArray *gridButtons = [[NSMutableArray alloc] init];
    // set up
    for (Grid *grid in self.gridTable.grids) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, y, sideLength, sideLength); 
        button.backgroundColor = grid.color;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 2.f;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
        [gridButtons addObject:button];
        [self addSubview:button];
        
        x += sideLength + [self gridTableInset];
        if (gridButtons.count % size == 0) {
            y += sideLength + [self gridTableInset];
            x = [self gridTableOffset];
        }
    }
    
    self.gridButtons = gridButtons;
}

#pragma mark - Methods

- (void)pause
{
    self.paused = YES;
    for (UIButton *button in self.gridButtons) {
        [UIView animateWithDuration:drand48() animations:^{
            button.alpha = 0.0;
        }];
    }
}

- (void)resume
{
    self.paused = NO;
    for (UIButton *button in self.gridButtons) {
        button.alpha = 1.0;
    }
}

#pragma mark - Helpers
- (CGFloat)gridTableOffset { return 5.f; }
- (CGFloat)gridTableInset { return 3.f; }
- (CGFloat)cornerRadius { return 3.f; }

#pragma mark - Handle Actions
- (void)clickAction: (UIButton *)button
{
    NSUInteger index = [self.gridButtons indexOfObject:button];
    
    if ([_delegate respondsToSelector:@selector(gridView:didClickButtonAtIndex:)]) {
        [_delegate gridView:self didClickButtonAtIndex:index];
    }    
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundRect addClip];
    
    [[UIColor whiteColor] setStroke];
    [roundRect stroke];
    
    [[UIColor whiteColor] setFill];
    [roundRect fill];
}


@end
