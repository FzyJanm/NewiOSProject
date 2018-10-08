//
//  UITextView+Helper.h
//  daJianKuangJia
//
//  Created by Apple on 2018/7/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Helper)

/*
 限制键盘不能输入表情
 -(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
 {
 
 return [textView textFieldShouldChangeCharactersWithEmojiInRange:range replacementString:text];
 }
 */
-(BOOL)textFieldShouldChangeCharactersWithEmojiInRange:(NSRange)range replacementString:(NSString *)string;
@end
