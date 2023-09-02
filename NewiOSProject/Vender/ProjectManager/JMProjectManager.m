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
@end
@implementation JMAppConfig
MJCodingImplementation

////带多个小数点的版本判断
//typedef enum:NSInteger{
//    Version_Compare_Lower,
//    Version_Compare_Equal,
//    Version_Compare_Higher,
//}Version_Compare;
//-(Version_Compare)versionCompare:(NSString *)versionStr{
//    Version_Compare rtn = Version_Compare_Equal;
//    NSArray *serviseArray = [versionStr componentsSeparatedByString:@"."];
//    NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    NSArray *localArray = [localVersion componentsSeparatedByString:@"."];
//
//    NSInteger maxCount = serviseArray.count>localArray.count?serviseArray.count:localArray.count;
//    for(int i=0;i<maxCount;i++){
//        int server = 0;
//        if(serviseArray.count > i){
//            NSString *serverVersion = serviseArray[i];
//            server = serverVersion.intValue;
//        }
//        int local = 0;
//        if(localArray.count > i){
//            NSString *localStr = localArray[i];
//            local = localStr.intValue;
//        }
//        if(server == local){
//            continue;
//        }else{
//            if(server>local){
//                rtn = Version_Compare_Lower;
//            }
//            if(server==local){
//                rtn = Version_Compare_Equal;
//            }
//            if(server<local){
//                rtn = Version_Compare_Higher;
//            }
//            break;
//        }
//    }
//    return rtn;
//}

- (void)save {
    [NSKeyedArchiver archiveRootObject:self toFile:kAppConfigSavePath];
}

- (void)clear {
    [[NSFileManager defaultManager] removeItemAtPath:kAppConfigSavePath error:nil];
}
@end
