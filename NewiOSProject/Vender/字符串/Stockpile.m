//
//  Stockpile.m
//  CenterFo
//
//  Created by apple on 14-7-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Stockpile.h"



#define userNameKey         @"dfUserName"
#define passwordKey         @"dfPassword"
#define IDKey                    @"dfID"
#define Logo                        @"kLogo"
#define ISLoginKey          @"kLogin"
#define ISgin          @"ISgin"

#define CityKey                 @"kCity"
#define ShengKey                 @"kSheng"
#define RoleKey              @"kRole"
#define SexKey                 @"kSex"
#define OnLineKey                 @"kOnLine"
#define YuEKey                 @"kYuE"
#define kNickname                 @"kNickname"
#define kName                 @"kName"
#define SaveKey                 @"kSave"
#define LogPwdKey            @"LogPwdKey"
#define SecretKey            @"isSecretKey"
#define TokenKey            @"isTokenKey"
#define ModelKey            @"isModelKey"
#define AccountKey             @"isAccountKey"
#define AccountTypeKey          @"isAccountTypeKey"
#define klv                      @"klv"
#define kage                      @"kage"
#define kaddress                      @"kaddress"
#define kmoney                      @"kmoney"
#define ktel                      @"ktel"
#define kqm                      @"kqm"
#define kjiFen                      @"kjiFen"
#define kcode                      @"kcode"
#define kcityID                      @"kcityID"
#define kefuId                      @"kefuId"
#define knoban                      @"moban"
#define kgesturePwd                @"kgesturePwd"
#define kMMMmNum                @"kMMMmNum"
#define KMMMBiao                @"KMMMBiao"
#define KMMMshou                @"KMMMshou"
#define KMMMkaihu                @"KMMMkaihu"
#define krongToken                @"krongToken"

#define kappad                @"kappad"
#define khomead                @"khomead"

/** 中航 */
#define kCompany                @"kCompany"
#define kPosition                @"kPosition"
#define kEmail                @"kEmail"
#define kIconUrl                @"kIconUrl"
#define kLayout                @"kLayout"
#define kStatus                @"kStatus"

#define kAble                @"kAble"
#define kLoginStatus                @"kLoginStatus"

#define kVipStatus                @"kVipStatus"
#define kType                @"kType"
#define kLoginType                @"kLoginType"
#define kEncodeIcon                @"kEncodeIcon"
#define kShopCartNum            @"kShopCartNum"
#define kBirthday            @"kBirthday"



// .m
// \ 代表下一行也属于宏
// ## 是分隔符
#define single_implementation(class) \
static class *_instance; \
\
+ (class *)shared##class \
{ \
if (_instance == nil) { \
_instance = [[self alloc] init]; \
} \
return _instance; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
}

@implementation Stockpile

single_implementation(Stockpile);

#pragma mark -私有方法

- (NSString *)loadStringFromDefaultsWithKey:(NSString *)key
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return (str && str.length>0) ? str : @"";

}

- (NSData *)loadDataFromDefaultsWithKey:(NSString *)key{
    return  [[NSUserDefaults standardUserDefaults] dataForKey:key];
}


-(NSString *)longtitude{
    
    return [self loadStringFromDefaultsWithKey:@"klong"];
}

-(void)setLongtitude:(NSString *)longtitude{
    [longtitude saveToNSDefaultsWithKey:@"klong"];
}

-(NSString *)latitude{
    
    return [self loadStringFromDefaultsWithKey:@"klat"];
}


-(void)setGesturePwd:(NSString *)gesturePwd{
    [gesturePwd saveToNSDefaultsWithKey:kgesturePwd];
}
-(NSString *)gesturePwd{
    return [self loadStringFromDefaultsWithKey:kgesturePwd];
}

-(void)setLatitude:(NSString *)latitude{
    [latitude saveToNSDefaultsWithKey:@"klat"];
}

