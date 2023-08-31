//
//  JMUserModel.h
//  JMBaseProject
//
//  Created by Liuny on 2020/1/3.
//  Copyright © 2020 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMBaseModel.h"
NS_ASSUME_NONNULL_BEGIN
@class AddressCityModel;

@interface JMUserModel : JMBaseModel
@property (nonatomic, copy) NSString *userId;//用户id
@property (nonatomic, copy) NSString *name;//昵称
@property (nonatomic, copy) NSString *headUrl;//头像
@property (nonatomic, copy) NSString *backUrl;//背景
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, assign) BOOL isAttention;//是否关注
@property (nonatomic, copy) NSString *desc;//简介
@property (nonatomic, assign) Sex_E sex;//性别
@property (nonatomic, copy) NSString *birthday;//生日
@property (nonatomic, copy) NSString *age;//年龄
@property (nonatomic, copy) NSString *fansNum;//粉丝数量
@property (nonatomic, copy) NSString *attentionNum;//关注数量
@property (nonatomic, copy) NSString *readnum;//关注数量
@property (nonatomic, strong) AddressCityModel *sheng;//省
@property (nonatomic, strong) AddressCityModel *shi;//市
@property (nonatomic, strong) AddressCityModel *qu;//区
@property (nonatomic, strong) NSString *address;

@property (nonatomic, assign) BOOL isNewAuction; //0无新拍卖1有
@property (nonatomic, assign) BOOL isNewFocus;   //0关注无新发布1有
@property (nonatomic, assign) BOOL isMe;

@property (nonatomic, copy) NSString *kind; //0全部　1介绍　2公告　3规程
@property (nonatomic, copy) NSString *pageType; //0全部 １公棚２协会 ３俱乐部 4鸽舍 5拍卖 6商店
@property (nonatomic, copy) NSString *bgPic;//公棚协会俱乐部背景图
@property (nonatomic, copy) NSString *nick;//公棚协会俱乐部昵称
@property (nonatomic, copy) NSString *avatar;//工棚协会俱乐部主页头像


-(NSString *)showFansNum;
-(NSString *)showAttentionNum;
-(NSString *)showReadNum;
-(NSString *)showAge;
-(NSString *)showShengShiQu;
/// 返回样式：159****7765
-(NSString *)secretMobile;
@end

NS_ASSUME_NONNULL_END
