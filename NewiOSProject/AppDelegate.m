//
//  AppDelegate.m
//  NewiOSProject
//
//  Created by 范智渊 on 2018/10/8.
//  Copyright © 2018 范智渊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SuperTabBarViewController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
@interface AppDelegate ()<UIScrollViewDelegate,RDVTabBarControllerDelegate>{
    UIPageControl *page;
    int ii;
    UIScrollView *scroll;
    UIButton *_countBtn;
    NSMutableData *mutableData;
}
//微信
@property(nonatomic,strong)WXPayBlock wxpay;
//支付宝
@property(nonatomic,strong)ApiPayBlock ApiBlock;
@property(strong,nonatomic)UIViewController *viewController;
@property(nonatomic,strong)NSMutableArray *imgArr,*imgUrlArr,*immmmm;
@property (nonatomic,strong)SuperTabBarViewController *tabBarViewController;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation AppDelegate
- (UIWindow *)window
{
    if(!_window)
    {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor whiteColor];
        [_window makeKeyAndVisible];
    }
    return _window;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
        self.tabBarViewController =[[SuperTabBarViewController alloc] init];
        self.window.rootViewController = self.tabBarViewController;

    
    
    
//    [self  UMConfig];
    //    /** 极光配置 */
    //    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    //    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionSound;
    //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    //        // 可以添加自定义categories
    //        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
    //        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    //    }
    //    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    //
    ////    [JPUSHService setupWithOption:launchOptions appKey:jPushAppKey
    ////                          channel:nil
    ////                 apsForProduction:1
    ////            advertisingIdentifier:nil];
    return YES;
}
//- (void)UMConfig {
//
//    /** 友盟 */
//    //    [UMCommonLogManager setUpUMCommonLogManager];
//    [UMConfigure setLogEnabled:YES];
//    [UMConfigure initWithAppkey:@"5b4f9705a40fa32c96000633" channel:@"App Store"];
//    //    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
//
//    // U-Share 平台设置
//    [self configUSharePlatforms];
//    [self confitUShareSettings];
//    //    [UMConfigure deviceIDForIntegration];
//    NSLog(@"version**************************%@",[UMSocialGlobal umSocialSDKVersion]);
//
//}
//#pragma mark - 友盟
//- (void)confitUShareSettings
//{
//    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
//
//}
///** 友盟第三方平台配置 */
//- (void)configUSharePlatforms
//{
//
//    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite),@(UMSocialPlatformType_Qzone)]];
//
//    /* 设置微信的appKey和appSecret */
//    //     [WXApi registerApp:@"wxb2ff591e2f9bb072"];
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeChatAppID appSecret:WeChatSecret redirectURL:@"http://mobile.umeng.com/social"];
//    [WXApi registerApp:WeChatAppID];
//
//    /* 设置分享到QQ互联的appID
//     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
//     */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//
//}

#pragma mark - 微信支付
/**
 *微信支付
 */
//-(void)WXPayPrice:(NSString *)price OrderID:(NSString *)orderId OrderName:(NSString *)orderName mySign:(NSString *)sign complete:(WXPayBlock)complete{
//    //微信支付需要配置白名单  并且设置url Types  在调用方法之前需要初始化微信
//
//    _wxpay=complete;
//    payRequsestHandler *req=[payRequsestHandler alloc];
//    //初始化支付签名对象
//    [req init:APPI_ID mch_id:PARTNER_ID];
//    [req setKey:PARTNER_KEY];
//
//    NSMutableDictionary *dict = [req sendPayByOrderTitle:orderName Price:price OrderID:orderId   UUID: [[[UIDevice currentDevice] identifierForVendor] UUIDString]];
//
//    if(dict == nil){
//        //错误提示
//        NSString *debug = [req getDebugifo];
//        NSLog(@"%@\n\n",debug);
//    }else{
//        NSLog(@"%@\n\n",[req getDebugifo]);
//        //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
//        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//        //调起微信支付
//        PayReq* req             = [[PayReq alloc] init];
//        req.openID              = [dict objectForKey:@"appid"];
//        req.partnerId           = [dict objectForKey:@"partnerid"];
//        req.prepayId            = [dict objectForKey:@"prepayid"];
//        req.nonceStr            = [dict objectForKey:@"noncestr"];
//        req.timeStamp           = stamp.intValue;
//        req.package             = [dict objectForKey:@"package"];
//        req.sign                = [dict objectForKey:@"sign"];
//        [WXApi sendReq:req];
//    }
//
//}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wimplicit-retain-self"


