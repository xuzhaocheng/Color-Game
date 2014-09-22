//
//  PlayButton.h
//  ColorGame
//
//  Created by louis on 14-8-1.
//  Copyright (c) 2014年 louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayButtonDelegate <NSObject>

- (void)didButtonTurnToPlay;
- (void)didButtonTurnToPause;

@end

@interface PlayButton : UIView

@property (nonatomic) BOOL paused;
@property (nonatomic) id <PlayButtonDelegate> delegate;

@end
