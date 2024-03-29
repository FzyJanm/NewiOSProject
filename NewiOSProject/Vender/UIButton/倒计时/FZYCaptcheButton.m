//
//  WLCaptcheButton.m
//  WLButtonCountingDownDemo
//
//  Created by 范智渊 on 16/1/14.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import "FZYCaptcheButton.h"
#import "FZYButtonCountdownManager.h"

@interface FZYCaptcheButton ()

@property (nonatomic, strong) UILabel *overlayLabel;

@end

@implementation FZYCaptcheButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _interval = 60;
        [self initialize];
    }
    
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _interval = 60;
        [self initialize];
    }
    
    return self;
}

- (void)dealloc {
    NSLog(@"***> %s [%@]", __func__, _identifyKey);
}

- (void)initialize {
    self.clipsToBounds      = YES;
    self.layer.cornerRadius = 4;
    self.opaque             = NO;
    
    [self addSubview:self.overlayLabel];
}

- (UILabel *)overlayLabel {
    if (!_overlayLabel) {
        _overlayLabel                 = [UILabel new];
        _overlayLabel.textColor       = self.titleLabel.textColor;
        _overlayLabel.backgroundColor = self.backgroundColor;
        _overlayLabel.font            = self.titleLabel.font;
        _overlayLabel.textAlignment   = NSTextAlignmentCenter;
        _overlayLabel.alpha           = 0;
        _overlayLabel.opaque           = NO;
    }
    
    return _overlayLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.overlayLabel.frame = self.bounds;
    
    if ([[FZYButtonCountdownManager defaultManager] countdownTaskExistWithKey:self.identifyKey task:nil]) {
        [self shouldCountDown];
    }
}


- (void)shouldCountDown {
    
    __weak __typeof(self) weakSelf = self;
    [[FZYButtonCountdownManager defaultManager] scheduledCountDownWithKey:self.identifyKey timeInterval:_interval countingDown:^(NSTimeInterval leftTimeInterval) {
        __strong __typeof(weakSelf) self = weakSelf;
        
        self.enabled             = NO;
        self.titleLabel.alpha    = 0;
        self.overlayLabel.alpha  = 1;
        [self.overlayLabel setBackgroundColor:self.disabledBackgroundColor ?: self.backgroundColor];
        [self.overlayLabel setTextColor:self.disabledTitleColor ?: self.titleLabel.textColor];
        self.overlayLabel.text = [NSString stringWithFormat:@"%@s", @(leftTimeInterval)];
        if(self.countStartBlock!=nil&&leftTimeInterval==_interval){
            self.countStartBlock();
        }
        
    } finished:^(NSTimeInterval finalTimeInterval) {
        __strong __typeof(weakSelf) self = weakSelf;
        if(self.countFinshBlock!=nil){
            self.countFinshBlock();
        }
        self.enabled             = YES;
        self.overlayLabel.alpha  = 0;
        self.titleLabel.alpha    = 1;
        [self.overlayLabel setBackgroundColor:self.backgroundColor];
        [self.overlayLabel setTextColor:self.titleLabel.textColor];
    }];
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (![[self actionsForTarget:target forControlEvent:UIControlEventTouchUpInside] count]) {
        return;
    }
    
    [super sendAction:action to:target forEvent:event];
}

- (void)fire {
    [self shouldCountDown];
}

@end
