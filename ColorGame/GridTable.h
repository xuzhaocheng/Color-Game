//
//  GridTable.h
//  ColorGame
//
//  Created by louis on 14-7-31.
//  Copyright (c) 2014年 louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Grid;

@interface GridTable : NSObject

@property (nonatomic, strong) NSArray *grids;
@property (nonatomic) NSUInteger size;

- (id)initWithNumber: (NSUInteger)size color: (UIColor *)color DistinctColor: (UIColor *)distinctColor;
- (BOOL)isDistinctGrid: (Grid *)grid;

@end
