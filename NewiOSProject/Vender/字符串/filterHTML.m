//
//  filterHTML.m
//  ZhongHang
//
//  Created by 范智渊 on 2018/7/19.
//  Copyright © 2018年 范智渊. All rights reserved.
//

#import "filterHTML.h"

@implementation filterHTML
/**
 * 过滤标签
 */
+(NSString *)filterHTML:(NSString *)str
{
    NSScanner * scanner = [NSScanner scannerWithString:str];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        str  =  [str  stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return str;
}
+(NSString *)filterHTMLImage:(NSString *)str{
    NSScanner * scanner = [NSScanner scannerWithString:str];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<img" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        str  =  [str  stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@"【图片】"];
    }
    return str;
}

+ (NSString *)filterHTMLTag:(NSString *)str {
    //替换字符
    str  =  [str  stringByReplacingOccurrencesOfString:@"&mdash;" withString:@"-"];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"\""];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"\""];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&rsquo;" withString:@"’"];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&lsquo;" withString:@"‘"];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&middot;" withString:@"·"];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    str  =  [str  stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    str  =  [str  stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
    str  =  [str  stringByReplacingOccurrencesOfString:@"</strong>" withString:@""];
    str  =  [str  stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    return str;
    
}


@end
