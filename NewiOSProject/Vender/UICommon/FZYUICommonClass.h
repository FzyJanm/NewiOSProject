//
//  LSHUICommonClass.h
//
//  Created by an on 15/9/15.
//  Copyright (c) 2015年 yesmywine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VerticallyAlignedLabel.h"
#import "CustomTextField.h"

/**
 *    适用于同一marsory布局
 */

@interface FZYUICommonClass : NSObject


#pragma UILabel部分

+(VerticallyAlignedLabel *)creatLabelFromText:(NSString *)text  textAlignment:(NSTextAlignment)textAlignment  verticalAlignment:(VerticalAlignment)verticalAlignment  textColor:(UIColor *)color
  numberOfLines:(NSInteger)lines;


#pragma UIButton部分

//用于创建导航条按钮
+(UIButton *)creatButtonFromFrame:(CGRect)frame buttonTitle:(NSString *)title buttonTitleColor:(UIColor *)color buttonFont:(UIFont *)font;
+(UIButton *)creatButtonFromButtonTitle:(NSString *)title buttonTitleColor:(UIColor *)color buttonFont:(UIFont *)font backgroundColor:(UIColor *)backgroundcolor;
//设置圆角按钮
+(UIButton *)creatButtonFromButtonTitle:(NSString *)title buttonTitleColor:(UIColor *)color buttonFont:(UIFont *)font backgroundColor:(UIColor *)backgroundcolor buttonCornerRadius:(CGFloat)cornerRadius buttonBorderWidth:(CGFloat)borderWidth buttonBorderColor:(CGColorRef)borderColor;


#pragma UIImageView部分

//设置圆形头像
//+(UIImageView *)creatUIImageViewFromImageString:(NSString *)imageString placeholderImageString:(NSString *)placeholderString imageCornerRadius:(CGFloat)cornerRadius imageBorderWidth:(CGFloat)borderWidth imageBorderColor:(CGColorRef)borderColor;


#pragma UITextField部分

+(CustomTextField *)creatTextFieldFromplaceholder:(NSString *)placeholder textAlignment:(NSTextAlignment)textAlignment clearButtonMode:(UITextFieldViewMode)clearButtonMode textFieldTextFont:(UIFont*)textFont keyboardType:(UIKeyboardType)keyboardType backgroundColor:(UIColor*)backgroundColor secureTextEntry:(BOOL)secureTextEntry;


@end
