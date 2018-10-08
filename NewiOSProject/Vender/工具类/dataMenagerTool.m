//
//  dataMenagerTool.m
//  门口农场
//
//  Created by FZY on 16/9/8.
//  Copyright © 2016年 Consequently there door. All rights reserved.
//

#import "dataMenagerTool.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>



@implementation dataMenagerTool


//字典-->模型数组
+ (NSMutableArray *)parseDicToModelArrayWithDic:(NSDictionary *)dic withClass:(Class)customClass
{
    NSMutableArray *customArr = [NSMutableArray array];
    NSDictionary *customDic = [NSDictionary dictionary];
    //遍历数组并取出值
    
    for (customDic in dic[@"data"])
        {
        id customModel = [customClass new];
        //一级解析可直接用
        [customModel setValuesForKeysWithDictionary:customDic];
        [customArr addObject:customModel];
        NSLog(@"---------===%@----------------",  customDic);
        }
    return [customArr mutableCopy];
}
+ (id)getModelWithDic:(NSDictionary *)dic withClass:(Class)class {
    id object = [class new];
    [object setValuesForKeysWithDictionary:dic];
    return object;
}


/** 字典转-->模型*/
+ (id) parseDicToModelWithDic:(NSDictionary *)dic withClass:(Class)customClass
{
    id myObj = [[customClass alloc] init];
    unsigned int outCount;
    //获取类中的所有成员属性
    objc_property_t *arrPropertys = class_copyPropertyList([self class], &outCount);
    
    for (NSInteger i = 0; i < outCount; i ++) {
        objc_property_t property = arrPropertys[i];
        
        //获取属性名字符串
        //model中的属性名
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        id propertyValue = dic[propertyName];
        
        if (propertyValue != nil) {
            [myObj setValue:propertyValue forKey:propertyName];
        }
        
    }
    free(arrPropertys);
    return myObj;
    
}

+ (void)writeArrayToPlist:(NSArray *)DataSource plistName:(NSString *)plistname {
    //获取沙盒根根路径,每一个应用在手机当中都有一个文件夹,这个方法就是获取当前应用在手机里安装的文件.
    NSString *homeDir = NSHomeDirectory();
    NSLog(@"homeDir = %@",homeDir);
    
    //在某个范围内搜索文件夹的路径.
    //directory:获取哪个文件夹
    //domainMask:在哪个路径下搜索
    //expandTilde:是否展开路径.
    
    //这个方法获取出的结果是一个数组.因为有可以搜索到多个路径.
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //在这里,我们指定搜索的是Cache目录,所以结果只有一个,取出Cache目录
    NSString *cachePath = array[0];
    NSLog(@"%@",cachePath);
    //拼接文件路径
    NSString *filePathName = [cachePath stringByAppendingPathComponent:plistname];
    [DataSource writeToFile:filePathName atomically:YES];
}
+ (void)writeDictToPlist:(NSDictionary *)dict plistName:(NSString *)plistname  {
    //获取沙盒根根路径,每一个应用在手机当中都有一个文件夹,这个方法就是获取当前应用在手机里安装的文件.
    NSString *homeDir = NSHomeDirectory();
    NSLog(@"homeDir = %@",homeDir);
 
    
    
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = array[0];
    NSLog(@"%@",cachePath);
    NSString *filePathName = [cachePath stringByAppendingPathComponent:plistname];
       [dict writeToFile:filePathName atomically:YES];
   
}

