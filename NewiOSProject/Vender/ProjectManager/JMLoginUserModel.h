//
//  JMLoginUserModel.h
//  JMBaseProject
//
//  Created by Liuny on 2020/1/3.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "JMUserModel.h"

NS_ASSUME_NONNULL_BEGIN

#define kLoginUserSavePath [[UIApplication sharedApplication].documentsPath stringByAppendingPathComponent:@"user"]
#define kLiveConfigSavePath [[UIApplication sharedApplication].documentsPath stringByAppendingPathComponent:@"live"]
#define kAppConfigSavePath [[UIApplication sharedApplication].documentsPath stringByAppendingPathComponent:@"AppConfig"]

@interface JMLoginUserModel : JMUserModel
@property (nonatomic, strong) NSString *sessionId;

@property (nonatomic, assign) BOOL isBindPhone;//是否绑定手机号
@property (nonatomic, assign) BOOL isOpenAuction;//能否发布拍卖
@property (nonatomic, assign) BOOL isOpenShop;//能否发布商品
@property (nonatomic, assign) BOOL isOpenGeShe;//能否发布鸽子 鸽舍（原种鸽）
@property (nonatomic, assign) BOOL isOpenLive;//是否开通直播
@property (nonatomic, assign) BOOL isOpenGongPeng;//是否开通直播
@property (nonatomic, assign) BOOL isOpenXieHui;//是否开通直播
@property (nonatomic, assign) BOOL isOpenJuLebu;//是否开通直播


-(instancetype)initWithLoginDictionary:(NSDictionary *)dict;
-(void)updateInfoWithDictionary:(NSDictionary *)dict;
-(void)save;
-(void)clear;
@end


NS_ASSUME_NONNULL_END