#pragma mark 写入系统偏好
- (void)saveToNSDefaultsWithKey1:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setName:(NSString *)Name{
    [Name saveToNSDefaultsWithKey:kName];
}
-(NSString *)Name{
    NSString *city=[self loadStringFromDefaultsWithKey:kName];
//    if (!city|| city.length<1 || [city isEmptyString]) {
//        city=[self loadStringFromDefaultsWithKey:userNameKey];
//    }
    return city;
}

#pragma mark - 类型
-(NSString *)Account{
    NSString *city=[self loadStringFromDefaultsWithKey:AccountKey];
    city=[city trimString];
    if (!city|| city.length<1 || [city isEmptyString]) {
        city=@"";
    }
    return city;
}
-(void)setAccount:(NSString *)Account{
    [Account saveToNSDefaultsWithKey:AccountKey];
}
-(NSString*)AccountType{
    NSString *city= [self loadStringFromDefaultsWithKey:AccountTypeKey];
     city=[city trimString];
    if (!city|| city.length<1 || [city isEmptyString]) {
        city=@"";
    }
    return  city;
}
-(void)setAccountType:(NSString *)AccountType{
    [AccountType saveToNSDefaultsWithKey:AccountTypeKey];
}

-(NSString *)keFuId{
    return [self loadStringFromDefaultsWithKey:kefuId];
}

-(void)setKeFuId:(NSString *)keFuId{

    [keFuId saveToNSDefaultsWithKey:kefuId];
}

-(void)setCity:(NSString *)City
{
    [City saveToNSDefaultsWithKey:CityKey];
}
-(NSString*)City
{
    NSString *city=[self loadStringFromDefaultsWithKey:CityKey];
     city=[city trimString];
    if (!city|| city.length<1 || [city isEmptyString] || ![city isChinese]) {
        city=@"郑州市";
    }
    return city;
}
-(NSString *)Sheng{
    NSString *city=[self loadStringFromDefaultsWithKey:ShengKey];
     city=[city trimString];
    if (!city|| city.length<1 || [city isEmptyString] || ![city isChinese]) {
        city=@"河南";
    }
    city=[city stringByReplacingOccurrencesOfString:@"省" withString:@""];
    city=[city stringByReplacingOccurrencesOfString:@"市" withString:@""];
    return city;
}
-(void)setSheng:(NSString *)Sheng{
     [Sheng saveToNSDefaultsWithKey:ShengKey];
}

-(NSString *)YUE{
    NSString *city=[self loadStringFromDefaultsWithKey:YuEKey];
    return city;
}
-(void)setYUE:(NSString *)YUE{
    
    [YUE saveToNSDefaultsWithKey:YuEKey];
}


-(NSString *)appAD{
    NSString *city=[self loadStringFromDefaultsWithKey:kappad];
    return city;
}
-(void)setAppAD:(NSString *)appAD{
    
    [appAD saveToNSDefaultsWithKey:kappad];
}


-(NSString *)homeAD{
    NSString *city=[self loadStringFromDefaultsWithKey:khomead];
    return city;
}
-(void)setHomeAD:(NSString *)homeADpAD{
    
    [homeADpAD saveToNSDefaultsWithKey:khomead];
}

-(NSString *)ONLine{
    NSString *city=[self loadStringFromDefaultsWithKey:OnLineKey];
     city=[city trimString];
    city=[NSString stringWithFormat:@"%.2f",[city floatValue]];
    if ([city floatValue]==0) {
        city=@"0";
    }
    return city;
}
-(void)setONLine:(NSString *)ONLine{
    
     [ONLine saveToNSDefaultsWithKey:OnLineKey];
}
-(NSString *)Role{
    NSString *city=[self loadStringFromDefaultsWithKey:RoleKey];
     city=[city trimString];
    if (!city|| city.length<1 || [city isEmptyString] ) {
        city=@"0";
    }
    return city;
}
-(void)setRole:(NSString *)Role{
    
    [Role saveToNSDefaultsWithKey:RoleKey];
}
-(void)setNickName:(NSString *)nickName
{
    [nickName saveToNSDefaultsWithKey:kNickname];
}
-(NSString *)nickName
{
    return [self loadStringFromDefaultsWithKey:kNickname];
}