/** 获取当前时间戳*/
+(NSString *)getCurTimeSecondStr {
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    
    long long int date = (long long int)time;
    
    NSString * timeStr = [NSString stringWithFormat:@"%lld",date];
    
    return timeStr;
}
+ (NSArray *)arrayWithObjects:(id)firstObj, ...{

    NSMutableArray* arrays = [NSMutableArray array];
    //VA_LIST 是在C语言中解决变参问题的一组宏
    va_list argList;

    if (firstObj) {
        [arrays addObject:firstObj];
        // VA_START宏，获取可变参数列表的第一个参数的地址,在这里是获取firstObj的内存地址,这时argList的指针 指向firstObj
        va_start(argList, firstObj);
        // 临时指针变量
        id temp;
        // VA_ARG宏，获取可变参数的当前参数，返回指定类型并将指针指向下一参数
        // 首先 argList的内存地址指向的fristObj将对应储存的值取出,如果不为nil则判断为真,将取出的值房在数组中,并将指针指向下一个参数,这样每次循环argList所代表的指针偏移量就不断下移直到取出nil
        while ((temp = va_arg(argList, id))) {
            [arrays addObject:temp];
            NSLog(@"-----------%@",arrays);
        }

    }
    // 清空列表
    va_end(argList);
    return arrays;
}
+ (void)addSubViewsToView:(UIView *)superView withView:(UIView *)firstView,...  {
    va_list argList;
    
    if (firstView) {
        [superView addSubview:firstView];
        va_start(argList, firstView);
        id temp;
        while ((temp = va_arg(argList, id))) {
            [superView addSubview:temp];
        }
        
    }
    va_end(argList);
}
/** 一个能传多个参数的SHA1加密算法*/
+ (NSMutableString *) sha1:(NSString *)string,...NS_REQUIRES_NIL_TERMINATION
{
    va_list args;
    va_start(args, string);

    NSMutableString *endString = [NSMutableString new];
    
    for (NSString *str = string; str != nil; str = va_arg(args,NSString*)) {
        [endString appendFormat:@"%@",str];
    }
    va_end(args);
    
    const char *cstr = [endString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:endString.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *checkSum = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [checkSum appendFormat:@"%02x", digest[i]];
    }
    
    return checkSum;
}

/** 生成随机数*/
+ (NSString *)getRandomStringWithNum:(NSInteger)num
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}
+ (NSString *)getDateStr {
    NSDate *date =[NSDate date];

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}


//正则表达式验证密码
+ (BOOL)checkPassword:(NSString *) password
{
    NSLog(@"进入正则表达式");
    NSString *psw = @"^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{8,18}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", psw];
    BOOL isMatch = [pred evaluateWithObject:password];
    NSLog(@"isMatch is %d",isMatch);
    return isMatch;
}
/** 身份证 */
+ (BOOL)checkID:(NSString *) ID
{
    NSLog(@"进入正则表达式");
    NSString *psw = @"(^\\d{15}$)|(^\\d{17}([0-9]|[Xx])$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", psw];
    BOOL isMatch = [pred evaluateWithObject:ID];
    return isMatch;
}
/** 银行卡号 20位以内 */
+ (BOOL)checkBankNum:(NSString *) bankNum
{
    NSLog(@"进入正则表达式");
    NSString *psw = @"^([0-9]){1,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", psw];
    BOOL isMatch = [pred evaluateWithObject:bankNum];
    return isMatch;
}

/** 验证用户名 （判断只能是字母和数字的结合）*/
+ (BOOL)checkUserName:(NSString *) userName
{
    NSLog(@"进入正则表达式");
    NSString *psw = @"^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", psw];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

/** 验证用户名 （该表达式只能是纯汉字） */
+ (BOOL)checkName:(NSString *) userName
{
    NSLog(@"进入正则表达式");
    NSString *psw = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", psw];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

/** 判断手机号码格式是否正确 */
+ (BOOL)checkMobileNum:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
        {
        return NO;
        }else{
            
            /**
             * 移动号段正则表达式
             */
            NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
            /**
             * 联通号段正则表达式
             */
            NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
            /**
             * 电信号段正则表达式
             */
            NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
            NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
            BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
            NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
            BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
            NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
            BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
            
            if (isMatch1 || isMatch2 || isMatch3) {
                return YES;
            }else{
                return NO;
            }
        }
}

//获取倒计时
+ (void)setTheCountdownButton:(UIButton *)button startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0), 1.0 * NSEC_PER_SEC,0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut == 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = mColor;
                [button setTitle:title forState:UIControlStateNormal];
                button.userInteractionEnabled =YES;
            });
        } else {
            int seconds = timeOut % 60;
            NSString *timeStr = [NSString stringWithFormat:@"%0.1d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = color;
                [button setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle]forState:UIControlStateNormal];
                button.userInteractionEnabled =NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
    
}


@end
