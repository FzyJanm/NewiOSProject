//
//  UITextView+Helper.m
//  daJianKuangJia
//
//  Created by Apple on 2018/7/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UITextView+Helper.h"

@implementation UITextView (Helper)
/*
 限制键盘不能输入表情
 */
-(BOOL)textFieldShouldChangeCharactersWithEmojiInRange:(NSRange)range replacementString:(NSString *)string
{
    
    // 不让输入表情
    if ([self isFirstResponder]) {
        if ([[[self textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[self textInputMode] primaryLanguage]) {
            return NO;
        }
    }
    
    if ([[[self textInputMode] primaryLanguage] isEqualToString:@"zh-Hans"])
    {
        if ([string isEqualToString:@"➋"] || [string isEqualToString:@"➌"] || [string isEqualToString:@"➍"] || [string isEqualToString:@"➎"] || [string isEqualToString:@"➏"] || [string isEqualToString:@"➐"] || [string isEqualToString:@"➑"] || [string isEqualToString:@"➒"])
        {
            return YES;
        }
        
       if ([self isContainsTwoEmoji:string])
        {
            return NO;
        }
        
    }
    
    
    
    //禁止所有输入法的表情
    /*  if ([self isContainsTwoEmoji:text]) {
     return NO;
     }*/
    return YES;
    
}
- (BOOL)isContainsTwoEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         //         NSLog(@"hs++++++++%04x",hs);
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     isEomji = YES;
                 }
                 //                 NSLog(@"uc++++++++%04x",uc);
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3|| ls ==0xfe0f) {
                 isEomji = YES;
             }
             //             NSLog(@"ls++++++++%04x",ls);
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
         
     }];
    return isEomji;
}
@end
