//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIView+Extension.m
//  MJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "UIView+MJExtension.h"

@implementation UIView (MJExtension)
- (void)setMj_x:(CGFloat)mj_x
{
    CGRect frame = self.frame;
    frame.origin.x = mj_x;
    self.frame = frame;
}

- (CGFloat)mj_x
{
    return self.frame.origin.x;
}

- (void)setMj_y:(CGFloat)mj_y
{
    CGRect frame = self.frame;
    frame.origin.y = mj_y;
    self.frame = frame;
}

- (CGFloat)mj_y
{
    return self.frame.origin.y;
}

- (void)setMj_w:(CGFloat)mj_w
{
    CGRect frame = self.frame;
    frame.size.width = mj_w;
    self.frame = frame;
}

- (CGFloat)mj_w
{
    return self.frame.size.width;
}

- (void)setMj_h:(CGFloat)mj_h
{
    CGRect frame = self.frame;
    frame.size.height = mj_h;
    self.frame = frame;
}

- (CGFloat)mj_h
{
    return self.frame.size.height;
}

- (void)setMj_size:(CGSize)mj_size
{
    CGRect frame = self.frame;
    frame.size = mj_size;
    self.frame = frame;
}

- (CGSize)mj_size
{
    return self.frame.size;
}

- (void)setMj_origin:(CGPoint)mj_origin
{
    CGRect frame = self.frame;
    frame.origin = mj_origin;
    self.frame = frame;
}

- (CGPoint)mj_origin
{
    return self.frame.origin;
}

/**  圆角 & 阴影 & 描边 --------！！！！！必须先设置好子视图frame！！！！！！-------  有问题！！*/
- (void)addShadowAndCornerToViewWithSuperView:(UIView *)superView cornerRadius:(CGFloat)cornerRadius shadowRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize )offset shadowOpacity:(CGFloat)opacity  borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    NSArray<CALayer *> *subLayers = superView.layer.sublayers;
    NSArray<CALayer *> *removedLayers = [subLayers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[CAShapeLayer class]];
    }]];
    [removedLayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    
 
    
    //1.给原视图设置圆角
    self.layer.cornerRadius = cornerRadius;
    self.contentMode=UIViewContentModeScaleAspectFill;
    self.clipsToBounds=YES;
    self.layer.borderWidth=borderWidth;
    self.layer.borderColor=borderColor.CGColor;
    
    //2.在父视图上给视图添加阴影
    CAShapeLayer *layer=[[CAShapeLayer alloc]init];
    layer.position=self.layer.position;
    layer.bounds=self.bounds;
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.cornerRadius=cornerRadius+1;//+1 纠正非代码切图的偏差,防止layer背景色跑色
    layer.shadowColor=shadowColor.CGColor;
    layer.shadowRadius=shadowRadius;
    layer.shadowOffset=offset;
    layer.shadowOpacity=opacity;
    
    [superView.layer addSublayer:layer];
    [superView bringSubviewToFront:self];
    
  
    
  
}



@end
