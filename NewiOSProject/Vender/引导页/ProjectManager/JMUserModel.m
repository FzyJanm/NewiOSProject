//
//  JMUserModel.m
//  JMBaseProject
//
//  Created by Liuny on 2020/1/3.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "JMUserModel.h"

@implementation JMUserModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.userId = [dict getJsonValue:@"accountId"];
        self.isMe = [dict getJsonValue:@"isMyself"].boolValue;
        self.name = [dict getJsonValue:@"nick"];
        self.nick = [dict getJsonValue:@"nick"];
        self.headUrl = [dict getJsonValue:@"avatar"];
        self.avatar = [dict getJsonValue:@"avatar"];

        self.backUrl = [dict getJsonValue:@"backgroundPic"];
        self.desc = [dict getJsonValue:@"desc"];
        self.age = [dict getJsonValue:@"age"];
        self.sex = [dict getJsonValue:@"sex"].integerValue;
        self.isAttention = [dict getJsonValue:@"isFocus"].boolValue;
        self.fansNum = [dict getJsonValue:@"followMeCount"];
        self.attentionNum = [dict getJsonValue:@"myFollowCount"];
        self.readnum = [dict getJsonValue:@"readnum"];
        self.address = [dict getJsonValue:@"address"];
    }
    return self;
}
-(BOOL)isMe{
    JMLoginUserModel *loginUser = [JMProjectManager sharedJMProjectManager].loginUser;
    BOOL isMeFaBu = [loginUser.userId isEqualToString:self.userId];
    return isMeFaBu;
}
-(instancetype)initWithTest{
    self = [super init];
    if(self){
        self.name = @"测试用户";
        self.isAttention = YES;
        self.sex = Sex_Male;
        self.desc = @"我是一个测试用户，用于开发测试。";
//        self.city = @"广东 广州";
        self.fansNum = @"15000";
        self.attentionNum = @"400";
        self.age = @"18岁";
    }
    return self;
}

//-(NSString *)showFansNum{
//    return [JMCommonMethod readCountFormat:self.fansNum];
//}
//
//-(NSString *)showAttentionNum{
//    return [JMCommonMethod readCountFormat:self.attentionNum];
//}
//-(NSString *)showReadNum{
//    return [JMCommonMethod readCountFormat:self.readnum];
//}
//-(NSString *)showAge{
//    NSDate *date = [NSDate dateWithString:self.birthday format:@"yyyy-MM-dd"];
//    NSInteger year = [date yearsAgo];
//    return [NSString stringWithFormat:@"%ld",year];
//}
//
//-(NSString *)showShengShiQu{
//    NSString *rtn = [NSString stringWithFormat:@"%@-%@-%@",self.sheng.cityName,self.shi.cityName,self.qu.cityName];
//    return rtn;
//}

/// 返回样式：159****7765
-(NSString *)secretMobile{
    NSString *rtn;
    if(self.mobile.length > 7){
        NSString *startThree = [self.mobile substringToIndex:3];
        NSString *star = @"";
        for(int i=3;i<self.mobile.length-4;i++){
            star = [star stringByAppendingString:@"*"];
        }
        NSString *lastFour = [self.mobile substringFromIndex:(self.mobile.length-4)];
        rtn = [NSString stringWithFormat:@"%@%@%@",startThree,star,lastFour];
    }else{
        rtn = self.mobile;
    }
    return rtn;
}


@end
