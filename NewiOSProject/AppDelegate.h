//
//  AppDelegate.h
//  NewiOSProject
//
//  Created by 范智渊 on 2018/10/8.
//  Copyright © 2018 范智渊. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>

#import "payRequsestHandler.h"

#define WeChatAppID @"wxf84fea363b403f22"
#define WeChatSecret @"1ed3e3a493519bbc879fa5e9339e3ba0"

#define  QQAPPID @"1107851652"
#define  QQAPPKey @"KEYqubGcTtLpSpWb0Dp"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

typedef void(^WXPayBlock)(BOOL resp);
typedef void(^ApiPayBlock)(BOOL resp);
/**
 *微信支付
 */
-(void)WXPayPrice:(NSString *)price OrderID:(NSString *)orderId OrderName:(NSString *)orderName mySign:(NSString *)sign complete:(WXPayBlock)complete;
/**
 *支付宝支付
 */
-(void)AliPayfororderString:(NSString *)orderString complete:(ApiPayBlock)complete;

@end


