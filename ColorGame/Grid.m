//
//  Grid.m
//  ColorGame
//
//  Created by louis on 14-7-31.
//  Copyright (c) 2014年 louis. All rights reserved.
//

#import "Grid.h"

@interface Grid ()
@property (nonatomic, readwrite, strong) UIColor *color;
@property (nonatomic, readwrite, getter = isDistinct) BOOL distinct;
@end

@implementation Grid

- (id)initWithColor: (UIColor *)color isDistinct: (BOOL)distinct
{
    self = [super init];
    if (self) {
        self.color = color;
        self.distinct = distinct;
    }
    return self;
}

@end
