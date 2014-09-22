//
//  GridTable.m
//  ColorGame
//
//  Created by louis on 14-7-31.
//  Copyright (c) 2014年 louis. All rights reserved.
//

#import "GridTable.h"

#import "Grid.h"

@interface GridTable ()

@end

@implementation GridTable

- (id)initWithNumber: (NSUInteger)size color: (UIColor *)color DistinctColor: (UIColor *)distinctColor
{
    self = [super init];
    if (self) {
        self.size = size;
        NSUInteger number = size * size;
        NSMutableArray *gridsArray = [[NSMutableArray alloc] init];
        NSUInteger distinct = arc4random() % number;
        for (NSUInteger i = 0; i < number; i++) {
            Grid *grid;
            if (i == distinct) {
                grid = [[Grid alloc] initWithColor:distinctColor isDistinct:YES];
            } else {
                grid = [[Grid alloc] initWithColor:color isDistinct:NO];
            }
            [gridsArray addObject:grid];
        }
        
        self.grids = [[NSArray alloc] initWithArray:gridsArray];
    }
    return self;
}

- (BOOL)isDistinctGrid: (Grid *)grid
{
    return [grid isDistinct];
}

@end
