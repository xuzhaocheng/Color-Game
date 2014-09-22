//
//  ViewController.m
//  ColorGame
//
//  Created by louis on 14-7-31.
//  Copyright (c) 2014年 louis. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "GridTable.h"
#import "Grid.h"
#import "GridView.h"

#import "PlayButton.h"

#define MAX_SIZE    9
#define MIN_LEVEL   1

#define CORNER_RADIUS   3.0f

@interface ViewController () <GridViewDelegate, PlayButtonDelegate>

@property (weak, nonatomic) IBOutlet GridView *gridView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;

@property (weak, nonatomic) IBOutlet PlayButton *playButton;

@property (weak, nonatomic) IBOutlet UIView *resultView;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UIButton *tryAgainButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (strong, nonatomic) UIView *maskView;
@property (strong, nonatomic) UILabel *counterLabel;


@property (nonatomic, strong) GridTable *gridTable;
@property (nonatomic) NSUInteger size;
@property (nonatomic) NSUInteger level;
@property (nonatomic) NSUInteger skipTimes;

@property (nonatomic, strong) NSTimer *countTimer;
@property (nonatomic) NSUInteger leftSeconds;
@property (nonatomic) NSInteger score;

@property (nonatomic, strong) NSTimer *prepareTimer;
@property (nonatomic) NSUInteger prepareSeconds;

@end

@implementation ViewController


#pragma mark - Propeties
- (void)setScore:(NSInteger)score
{
    _score = score;
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)_score];
}

- (void)setLeftSeconds:(NSUInteger)leftSeconds
{
    _leftSeconds = leftSeconds;
    self.timeLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)_leftSeconds];
}

- (void)setSkipTimes:(NSUInteger)skipTimes
{
    _skipTimes = skipTimes;
    if (_skipTimes == 0) {
        self.skipButton.enabled = NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.985 alpha:1.0];
    
    self.playButton.delegate = self;
    self.gridView.delegate = self;

    
    [self setupResultView];
    [self setupMaskView];
    [self startGame];
}

#define GAME_DURATION_SECONDS   60
#define MAX_SKIP_TIMES          3

- (void)setup
{
    self.leftSeconds = GAME_DURATION_SECONDS;

    self.score = 0;
    self.prepareSeconds = 4;
    self.skipTimes = MAX_SKIP_TIMES;
    self.skipButton.enabled = YES;
    self.playButton.paused = NO;
    
    self.size = 3;
    self.level = 50;
}

- (void)setupMaskView
{
    self.maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.maskView.backgroundColor = [UIColor whiteColor];
    self.maskView.alpha = 0.9;
    [self.view addSubview:self.maskView];
 
    self.counterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    self.counterLabel.center = CGPointMake(self.maskView.frame.size.width / 2, self.maskView.frame.size.height / 2);
    self.counterLabel.textAlignment = NSTextAlignmentCenter;
    self.counterLabel.font = [UIFont fontWithName:@"Heiti TC" size:100.f];
    self.counterLabel.backgroundColor = [UIColor clearColor];
    [self.maskView addSubview:self.counterLabel];
    
}

- (void)setupResultView
{
    self.resultView.backgroundColor = self.view.backgroundColor;
    [self.shareButton.layer setMasksToBounds:YES];
    [self.shareButton.layer setCornerRadius:CORNER_RADIUS];
    [self.tryAgainButton.layer setMasksToBounds:YES];
    [self.tryAgainButton.layer setCornerRadius:CORNER_RADIUS];
}

- (void)startGame
{
    [self setup];
    self.counterLabel.text = @"3";
    self.maskView.hidden = NO;
    self.prepareTimer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(prepareTimeCounter) userInfo:nil repeats:YES];
}

