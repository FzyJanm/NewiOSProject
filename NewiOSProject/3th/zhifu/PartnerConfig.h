//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h
#import "WXApi.h"
#import <QuartzCore/QuartzCore.h>
//#import <AlipaySDK/AlipaySDK.h>
#import "Alipay/AlipaySDK.framework/Headers/AlipaySDK.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "DataSigner.h"



#pragma mark - 微信支付配置
//商户号
#define PARTNER_ID   @"1498778472"
//商户密钥
#define PARTNER_KEY  @"XWPRPU1ICS9Q1X07V7F0NKPRGWK658BN"
 //APPID
#define APPI_ID   @"wx4df7cabb4727a628"
  //appsecret
#define APP_SECRET @"e08739f5003b3b09f94e403db5ddce3a"
//回调网站
#define WXNotifiURL @"http://www.qianjingji.cn/Pay_CallBack/ResultNotifyPage_App.aspx"

#endif

