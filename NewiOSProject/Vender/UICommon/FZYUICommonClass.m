//
//  LSHUICommonClass.m
//
//  Created by an on 15/9/15.
//  Copyright (c) 2015年 yesmywine. All rights reserved.
//

#import "FZYUICommonClass.h"
#import "SDImageCache.h"
@implementation FZYUICommonClass


#pragma UILabel部分

+(VerticallyAlignedLabel *)creatLabelFromText:(NSString *)text textAlignment:(NSTextAlignment)textAlignment verticalAlignment:(VerticalAlignment)verticalAlignment textColor:(UIColor *)color numberOfLines:(NSInteger)lines{

    VerticallyAlignedLabel *label=[[VerticallyAlignedLabel alloc]init];
    label.text=text;
    label.textAlignment=textAlignment;
    label.verticalAlignment=verticalAlignment;
    label.textColor=color;
    label.numberOfLines=lines;
    return label;
    
}





#pragma  UIButton部分

+(UIButton *)creatButtonFromFrame:(CGRect)frame buttonTitle:(NSString *)title buttonTitleColor:(UIColor *)color buttonFont:(UIFont *)font{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font=font;
    
    return button;
}

+(UIButton *)creatButtonFromButtonTitle:(NSString *)title buttonTitleColor:(UIColor *)color buttonFont:(UIFont *)font backgroundColor:(UIColor *)backgroundcolor{
    
    return  [self creatButtonFromButtonTitle:title buttonTitleColor:color buttonFont:font backgroundColor:backgroundcolor buttonCornerRadius:0.0 buttonBorderWidth:0.0 buttonBorderColor:[UIColor clearColor].CGColor];
}

+(UIButton *)creatButtonFromButtonTitle:(NSString *)title buttonTitleColor:(UIColor *)color buttonFont:(UIFont *)font backgroundColor:(UIColor *)backgroundcolor buttonCornerRadius:(CGFloat)cornerRadius buttonBorderWidth:(CGFloat)borderWidth buttonBorderColor:(CGColorRef)borderColor{
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font=font;
    button.backgroundColor=backgroundcolor;
    button.layer.cornerRadius=cornerRadius;
    button.layer.masksToBounds=YES;
    button.layer.borderWidth=borderWidth;
    button.layer.borderColor=borderColor;
    return button;
}



#pragma UIImageView部分

//+(UIImageView *)creatUIImageViewFromImageString:(NSString *)imageString placeholderImageString:(NSString *)placeholderString imageCornerRadius:(CGFloat)cornerRadius imageBorderWidth:(CGFloat)borderWidth imageBorderColor:(CGColorRef)borderColor{
//
//    UIImageView *imageView = [[UIImageView alloc] init];
////    [imageView setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:placeholderString]];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:placeholderString]];
//    imageView.layer.masksToBounds = YES;
//    imageView.layer.cornerRadius =cornerRadius;
//    imageView.layer.borderColor = borderColor;
//    imageView.layer.borderWidth = borderWidth;
//    imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
//    imageView.layer.shouldRasterize = YES;
//    imageView.clipsToBounds = YES;
//
//    return imageView;
//}

#pragma UITextField部分

+(CustomTextField *)creatTextFieldFromplaceholder:(NSString *)placeholder textAlignment:(NSTextAlignment)textAlignment clearButtonMode:(UITextFieldViewMode)clearButtonMode textFieldTextFont:(UIFont *)textFont keyboardType:(UIKeyboardType)keyboardType backgroundColor:(UIColor *)backgroundColor secureTextEntry:(BOOL)secureTextEntry{


    CustomTextField *textField=[[CustomTextField alloc]init];
    textField.placeholder=placeholder;
    textField.textAlignment=textAlignment;
    textField.clearButtonMode=clearButtonMode;
    textField.font=textFont;
    textField.keyboardType=keyboardType;
    textField.backgroundColor=backgroundColor;
    textField.secureTextEntry=secureTextEntry;
    
    return textField;
    
}


@end