#pragma mark - 支付宝支付
/**
 *支付宝支付
 */
-(void)AliPayfororderString:(NSString *)orderString complete:(ApiPayBlock)complete{
    
    _ApiBlock=complete;
//    orderString = [orderString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//
//    [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"XDRD" callback:^(NSDictionary *resultDic) {
//        NSLog(@"reslut = %@",resultDic);
//        if (_ApiBlock) {
//            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
//                _ApiBlock(YES);
//            }else{
//                _ApiBlock(NO);
//            }
//        }
//
//    }];
}


//  MARK: -应用跳转回调
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    return YES;
    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
    
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
//    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
//    if (!result) {
        // 其他如支付等SDK的回调
//        if ([url.host isEqualToString:@"safepay"]) {
//            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//                NSLog(@"result = %@",resultDic);
//                if (_ApiBlock) {
//                    if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
//                        _ApiBlock(YES);
//                    }else{
//                        _ApiBlock(NO);
//                    }
//                }
//
//            }];
//            return YES;
//        }
//        return [WXApi handleOpenURL:url delegate:self];
//    }
//    return result;
}

//iOS 4.2+
//分享和支付会用到
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    //    6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
//    if (!result) {
        // 其他如支付等SDK的回调
//
//        if ([url.host isEqualToString:@"safepay"]) {
//
//            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//                NSLog(@"result = %@",resultDic);
//                if (_ApiBlock) {
//                    _ApiBlock(resultDic);
//                }
//
//            }];
//            return YES;
//        }else{
            return NO;
//        }
        
//    }
//    return result;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
//    if (!result) {
        // 其他如支付等SDK的回调
        
//        if ([url.host isEqualToString:@"safepay"]) {
//            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//                NSLog(@"result = %@",resultDic);
//                if (_ApiBlock) {
//                    if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
//                        _ApiBlock(YES);
//                    }else{
//                        _ApiBlock(NO);
//                    }
//                }
//
//            }];
//            return YES;
//        }else{
            return NO;
//        }
//    }
//    return result;
}
//
//
//
//#pragma mark JPUSH 注册
//- (void)application:(UIApplication *)application
//didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    /// Required - 注册 DeviceToken
//    [JPUSHService registerDeviceToken:deviceToken];
//
//}
//
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    //Optional
//    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
//}
//
//#pragma mark- JPUSHRegisterDelegate
//// iOS 10 Support
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
//    // Required
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    if (@available(iOS 10.0, *)) {
//        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//            [JPUSHService handleRemoteNotification:userInfo];
//
//        }
//    } else {
//        // Fallback on earlier versions
//    }// 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
//    if (@available(iOS 10.0, *)) {
//        completionHandler(UNNotificationPresentationOptionAlert);
//
//    } else {
//        // Fallback on earlier versions
//    }
//}
//
//#pragma mark 接收推送
////APP运行期间
//// iOS 10 Support
//- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [JPUSHService handleRemoteNotification:userInfo];
//
//        [self handleReceiveRemoteNotification:userInfo];
//    }
//    completionHandler();  // 系统要求执行这个方法
//
//}
///** APP 在后台收到通知 */  // Required, iOS 7 Support
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//
//    [JPUSHService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//    [self handleReceiveRemoteNotification:userInfo];
//
//}
///** 同上 */// Required,For systems with less than or equal to iOS6
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [JPUSHService handleRemoteNotification:userInfo];
//    [self handleReceiveRemoteNotification:userInfo];
//
//}
//-(void) handleReceiveRemoteNotification:(NSDictionary *)userInfo {
////    SuperTabBarViewController*tab = (SuperTabBarViewController*)self.window.rootViewController;
////    UINavigationController*nvc = tab.selectedViewController;
////    UIViewController *currentVC = nvc.visibleViewController;
////
////
//}
//这里写出现警告的代码就能实现去除警告
#pragma clang diagnostic pop

@end
