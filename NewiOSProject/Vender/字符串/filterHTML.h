//
//  filterHTML.h
//  ZhongHang
//
//  Created by 范智渊 on 2018/7/19.
//  Copyright © 2018年 范智渊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface filterHTML : NSObject
//过滤
/**
 * 过滤标签
 */
+(NSString *)filterHTML:(NSString *)str;
+(NSString *)filterHTMLImage:(NSString *)str;
/**
 * 替换部分标签
 */
+ (NSString *)filterHTMLTag:(NSString *)str;


@end