-(NSString *)money
{
    return [self loadStringFromDefaultsWithKey:kmoney];
}

- (void)setMoney:(NSString *)money{
    [money saveToNSDefaultsWithKey:kmoney];
}


-(NSString *)MMMmNum
{
    return [self loadStringFromDefaultsWithKey:kMMMmNum];
}

- (void)setMMMmNum:(NSString *)MMMmNum{
    [MMMmNum saveToNSDefaultsWithKey:kMMMmNum];
}

-(NSString *)MMMBiao
{
    return [self loadStringFromDefaultsWithKey:KMMMBiao];
}

- (void)setMMMBiao:(NSString *)MMMBiao{
    [MMMBiao saveToNSDefaultsWithKey:KMMMBiao];
}





-(NSString *)jiFen
{
    return [self loadStringFromDefaultsWithKey:kjiFen];
}



- (void)setJiFen:(NSString *)jiFen{
    [jiFen saveToNSDefaultsWithKey:kjiFen];
}

-(NSString *)tel
{
    return [self loadStringFromDefaultsWithKey:ktel];
}
-(void)setTel:(NSString *)tel{
    [tel saveToNSDefaultsWithKey:ktel];
}

-(void)setMoBanType:(NSString *)MoBanType{
    NSLog(@"%@",MoBanType);
    
    [MoBanType saveToNSDefaultsWithKey:knoban];

}

-(NSString *)MoBanType{
    return [self loadStringFromDefaultsWithKey:knoban];
}


-(NSString *)isQi{
    return [self loadStringFromDefaultsWithKey:@"kisQi"];
}


-(void)setIsQi:(NSString *)isQi{

    [isQi saveToNSDefaultsWithKey:@"kisQi"];
}

-(NSString *)code
{
    return [self loadStringFromDefaultsWithKey:kcode];
}

-(void)setCode:(NSString *)code{
    [code saveToNSDefaultsWithKey:kcode];
}

-(NSString *)address
{
    return [self loadStringFromDefaultsWithKey:kaddress];
}

-(void)setAddress:(NSString *)address{
    [address saveToNSDefaultsWithKey:kaddress];
}

-(void)setQiLogo:(NSString *)qiLogo{
    [qiLogo saveToNSDefaultsWithKey:@"qiLogo"];
}
-(NSString *)qiLogo{
    return [self loadStringFromDefaultsWithKey:@"qiLogo"];
}

-(NSString *)lv
{
    return [self loadStringFromDefaultsWithKey:klv];
}
-(void)setLv:(NSString *)lv{
    [lv saveToNSDefaultsWithKey:klv];
}
-(NSString *)qm
{
    return [self loadStringFromDefaultsWithKey:kqm];
}

-(NSString *)cityID{
    return [self loadStringFromDefaultsWithKey:kcityID];

}
-(void)setCityID:(NSString *)cityID{

    [cityID saveToNSDefaultsWithKey:kcityID];
}
-(void)setQm:(NSString *)qm{
    [qm saveToNSDefaultsWithKey:kqm];
}

-(NSString *)age
{
    return [self loadStringFromDefaultsWithKey:kage];
}



-(void)setAge:(NSString *)age{
    [age saveToNSDefaultsWithKey:kage];
}

-(void)setLogo:(NSString *)logo
{
    [logo saveToNSDefaultsWithKey:Logo];
}
-(NSString *)logo
{

    return [self loadStringFromDefaultsWithKey:Logo];
}
- (NSString *)userName{
    
    NSString *city=[self loadStringFromDefaultsWithKey:userNameKey];
     city=[city trimString];
    if (!city|| city.length<1 || [city isEmptyString] ) {
        city=@"";
    }
    return city;
}
- (void)setUserName:(NSString *)userName{
    [userName saveToNSDefaultsWithKey:userNameKey];
    
}
-(void)setSex:(NSString *)sex{
    [sex saveToNSDefaultsWithKey:SexKey];
}
-(NSString *)sex{
    
    
    return [self loadStringFromDefaultsWithKey:SexKey];
}
- (NSString *)password{
    return [self loadStringFromDefaultsWithKey:passwordKey];
}
- (void)setPassword:(NSString *)password{
    [password saveToNSDefaultsWithKey:passwordKey];
}