#pragma mark - Helpers
- (void)nextGridTable
{
    CGFloat red, green, blue;
    red = arc4random() % 256;
    green = arc4random() % 256;
    blue = arc4random() % 256;
    
    CGFloat distinctRed, distinctGreen, distinctBlue;
    distinctRed = [self getDistinctRGBColor:red];
    distinctGreen = [self getDistinctRGBColor:green];
    distinctBlue = [self getDistinctRGBColor:blue];
    
    UIColor *color = [UIColor colorWithRed:red / 256.0 green:green / 256.0 blue:blue / 256.0 alpha:1.0f];
    
    UIColor *distinctColor = [UIColor colorWithRed:distinctRed / 256.0 green:distinctGreen / 256.0 blue:distinctBlue / 256.0 alpha:1.0f];
    
    GridTable *gridTable = [[GridTable alloc] initWithNumber:self.size color:color DistinctColor:distinctColor];
    self.gridTable = gridTable;
    
    self.gridView.gridTable = gridTable;
    
}

#define ERROR_RANGE     10
- (CGFloat)getDistinctRGBColor: (CGFloat)value
{
    NSUInteger difference = arc4random() % ERROR_RANGE;
    
    if (difference % 2 == 0) {
        if (value + difference + self.level < 256) {
            return value + difference + self.level;
        } else if (value - difference - self.level >= 0) {
            return value - difference - self.level;
        } else {
            return 0;
        }
    } else {
        if (value - difference - self.level >= 0) {
            return value - difference - self.level;
        } else if (value + difference + self.level < 256) {
            return value + difference + self.level;
        } else {
            return 0;
        }
    }

}


- (void)hidePrepareView
{
    [self.prepareTimer invalidate];
    self.prepareTimer = nil;
    self.maskView.hidden = YES;
    self.countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeCounter) userInfo:nil repeats:YES];
    
    [self nextGridTable];
}

#pragma mark - PlayButton delegate
- (void)didButtonTurnToPlay
{
    [self.countTimer setFireDate:[NSDate date]];
    [self.gridView resume];
    self.skipButton.enabled = YES;
}

- (void)didButtonTurnToPause
{
    [self.countTimer setFireDate:[NSDate distantFuture]];
    self.skipButton.enabled = NO;
    [self.gridView pause];
}

#pragma mark - Handle Actions
- (IBAction)skipAction:(id)sender
{
    self.score--;
    self.skipTimes--;
    [self nextGridTable];
}

- (IBAction)tryAgainAction:(id)sender
{
    self.resultView.hidden = YES;
    self.resultView.alpha = 0.0;
    [self startGame];
}

- (IBAction)shareAction:(id)sender
{
    
}

- (IBAction)restartAction:(id)sender
{
    [self.gridView pause];
    if (self.resultView.hidden == NO) {
        self.resultView.hidden = YES;
        self.resultView.alpha = 0.0;
    }
    
    [_countTimer invalidate];
    _countTimer = nil;
    [self startGame];
}


#pragma mark - Timer
- (void)timeCounter
{
    self.leftSeconds--;
    if (_leftSeconds == 0) {
        [_countTimer invalidate];
        _countTimer = nil;
        
        [self.gridView pause];
        self.levelLabel.text = [NSString stringWithFormat:@"Level: %ld", (long)self.score];
        [UIView animateWithDuration:0.5 animations:^{
            [self.view bringSubviewToFront:self.resultView];
            self.resultView.hidden = NO;
            self.resultView.alpha = 1.0;
        }];
    }
}

- (void)prepareTimeCounter
{
    if (self.prepareSeconds > 2) {
        self.counterLabel.text = [NSString stringWithFormat:@"%lu", self.prepareSeconds - 2];
    } else if (self.prepareSeconds == 2){
        self.counterLabel.text = @"Go!";
    }
    self.prepareSeconds--;
    if (self.prepareSeconds == 0) {
        [self hidePrepareView];
    }
    
}

#pragma makr - GridView delegate
- (void)gridView:(UIView *)view didClickButtonAtIndex:(NSUInteger)index
{
    if ([self.gridTable isDistinctGrid:self.gridTable.grids[index]]) {
        self.score++;
        if (_size < MAX_SIZE) _size ++;
        if (_level > MIN_LEVEL) _level--;
        [self nextGridTable];
    }

}

@end
