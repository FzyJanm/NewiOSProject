//
//  FZYLoadingButton.m
//  NewiOSProject
//
//  Created by MAC on 2023/9/2.
//  Copyright © 2023 范智渊. All rights reserved.
//

#import "FZYLoadingButton.h"
#import <QuartzCore/QuartzCore.h>

@interface FZYLoadingButton()
//@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UIImageView *loadingImgV;
@property (nonatomic,strong)LoadingButtonAction clickBlock;
@end
@implementation FZYLoadingButton

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font titleLabelColor:(UIColor *)color backgoundColor:(nonnull UIColor *)bgColor action:(nonnull LoadingButtonAction)actionBlock {
    if(self = [super initWithFrame:frame]){
        self.enableBgColor = Button_ENABLE_BG_COLOR();
        self.enableTextColor = Button_ENABLE_TEXTCOLOR();
        self.unableTextColor = Button_UNABLE_TEXTCOLOR();
        self.unableableBgColor = Button_UNABLE_BG_COLOR();
        self.backgroundColor = bgColor;
        _contentView = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, frame.size.width, frame.size.height))];
        [self addSubview:_contentView];
        WeakSelf;
        [_contentView tapAction:^(UIView *sender) {
            [weakSelf startLoading];
            actionBlock();
        }];
        
        _titleLable = [FZYControl createAutoWidthLabelWithOrgin:CGPointZero Font:font Text:title color:color];
        _titleLable.text = title;
        _titleLable.font = font;
        [_contentView addSubview:_titleLable];
        _titleLable.center = (CGPointMake(frame.size.width/2, frame.size.height/2));
      
        _loadingImgV = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, 13, 13))];
        _loadingImgV.contentMode = UIViewContentModeScaleAspectFill;
        _loadingImgV.left = _titleLable.right+5;
        _loadingImgV.centerY = _titleLable.centerY;
        [_contentView addSubview:_loadingImgV];
        
      
        _loadingImgV.hidden = YES;
       
      
        
    }
    return self;
}
-(void)startLoading{
   
    [_loadingImgV setHidden:NO];
    CALayer *loadingLayer = [CALayer layer];
    loadingLayer.bounds = CGRectMake(0, 0, _loadingImgV.width, _loadingImgV.height);
    loadingLayer.position = CGPointMake(_loadingImgV.bounds.size.width / 2, _loadingImgV.bounds.size.height / 2);
    loadingLayer.contents = (id)[UIImage imageNamed:@"button_loading"].CGImage; // 使用你自己的加载图片
    [_loadingImgV.layer addSublayer:loadingLayer];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    rotationAnimation.keyPath = @"transform.rotation.x";
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 2.0; // 旋转一圈所需的时间
    rotationAnimation.repeatCount = HUGE_VALF; // 无限循环
    [loadingLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    self.userInteractionEnabled = NO;
    self.backgroundColor = self.unableableBgColor;
    self.titleLable.textColor = self.unableTextColor;
}
-(void)endLoading{
    [_loadingImgV setHidden:YES];
    self.userInteractionEnabled = YES;
    self.backgroundColor = self.enableBgColor;
    self.titleLable.textColor = self.enableTextColor;
}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//    WeakSelf;
//    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(weakSelf.contentView);
//    }];
//
//    [_loadingImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(weakSelf.titleLable.mas_right).offset(4);
//        make.centerY.equalTo(weakSelf.titleLable.mas_centerY);
//    }];
//}
@end
