// 代码地址: https://github.com/CoderMJLee/MJRefresh
// 代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIView+Extension.h
//  MJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MJExtension)
@property (assign, nonatomic) CGFloat mj_x;
@property (assign, nonatomic) CGFloat mj_y;
@property (assign, nonatomic) CGFloat mj_w;
@property (assign, nonatomic) CGFloat mj_h;
@property (assign, nonatomic) CGSize mj_size;
@property (assign, nonatomic) CGPoint mj_origin;

- (void)addShadowAndCornerToViewWithSuperView:(UIView *)superView cornerRadius:(CGFloat)cornerRadius shadowRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize )offset shadowOpacity:(CGFloat)opacity borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

///** 圆角加阴影 -- 未实现*/
//- (void)addShadowAndCornerWhithSuperView:(UIView *)superView corner:(CGFloat)cornerRadius shadow:(CGFloat)shadowRadius shadowColor:(UIColor *)Color Offset:(CGSize )offset Opacity:(CGFloat)opacity;
//
///** 半透明描边 -- 未实现*/
//- (void)addBorderWithOpacity:(CGFloat)opacity andborderWidth:(CGFloat)width andColor:(UIColor *)color;


@end
