//
//  JMLoginUserModel.m
//  JMBaseProject
//
//  Created by Liuny on 2020/1/3.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "JMLoginUserModel.h"

@implementation JMLoginUserModel
MJCodingImplementation

-(instancetype)initWithLoginDictionary:(NSDictionary *)dict{
    self = [self initWithDictionary:dict];
    if(self){
        self.sessionId = [dict getJsonValue:@"sessionId"];
        self.userId = [dict getJsonValue:@"accountId"];
        if(self.userId.length==0){
            self.userId = [dict getJsonValue:@"id"];
        }
        self.mobile = [dict getJsonValue:@"mobile"];
        
        self.headUrl = [dict getJsonValue:@"avatar"];
        self.backUrl = [dict getJsonValue:@"backgroundPic"];
        self.name = [dict getJsonValue:@"nick"];
        self.nick = [dict getJsonValue:@"nick"];
        self.avatar = [dict getJsonValue:@"avatar"];
        
        self.fansNum = [dict getJsonValue:@"followMeCount"];
        self.attentionNum = [dict getJsonValue:@"myFollowCount"];
        self.age = [dict getJsonValue:@"age"];
//        self.isBindPhone = JMIsEmpty(self.mobile)?NO:YES;
        
        self.isOpenGeShe = [dict getJsonValue:@"isOpenBird"].boolValue;
        self.isOpenAuction = [dict getJsonValue:@"isOpenAuction"].boolValue;
        self.isOpenShop = [dict getJsonValue:@"isOpenShop"].boolValue;
        self.isOpenGongPeng = [dict getJsonValue:@"isOpenBob"].boolValue;
        self.isOpenXieHui = [dict getJsonValue:@"isOpenSociety"].boolValue;
        self.isOpenJuLebu = [dict getJsonValue:@"isOpenClub"].boolValue;
        
        self.address = [dict getJsonValue:@"address"];
        self.desc = [dict getJsonValue:@"desc"];
        self.sex = [dict getJsonValue:@"sex"].integerValue;
        self.isNewFocus = [dict getJsonValue:@"newFocus"].boolValue;
        self.isNewAuction = [dict getJsonValue:@"newAuction"].boolValue;
        self.isOpenLive = [dict getJsonValue:@"isOpenLive"].boolValue;
    }
    return self;
}

- (void)save {
    [NSKeyedArchiver archiveRootObject:self toFile:kLoginUserSavePath];
}

- (void)clear {
    [[NSFileManager defaultManager] removeItemAtPath:kLoginUserSavePath error:nil];
}

-(void)updateInfoWithDictionary:(NSDictionary *)dict{
    self.headUrl = [dict getJsonValue:@"avatar"];
    self.backUrl = [dict getJsonValue:@"backgroundPic"];
    self.name = [dict getJsonValue:@"nick"];
    self.userId = [dict getJsonValue:@"accountId"];
    
    self.fansNum = [dict getJsonValue:@"followMeCount"];
    self.attentionNum = [dict getJsonValue:@"myFollowCount"];
    self.readnum = [dict getJsonValue:@"readnum"];
    self.age = [dict getJsonValue:@"age"];
//    self.isBindPhone = JMIsEmpty(self.mobile)?NO:YES;
    
    self.isOpenGeShe = [dict getJsonValue:@"isOpenBird"].boolValue;
    self.isOpenAuction = [dict getJsonValue:@"isOpenAuction"].boolValue;
    self.isOpenShop = [dict getJsonValue:@"isOpenShop"].boolValue;
    self.isOpenGongPeng = [dict getJsonValue:@"isOpenBob"].boolValue;
    self.isOpenXieHui = [dict getJsonValue:@"isOpenSociety"].boolValue;
    self.isOpenJuLebu = [dict getJsonValue:@"isOpenClub"].boolValue;
    
    self.address = [dict getJsonValue:@"address"];
    self.desc = [dict getJsonValue:@"desc"];
    self.sex = [dict getJsonValue:@"sex"].integerValue;
    self.isNewFocus = [dict getJsonValue:@"newFocus"].boolValue;
    self.isNewAuction = [dict getJsonValue:@"newAuction"].boolValue;
    self.isOpenLive = [dict getJsonValue:@"isOpenLive"].boolValue;

    [self save];
}
@end
