//
//  JMProjectManager.h
//  JMBaseProject
//
//  Created by liuny on 2018/7/14.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMLoginUserModel.h"

typedef enum:NSInteger{
    Review_State_Test = 1,//测试环境
    Review_State_Dev,//开发环境
    Review_State_Rev_Apple,//审核中环境
    Review_State_Rev_User,//审核中正常用户环境
    Review_State_Dist,//生产环境
}Review_State;

@class JMAppConfig;

@interface JMProjectManager : NSObject
singleton_interface(JMProjectManager)
@property (nonatomic, strong) JMLoginUserModel *loginUser;
@property (nonatomic, strong) JMAppConfig *appConfig;
@property (nonatomic, assign) NSInteger tabbarPreSelIndex;
+(BOOL)isLogin;
-(void)loadRootVC;
-(void)showLoginViewController;
-(void)showMainViewController;
-(void)clearLiveDate;
-(void)versionCheck:(BOOL)showAlert;
@end



@interface JMAppConfig : NSObject
////最终用户使用的状态
//@property (nonatomic,assign)Review_State serviceReviewStatus;
////本地审核状态。（防止每次启动后自动修改服务器环境）
//@property (nonatomic,assign)Review_State localReviewStatus;

#warning - 每次提审时改为1，通过后务必将该状态改为2
@property (nonatomic,strong)NSString *iOSReviewState;
//版本号 如果当前版本号与bundle版本号小于该版本号 提示升级
@property (nonatomic,strong)NSString *iOSVersion;
//控制版本更新弹窗时使用该版本号，与后台协商后决定，更新后两个版本号都要更新，且保持一致
@property (nonatomic,strong)NSString *realVersion;
@property (nonatomic,strong)NSString *AndroidVersion;
@property (nonatomic,strong)NSString *warning;
@property (nonatomic,assign)BOOL canPlay;//只要不在播放列表 都可以设置为NO
@property (nonatomic,assign)BOOL isFirstVerify;//是否是第一次认证通过;
@property (nonatomic,assign)BOOL isVerified;//是否是第一次认证通过;

- (void)save ;

- (void)clear ;
@end



