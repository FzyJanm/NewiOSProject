
/* --- UIView 分类 --- */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#pragma mark - 分类
#pragma mark -
@interface UIView (YX_UIViewCategory)
/** 圆角半径 */
@property (nonatomic, assign) CGFloat cornerRadius;
/** 边线宽度 */
@property (nonatomic, assign) IBInspectable CGFloat bWidth;
/** 边线颜色 */
@property (nonatomic, strong) IBInspectable UIColor *bColor;
/** 是否选中 */
@property (nonatomic, assign) IBInspectable BOOL isChecked;
/** 选中背景色 */
@property (nonatomic, strong) IBInspectable UIColor *sbgColor;
/** 未选中背景色 */
@property (nonatomic, strong) IBInspectable UIColor *nbgColor;
- (void)makeCornerRadius:(CGFloat)cornerRadius;

/**
 把View加在Window上
 */
- (void)yx_addToWindow;
/**
 拿到此控件所在的父控制器
 
 @return 父控制器
 */
- (UIViewController *)yx_viewInViewController;

/**
 View截图

 @return 截图Image
 */
- (UIImage *)yx_screenshot;
/**
 View截图(指定范围截图)
 
 @param frame 指定范围
 @return 截图Image
 */
- (UIImage *)yx_screenshotInFrame:(CGRect)frame;
/**
 ScrollView截图

 @param contentOffset 偏移量
 @return 截图Image
 */
- (UIImage *)yx_screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset;
@end

#pragma mark - 尺寸
#pragma mark -
@interface UIView (YX_UIViewFrame)
- (CGFloat)left;
- (CGFloat)right;
- (CGSize)size;
- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)centerX;
- (CGFloat)centerY;
- (CGFloat)maxX;
- (CGFloat)maxY;
- (void)setLeft:(CGFloat)left;
- (void)setRight:(CGFloat)right;
- (void)setSize:(CGSize)size;
- (void)setTop:(CGFloat)top;
- (void)setBottom:(CGFloat)bottom;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (void)setOrigin:(CGPoint)point;
- (void)setAddTop:(CGFloat)top;
- (void)setAddLeft:(CGFloat)left;
- (void)setRoundedCorners:(UIRectCorner)corners radii:(CGFloat)radii;
-(void)addSubviews:(NSArray *)views;
@end

#pragma mark - 动画
#pragma mark -
@interface UIView (YX_UIViewAnimation)
/**
 抖动动画(左右抖动)
 */
- (void)yx_animationShake;
/**
 旋转180度
 */
- (void)yx_animationTrans180;
@end

#pragma mark - HUD
#pragma mark -
@interface UIView (YX_UIViewHUD)
/**
 HUD展示
 */
- (void)yx_showHUD;
/**
 HUD隐藏
 */
- (void)yx_hideHUD;
/**
 HUD展示(带文字)
 
 @param textStr 展示的文字
 */
- (void)yx_showHUDWithText:(NSString *)textStr;
/**
 HUD提示(开发中)
 */
- (void)yx_showHUDWithDevelopment;

@end
NS_ASSUME_NONNULL_END
