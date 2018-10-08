//
//  dataMenagerTool.h
//  门口农场
//
//  Created by FZY on 16/9/8.
//  Copyright © 2016年 Consequently there door. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface dataMenagerTool : NSObject

/** 数据解析*/
//+ (NSDictionary *)GBKToUTF_8:(id)data;

/** 字典-->转模型数组*/
+ (NSMutableArray *)parseDicToModelArrayWithDic:(NSDictionary *)dic withClass:(Class)customClass;
/** 字典-->模型*/
+ (id) parseDicToModelWithDic:(NSDictionary *)dic withClass:(Class)customClass;

/** 数组本地保存为plist*/
+ (void)writeArrayToPlist:(NSArray *)DataSource plistName:(NSString *)plistname;
/** 字典本地保存为plist */
+ (void)writeDictToPlist:(NSDictionary *)dict plistName:(NSString *)plistname;

+ (id)getModelWithDic:(NSDictionary *)dic withClass:(Class)class ;
/** 添加所有子控件到父视图上*/
+ (void)addSubViewsToView:(UIView *)superView withView:(UIView *)firstView,...;

/** 判断手机号码格式是否正确 */
+ (BOOL)checkMobileNum:(NSString *)mobile;
/** 生成字母和数字的随机数*/
+ (NSString *)getRandomStringWithNum:(NSInteger)num;
/** 获取系统时间字符串*/
+ (NSString *)getCurTimeSecondStr;

+ (NSMutableString *) sha1:(NSString *)string,...NS_REQUIRES_NIL_TERMINATION;


/** 验证用户名 */
+ (BOOL)checkUserName:(NSString *) userName;
//正则表达式验证密码
+ (BOOL)checkPassword:(NSString *) password;
/** 身份证 */
+ (BOOL)checkID:(NSString *) ID;
/** 银行卡号 20位以内 */
+ (BOOL)checkBankNum:(NSString *) bankNum;
/** 获取当前时间年月日*/
+ (NSString *)getDateStr;

/**获取倒计时*/
+ (void)setTheCountdownButton:(UIButton *)button startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;


@end
