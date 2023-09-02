//
//  WLCaptcheButton.h
//  WLButtonCountingDownDemo
//
//  Created by wayne on 16/1/14.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface FZYCaptcheButton : UIButton
@property (nonatomic, copy)void(^countStartBlock)(void);
@property (nonatomic, copy)void(^countFinshBlock)(void);
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, copy) IBInspectable NSString *identifyKey;
@property (nonatomic, strong) IBInspectable UIColor *disabledBackgroundColor;
@property (nonatomic, strong) IBInspectable UIColor *disabledTitleColor;

- (void)fire;

@end
