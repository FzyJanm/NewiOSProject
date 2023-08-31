//
//  JMPriceTextField.m
//  JMBaseProject
//
//  Created by GBMac on 2023/4/3.
//  Copyright © 2023 liuny. All rights reserved.
//

#import "JMPriceTextField.h"

@interface JMPriceTextField()<UITextFieldDelegate>
{
    BOOL isHaveDian;
}
@end
@implementation JMPriceTextField
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.delegate = self;
    }
    return self;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    if ([string length] > 0) {
        // 当前输入的字符
        unichar single = [string characterAtIndex:0];
        // 数据格式正确
        if ((single >= '0' && single <= '9') || single == '.') {
            // 首字母不能为小数点
            if ([textField.text length] == 0) {
                if(single == '.') {
//                    [SVProgressHUD showInfoWithStatus:@"亲，第一个数字不能为小数点!"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            // 输入的字符是否是小数点
            if (single == '.') {
                // text中还没有小数点
                if(!isHaveDian) {
                    isHaveDian = YES;
                    return YES;
                } else {
//                    [SVProgressHUD showInfoWithStatus:@"亲，您已经输入过小数点了!"];
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            } else {
                // 存在小数点
                if (isHaveDian) {
                    // 判断小数点的位数
                    NSRange ran = [textField.text rangeOfString:@"."];
                    if (range.location - ran.location <= 2) {
                        return YES;
                    } else {
//                        [SVProgressHUD showInfoWithStatus:@"亲，您最多输入两位小数!"];
                        return NO;
                    }
                } else {
                    return YES;
                }
            }
        } else {
            // 输入的数据格式不正确
//            [SVProgressHUD showInfoWithStatus:@"亲，您输入的格式不正确!"];
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else {
        return YES;
    }
}
@end
