
#import "UIView+Category.h"

@implementation UIView (YX_UIViewCategory)

- (void)makeCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
-(void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
- (void)setBColor:(UIColor *)bColor {
    self.layer.borderColor = bColor.CGColor;
}
- (UIColor *)bColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
- (void)setBWidth:(CGFloat)bWidth {
    self.layer.borderWidth = bWidth;
}
-(void)tapAction:(viewTapActionBlock)actionBlock
{
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        actionBlock(sender);
    }];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:ges];
}
- (CGFloat)bWidth {
    return self.layer.borderWidth;
}
- (void)setSbgColor:(UIColor *)sbgColor {
    objc_setAssociatedObject(self, @selector(sbgColor), sbgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)sbgColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNbgColor:(UIColor *)nbgColor {
    objc_setAssociatedObject(self, @selector(nbgColor), nbgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)nbgColor {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setIsChecked:(BOOL)isChecked {
    NSNumber *number = [NSNumber numberWithBool:isChecked];
    objc_setAssociatedObject(self, @selector(isChecked), number, OBJC_ASSOCIATION_ASSIGN);
    
    self.backgroundColor = isChecked ? self.sbgColor : self.nbgColor;
}
- (BOOL)isChecked {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    return [number boolValue];
}
- (void)yx_addToWindow {
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(window)]) {
        UIWindow * window = (UIWindow *) [appDelegate performSelector:@selector(window)];
        [window addSubview:self];
    }
}
- (UIViewController *)yx_viewInViewController {
    // 获取下一个响应者对象
    UIResponder *resp = [self nextResponder];
    // 如果有响应者就一直循环
    while (resp) {
        // 判断是否拿到控制器
        if ([resp isKindOfClass:[UIViewController class]]) {
            // 如果拿到直接返回
            return (UIViewController *)resp;    // 响应者类型强转成控制器类型
        }
        // 如果没拿到继续往下查找
        resp = [resp nextResponder];
    }
    // 如果没有返回空
    return nil;
}
- (UIImage*)yx_screenshot {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}
- (UIImage*)yx_screenshotInFrame:(CGRect)frame {
    UIGraphicsBeginImageContext(frame.size);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), frame.origin.x, frame.origin.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}
- (UIImage *)yx_screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset {
    UIGraphicsBeginImageContext(self.bounds.size);
    //need to translate the context down to the current visible portion of the scrollview
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0f, -contentOffset.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.55);
    image = [UIImage imageWithData:imageData];
    
    return image;
}
- (void)setRoundedCorners:(UIRectCorner)corners radii:(CGFloat)radii {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radii, radii)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end

@implementation UIView (YX_UIViewFrame)
- (CGFloat)left {
    return self.frame.origin.x;
}
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
- (CGFloat)top {
    return self.frame.origin.y;
}
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (CGSize)size {
    return self.frame.size;
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (CGFloat)centerX {
    return self.center.x;
}
- (CGFloat)centerY {
    return self.center.y;
}
- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}
- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setOrigin:(CGPoint)point {
    CGRect frame = self.frame;
    frame.origin = point;
    self.frame = frame;
}
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}
- (void)setAddTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y += top;
    self.frame = frame;
}
- (void)setAddLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x += left;
    self.frame = frame;
}
-(void)addSubviews:(NSArray *)views{
    [views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if ([view isKindOfClass:[UIView class]]) {
            [self addSubview:view];
        }
    }];
}
@end

@implementation UIView (YX_UIViewAnimation)
- (void)yx_animationShake {
    CALayer* layer = [self layer];
    CGPoint position = [layer position];
    CGPoint y = CGPointMake(position.x - 8.0f, position.y);
    CGPoint x = CGPointMake(position.x + 8.0f, position.y);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08f];
    [animation setRepeatCount:3];
    [layer addAnimation:animation forKey:nil];
}
- (void)yx_animationTrans180 {
    [UIView animateWithDuration:0.3 animations:^{
        self.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    }];
}
@end

@implementation UIView (YX_UIViewHUD)
- (void)yx_showHUD {
    [MBProgressHUD showHUDAddedTo:self animated:YES];
}
- (void)yx_hideHUD {
    [MBProgressHUD hideHUDForView:self animated:YES];
}
- (void)yx_showHUDWithText:(NSString *)textStr {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.margin = 5;
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = textStr;
    [hud hideAnimated:YES afterDelay:1];
}
- (void)yx_showHUDWithDevelopment {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.margin = 5;
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = @"开发中";
    [hud hideAnimated:YES afterDelay:1];
}

@end
