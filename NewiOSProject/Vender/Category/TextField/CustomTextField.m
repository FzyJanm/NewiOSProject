//
//  CustomTextField.m
//  UITextDemo
//
//  Created by apple on 16/7/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

-(void)setMaxlength:(NSInteger)maxlength{
    _maxlength=maxlength;
    [self addTarget:self action:@selector(TextFieldChange) forControlEvents:UIControlEventEditingChanged];
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = placeholderColor;
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
}
-(void)TextFieldChange{
    NSInteger _length=_maxlength;
    NSString *toBeString = self.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > _length) {
                self.text = [toBeString substringToIndex:_length];
            }
        }
        else{
            
        }
    }
    else{
        if (toBeString.length > _length) {
            self.text = [toBeString substringToIndex:_length];
        }
    }
}
- (void)awakeFromNibWihtTintColor:(UIColor *)tintColor placeholderColor:(UIColor *)color placeholderfont:(UIFont *)font
{
    self.tintColor = [UIColor whiteColor];      //设置光标颜色
    
    //修改占位符文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
}

//重写来重置占位符区域
-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    
    return inset;
    
}

//重写控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    
    return inset;
}

//重写来重置编辑区域
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    
    return inset;
}


@end
