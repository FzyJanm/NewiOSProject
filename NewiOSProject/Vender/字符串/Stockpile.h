//
//  Stockpile.h
//  CenterFo
//
//  Created by apple on 14-7-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Helper.h"

#define single_interface(class)  + (class *)shared##class;

@interface Stockpile : NSObject

single_interface(Stockpile);

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *Name;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *nickName,*longtitude,*latitude;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *ID,*cityID,*keFuId;
@property(nonatomic,strong)NSString *logo;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *City;
@property(nonatomic,strong)NSString *Sheng;
@property(nonatomic,strong)NSString *Role;
@property(nonatomic,strong)NSString *Account;
@property(nonatomic,strong)NSString *AccountType,*MoBanType;
@property(nonatomic,strong)NSString *YUE;
@property(nonatomic,strong)NSString *ONLine;
@property(nonatomic,strong)NSString *lv;
@property(nonatomic,strong)NSString *birthday;
@property(nonatomic,strong)NSString *age,*address,*jiFen,*money,*tel,*qm,*code,*qiLogo,*isQi;
@property(nonatomic,strong)NSString *gesturePwd;
//@property(nonatomic,assign)NSInteger shopCartNum;
@property(nonatomic,strong)NSString * shopCartNum;


//中航
@property(nonatomic,strong)NSString *Company,*Position,*Email,*iconUrl,*LoginStatus,*Able,*Status,*VipStatus;
/** 标记是否可以修改密码 0 不可以 1 可以*/
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *loginType;
@property(nonatomic,strong)NSString *encodedIconStr;

@property(nonatomic,assign)NSInteger number;

@property(nonatomic,strong)NSMutableDictionary *model;
@property(nonatomic,assign)BOOL isLogin;
@property(nonatomic,assign)BOOL isSave;
@property(nonatomic,assign)BOOL Secret;
@property(nonatomic,assign)BOOL isSign;
@property(nonatomic,assign)BOOL isSHOU,isKAIHU;

@property(nonatomic,strong)NSString *LogPwd,*rongToken;

@property(nonatomic,strong)NSString *hideStatus,*userID,*userPwd;

@property(nonatomic,strong)NSString *appAD,*homeAD;


@property(nonatomic,strong)NSString *MMMmNum,*MMMBiao;


@end
