//
//  Grid.h
//  ColorGame
//
//  Created by louis on 14-7-31.
//  Copyright (c) 2014年 louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Grid : NSObject

@property (nonatomic, strong, readonly) UIColor *color;
@property (nonatomic, readonly, getter = isDistinct) BOOL distinct;

- (id)initWithColor: (UIColor *)color isDistinct: (BOOL)distinct;

@end
