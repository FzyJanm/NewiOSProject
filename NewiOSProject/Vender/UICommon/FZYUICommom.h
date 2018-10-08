//
//  FZYUICommom.h
//  ZhiZhuoGaoKao
//
//  Created by 范智渊 on 2018/1/5.
//  Copyright © 2018年 zzgk. All rights reserved.
//

#import <Foundation/Foundation.h>



/**延迟使用block,s为秒*/
extern void delayOperation(CGFloat s,void(^block)(void));
/**
 *   调用系统拨打号码的功能
 *
 *   @param number 要拨打的电话号码
 */
extern void  callNumber(NSString *number);
/*
 弹出UIAlertView*
 */
extern void alert(NSString* msg);

/*
 弹出两个按钮的UIAlertView
 */
extern void alert2Btn(NSString* msg,NSString* btnTitle1,NSString* btnTitle2,id delegate);
extern void presentLoginViewController(UIViewController *currentVC,void(^complection)(void));

//extern void makeAViewWithshadowAndCornerRadius(UIView *view,CGFloat cornerRadius,CGFloat shadowRadius,UIColor *shadowColor, CGFloat shadowOpacity, CGSize shadowOffset);


@interface UIImage (withColor)
+ (UIImage*) createImageWithColor: (UIColor*) color;

@end

@interface UIColor (customSystemColor)
+ (SEL) randomColorSel;
+(UIColor*)mostColor:(UIImage*)image;

@end


