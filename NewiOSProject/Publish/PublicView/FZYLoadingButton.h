//
//  FZYLoadingButton.h
//  NewiOSProject
//
//  Created by MAC on 2023/9/2.
//  Copyright © 2023 范智渊. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^LoadingButtonAction)(void);
NS_ASSUME_NONNULL_BEGIN

@interface FZYLoadingButton : UIView
//可用时背景色  default #0F1511
@property (nonatomic, strong)UIColor *enableBgColor;
//不可用时背景色 default #B5B7B6
@property (nonatomic, strong)UIColor *unableableBgColor;
//可用时字体颜色  default #FEFFCC
@property (nonatomic, strong)UIColor *enableTextColor;
//不可用时字体颜色  default #FEFFCC
@property (nonatomic, strong)UIColor *unableTextColor;

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont*)font titleLabelColor:(UIColor *)color backgoundColor:(UIColor *)bgColor action:(LoadingButtonAction)actionBlock;

-(void)startLoading;
-(void)endLoading;

@end

NS_ASSUME_NONNULL_END