- (NSString *)ID{
    return [self loadStringFromDefaultsWithKey:IDKey];
}
- (void)setID:(NSString *)ID{
    [ID saveToNSDefaultsWithKey:IDKey];
}
-(NSString *)LogPwd{
     return [self loadStringFromDefaultsWithKey:LogPwdKey];
}
-(void)setToken:(NSString *)token{
    [token saveToNSDefaultsWithKey:TokenKey];
}
-(NSString *)token{
    return [self loadStringFromDefaultsWithKey:TokenKey];
}


-(void)setRongToken:(NSString *)rongToken{
    [rongToken saveToNSDefaultsWithKey:krongToken];
}
-(NSString *)rongToken{
    return [self loadStringFromDefaultsWithKey:krongToken];
}


-(void)setLogPwd:(NSString *)LogPwd{
    [LogPwd saveToNSDefaultsWithKey:LogPwdKey];
}
-(BOOL)isLogin{
    return [[NSUserDefaults standardUserDefaults]boolForKey:ISLoginKey];
}
-(void)setIsLogin:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults]setBool:isLogin forKey:ISLoginKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)isSign{
    return [[NSUserDefaults standardUserDefaults]boolForKey:ISgin];

}

-(void)setIsSign:(BOOL)isSign{
    [[NSUserDefaults standardUserDefaults]setBool:isSign forKey:ISgin];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(BOOL)isSave{
    return [[NSUserDefaults standardUserDefaults]boolForKey:SaveKey];
}
-(void)setIsSave:(BOOL)isSave{
    [[NSUserDefaults standardUserDefaults]setBool:isSave forKey:SaveKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setSecret:(BOOL)Secret{
    [[NSUserDefaults standardUserDefaults]setBool:Secret forKey:SecretKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)Secret{
    return [[NSUserDefaults standardUserDefaults]boolForKey:SecretKey];
}

-(void)setModel:(NSMutableDictionary *)model{
    NSMutableDictionary *Mdic=[NSMutableDictionary new];
    NSArray *WKeys=[model allKeys];
    for (id key in WKeys) {
        id obj=[model objectForKey:key];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *Ndic=[NSMutableDictionary new];
            NSArray *NKeys=[obj allKeys];
            for (id nkey in NKeys) {
                id nobj=[obj objectForKey:nkey];
                NSString *value=[[[NSString stringWithFormat:@"%@",nobj] trimString] EmptyStringByWhitespace];
                [Ndic setObject:value forKey:nkey];
            }
            [Mdic setObject:Ndic forKey:key];
        }else{
             NSString *value=[[[NSString stringWithFormat:@"%@",obj] trimString] EmptyStringByWhitespace];
            [Mdic setObject:value forKey:key];
        }
       
        
    }
    [[NSUserDefaults standardUserDefaults]setObject:Mdic forKey:ModelKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSMutableDictionary *)model{
    return [[NSUserDefaults standardUserDefaults] objectForKey:ModelKey];
}


-(NSString *)hideStatus
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"hideStatus"];
    return str;
}
-(void)setHideStatus:(NSString *)hideStatus
{
    [[NSUserDefaults standardUserDefaults]setObject:hideStatus forKey:@"hideStatus"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)userID
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    return str;
}
-(void)setUserID:(NSString *)userID
{
    [[NSUserDefaults standardUserDefaults]setObject:userID forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)userPwd
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPwd"];
    return str;
}
-(void)setUserPwd:(NSString *)userPwd
{
    [[NSUserDefaults standardUserDefaults]setObject:userPwd forKey:@"userPwd"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



-(BOOL)isSHOU{
    return [[NSUserDefaults standardUserDefaults]boolForKey:KMMMshou];
}
-(void)setIsSHOU:(BOOL)isSHOU
{
    [[NSUserDefaults standardUserDefaults]setBool:isSHOU forKey:KMMMshou];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)isKAIHU{
    return [[NSUserDefaults standardUserDefaults]boolForKey:KMMMkaihu];
}
-(void)setIsKAIHU:(BOOL)isKAIHU
{
    [[NSUserDefaults standardUserDefaults]setBool:isKAIHU forKey:KMMMkaihu];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/** 中航 */

-(void)setEmail:(NSString *)Email {
    [Email saveToNSDefaultsWithKey:kEmail];
}
- (NSString *)Email {
    return [self loadStringFromDefaultsWithKey:kEmail];
}
-(void)setCompany:(NSString *)Company {
    [Company  saveToNSDefaultsWithKey:kCompany];
}
-(NSString *)Company {
    return [self loadStringFromDefaultsWithKey:kCompany];
}
-(NSString *)Position {
    return [self loadStringFromDefaultsWithKey:kPosition];
    
}
-(void)setPosition:(NSString *)Position {
    [Position saveToNSDefaultsWithKey:kPosition];
}
-(NSString *)iconUrl {
    return [self loadStringFromDefaultsWithKey:kIconUrl];
}

-(void)setIconUrl:(NSString *)iconUrl {
    [iconUrl saveToNSDefaultsWithKey:kIconUrl];
}
-(void)setLayout:(NSString *)Layout {
    [Layout saveToNSDefaultsWithKey:kLayout];
}
-(NSString *)Layout {
    return [self loadStringFromDefaultsWithKey:kLayout];
}
-(void)setStatus:(NSString *)Status {
    [Status saveToNSDefaultsWithKey:kStatus];
}
-(NSString *)Status {
    return [self loadStringFromDefaultsWithKey:kStatus];
}

-(void)setAble:(NSString *)Able {
    [Able saveToNSDefaultsWithKey:kAble];
}
-(NSString *)Able {
    return [self loadStringFromDefaultsWithKey:kAble];
}
-(NSString *)LoginStatus {
    return [self loadStringFromDefaultsWithKey:kLoginStatus];
}
-(void)setLoginStatus:(NSString *)LoginStatus {
    [LoginStatus saveToNSDefaultsWithKey:kLoginStatus];
}

-(void)setVipStatus:(NSString *)VipStatus {
    [VipStatus saveToNSDefaultsWithKey:kVipStatus];
}
-(NSString *)VipStatus {
    return  [self loadStringFromDefaultsWithKey:kVipStatus];
}
-(NSString *)type {
    return [self loadStringFromDefaultsWithKey:kType];
}
-(void)setType:(NSString *)type {
    [type saveToNSDefaultsWithKey:kType];
}

-(NSString *)loginType {
    return [self loadStringFromDefaultsWithKey:kLoginType];
}
-(void)setLoginType:(NSString *)loginType {
    [loginType saveToNSDefaultsWithKey:kLoginType];
}

-(void)setEncodedIconStr:(NSString *)encodedIconStr {
    [encodedIconStr saveToNSDefaultsWithKey:kEncodeIcon];
}
-(NSString *)encodedIconStr {
    return [self loadStringFromDefaultsWithKey:kEncodeIcon];
}
//-(void)setShopCartNum:(NSInteger )shopCartNum {
//
//    [@(shopCartNum).stringValue saveToNSDefaultsWithKey:kShopCartNum];
//
//}
//-(NSInteger)shopCartNum {
//
//    return [self loadStringFromDefaultsWithKey:kShopCartNum].integerValue;
//
//}
-(void)setShopCartNum:(NSString *)shopCartNum {

    [shopCartNum saveToNSDefaultsWithKey:kShopCartNum];

}
-(NSString *)shopCartNum {

    return [self loadStringFromDefaultsWithKey:kShopCartNum];
}
-(void)setBirthday:(NSString *)birthday {
    [birthday saveToNSDefaultsWithKey:kBirthday];
}
-(NSString *)birthday {
    return [self loadStringFromDefaultsWithKey:kBirthday];
}
@end
