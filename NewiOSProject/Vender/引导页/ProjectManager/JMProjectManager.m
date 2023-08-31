//
//  JMProjectManager.m
//  JMBaseProject
//
//  Created by liuny on 2018/7/14.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMProjectManager.h"
//#import "JMAppVersionTool.h"
//#import "WectonViewController.h"
//#import "GuideViewController.h"
#import "JMFileManagerHelper.h"


@interface JMProjectManager()
//@property (nonatomic, strong) JMAppVersionTool *appVersionTool;
@end


@implementation JMProjectManager
singleton_implementation(JMProjectManager)
@synthesize loginUser=_loginUser;
@synthesize appConfig=_appConfig;

#pragma mark - 登录用户缓存
-(void)setLoginUser:(JMLoginUserModel *)loginUser{
    if(loginUser){
        _loginUser = loginUser;
        [_loginUser save];
    }else{
        [_loginUser clear];
        _loginUser = loginUser;
    }
}
+(BOOL)isLogin{
    if(JMProjectManager.sharedJMProjectManager.loginUser.sessionId.length==0){
        return NO;
    }else{
        return YES;
    }
}
-(JMLoginUserModel *)loginUser{
    if(_loginUser == nil){
        if([JMFileManagerHelper isExistsAtPath:kLoginUserSavePath]){
            _loginUser = [NSKeyedUnarchiver unarchiveObjectWithFile:kLoginUserSavePath];
        }
    }
    return _loginUser;
}


-(void)setAppConfig:(JMAppConfig *)appConfig{
    if(appConfig){
        _appConfig = appConfig;
        [_appConfig save];
    }else{
        [_appConfig clear];
        _appConfig = appConfig;
    }
}
-(JMAppConfig *)appConfig{
    if(!_appConfig){
        if([JMFileManagerHelper isExistsAtPath:kAppConfigSavePath]){
            _appConfig = [NSKeyedUnarchiver unarchiveObjectWithFile:kAppConfigSavePath];
        }
    }
    return _appConfig;
}


#pragma mark -
//-(void)loadRootVC {
//    GuideViewController *vc = GuideViewController.new;
//    [UIApplication sharedApplication].delegate.window.rootViewController = vc;
//}
//
//
//-(void)showLoginViewController{
//    UIViewController *vc =  UIWindow.jm_currentViewController;
//    if([vc isKindOfClass:AccountLoginVC.class]) return;;
//    AccountLoginVC *loginVC = [[AccountLoginVC alloc] initWithStoryboard];
//    JMNavigationController *nav = [[JMNavigationController alloc] initWithRootViewController:loginVC];
//    nav.modalPresentationStyle = UIModalPresentationFullScreen;
//    [UIWindow.jm_currentViewController presentViewController:nav animated:YES completion:nil];
//}
//-(void)clearLiveDate{
//    JMProjectManager.sharedJMProjectManager.liveConfig.recordId = @"";
//    JMProjectManager.sharedJMProjectManager.liveConfig.anchorId = @"";
//    JMProjectManager.sharedJMProjectManager.liveConfig.goodType = 0;
//    [TUILogin setCurrentAnchorId:@""];//清空当前主播id
//    JMProjectManager.sharedJMProjectManager.liveConfig.configType = 0;
//    JMProjectManager.sharedJMProjectManager.liveConfig.liveGoodsId = @"";
//    [NSUserDefaults.standardUserDefaults removeObjectForKey:@"PKInitiateModel"];
//    [NSUserDefaults.standardUserDefaults removeObjectForKey:@"PKAcceptModel"];
//}
//
//-(void)showMainViewController{
//    JMTabBarController *tabBarVC = [JMTabBarController sharedJMTabBarController];
//    JMNavigationController *navi = [[JMNavigationController alloc]initWithRootViewController:tabBarVC];
//    [UIApplication sharedApplication].delegate.window.rootViewController = navi;
//}

