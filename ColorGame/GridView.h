//
//  GridView.h
//  ColorGame
//
//  Created by louis on 14-7-31.
//  Copyright (c) 2014年 louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GridTable;

@protocol GridViewDelegate <NSObject>

- (void)gridView: (UIView *)view didClickButtonAtIndex: (NSUInteger)index;

@end

@interface GridView : UIView

@property (nonatomic) id <GridViewDelegate> delegate;
@property (nonatomic, strong) GridTable *gridTable;
@property (nonatomic, readonly, getter = isPaused) BOOL paused;

- (void)pause;
- (void)resume;

@end