#pragma mark - 版本检测
//-(void)versionCheck:(BOOL)showAlert{
//    if(self.appVersionTool == nil){
//        _appVersionTool = [[JMAppVersionTool alloc] init];
//    }
//    [self.appVersionTool versionCheck:showAlert];
//}
@end




//@class JMCommonMethod;//打开 可前往服务器地址配置文件
@implementation JMAppConfig
MJCodingImplementation
/**
目的：可对特定环境下的服务器进行地址，也可以通过后台设置 iOSReviewState 来切换服务器地址
要求：
1.iOSReviewState和iOSVersion配置后不影响线上环境地址，可以为域名，也可以为IP地址（IP地址暂时没有问题），但不能为测试地址
2.测试机环境下 可通过后台切换测试环境数据
*/



//带多个小数点的版本判断
typedef enum:NSInteger{
    Version_Compare_Lower,
    Version_Compare_Equal,
    Version_Compare_Higher,
}Version_Compare;
-(Version_Compare)versionCompare:(NSString *)versionStr{
    Version_Compare rtn = Version_Compare_Equal;
    NSArray *serviseArray = [versionStr componentsSeparatedByString:@"."];
    NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSArray *localArray = [localVersion componentsSeparatedByString:@"."];
    
    NSInteger maxCount = serviseArray.count>localArray.count?serviseArray.count:localArray.count;
    for(int i=0;i<maxCount;i++){
        int server = 0;
        if(serviseArray.count > i){
            NSString *serverVersion = serviseArray[i];
            server = serverVersion.intValue;
        }
        int local = 0;
        if(localArray.count > i){
            NSString *localStr = localArray[i];
            local = localStr.intValue;
        }
        if(server == local){
            continue;
        }else{
            if(server>local){
                rtn = Version_Compare_Lower;
            }
            if(server==local){
                rtn = Version_Compare_Equal;
            }
            if(server<local){
                rtn = Version_Compare_Higher;
            }
            break;
        }
    }
    return rtn;
}

#warning: - 每次更新XCode编译（提审）版本号必须高于后台版本号（iOSVersion），否则审核环境下不为https苹果那边网络不通，会导致审核不通过！！！！！
-(Review_State)serviceReviewStatus{
    
    if(self.localReviewStatus){
        return self.localReviewStatus;
    }else{
        if(![self.iOSReviewState isKindOfClass:NSString.class] || ![self.iOSVersion isKindOfClass:NSString.class]){
            return Review_State_Rev_User;
        }
        
        Version_Compare result;
        BOOL isOnlineEnvironment;//是否为线上环境
      /**
       1.小于或等于iOSVersion版本号的为线上用户使用版本，大于 即是提审版本
       2.当本地测试debug环境下开启 localReviewStatus ，localReviewStatus优先于 serviceReviewStatus，方便切换测试服务器
       */
        result = [self versionCompare:self.iOSReviewState];
        if(result==Version_Compare_Lower||result==Version_Compare_Equal){
            isOnlineEnvironment = YES;
        }else{
            isOnlineEnvironment = NO;
        }

        if(isOnlineEnvironment){
            return Review_State_Rev_User;
        }else{
            switch (self.iOSReviewState.intValue){
                case -1:
                    return isOnlineEnvironment?Review_State_Rev_User:Review_State_Test;
                    break;
                case 0:
                    return isOnlineEnvironment?Review_State_Rev_User:Review_State_Dev;
                    break;
                case 1:
                    return isOnlineEnvironment?Review_State_Rev_User:Review_State_Rev_Apple;
                    break;
                case 2:
                    return Review_State_Dist;
                    break;
                default:
                    return Review_State_Rev_User;
                    break;
            }
        }
    }
}
- (void)save {
    [NSKeyedArchiver archiveRootObject:self toFile:kAppConfigSavePath];
}

- (void)clear {
    [[NSFileManager defaultManager] removeItemAtPath:kAppConfigSavePath error:nil];
}
@end
