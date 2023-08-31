//
//  JMCommonMacro.h
//  JMBaseProject
//
//  Created by liuny on 2018/7/14.
//  Copyright © 2018年 liuny. All rights reserved.
//
#ifndef JMCommonMacro_h
#define JMCommonMacro_h

#ifdef DEBUG
// 调试阶段
#define JMLog(...) NSLog(__VA_ARGS__)
#else
// 发布阶段
#define JMLog(...)
#endif


#ifdef DEBUG
// 调试阶段
#define NSLog(...) printf("%f %s 第%d行: %s\n",[[NSDate date]timeIntervalSince1970],__PRETTY_FUNCTION__,__LINE__, [[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
// 发布阶段
#define NSLog(...);
#endif

#define ShareBaseUrl    @"https://www.chinagebao.com/gebao_H5/"

#define ImageBaseUrl    @"https://gebao.oss-cn-beijing.aliyuncs.com"


//是否是空对象
#define JMIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//属性转字符串
#define JMKeyPath(obj, key) @(((void)obj.key, #key))

//弱引用/强引用  可配对引用在外面用JMWeak(self)，block用MPStrongSelf(self)  也可以单独引用在外面用JMWeak(self) block里面用weakself
#define JMWeak(type)  __weak typeof(type) weak##type = type

// 顶部安全区高度.
#define  JM_HeightStatusBar     [UIApplication sharedApplication].statusBarFrame.size.height

// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告。
#define XP_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

// Status bar & navigation bar height.
#define  XP_StatusBarAndNavigationBarHeight  (XP_iPhoneX ? 88.f : 64.f)

// 底部安全区高度.
#define JM_HeightBottomSafeArea \
({float height = 0;\
if (@available(iOS 11.0, *)) {\
height = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;\
}\
(height);})

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, BorderWidth, BorderColor)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(BorderWidth)];\
[View.layer setBorderColor:[BorderColor CGColor]]
// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// ——————— 颜色 ————————

//背景灰
#define kColorBackgroundGray \
({ UIColor *color;\
if (@available(iOS 11.0, *)) {\
color = [UIColor colorNamed:@"Global_BackgroundGray"];\
} else {\
color = [UIColor colorWithHexString:@"#F5F5F5"];\
}\
(color);\
})

//全局色调
#define kColorMain \
({ UIColor *color;\
if (@available(iOS 11.0, *)) {\
color = [UIColor colorNamed:@"Global_Main"];\
} else {\
color = [UIColor colorWithHexString:@"#FE5455"];\
}\
(color);\
})

//文本黑
#define kColorTextBlack \
({ UIColor *color;\
if (@available(iOS 11.0, *)) {\
color = [UIColor colorNamed:@"Global_TextBlack"];\
}else{\
color = [UIColor colorWithHexString:@"#333333"];\
}\
(color);\
})

//文本灰
#define kColorTextGray \
({ UIColor *color;\
if (@available(iOS 11.0, *)) {\
color = [UIColor colorNamed:@"Global_TextGray"];\
} else {\
color = [UIColor colorWithHexString:@"#999999"];\
}\
(color);\
})

//文本深灰
#define kColorTextDarkGray \
({ UIColor *color;\
if (@available(iOS 11.0, *)) {\
color = [UIColor colorNamed:@"Global_TextDarkGray"];\
} else {\
color = [UIColor colorWithHexString:@"#666666"];\
}\
(color);\
})

//分割线灰
#define kColorSeparator \
({ UIColor *color;\
if (@available(iOS 11.0, *)) {\
color = [UIColor colorNamed:@"Global_Separator"];\
}else{\
color = [UIColor colorWithHexString:@"#EEEEEE"];\
}\
(color);\
})

//边框线灰
#define kColorBorderGray \
({ UIColor *color;\
if (@available(iOS 11.0, *)) {\
color = [UIColor colorNamed:@"Global_BorderGray"];\
} else {\
color = [UIColor colorWithHexString:@"#DDDDDD"];\
}\
(color);\
})

//navigation tint color
#define kColorNavigationTint    [UIColor whiteColor]
#define kColorNavigationItemYellow      [UIColor colorWithHexString:@"#EFDE23"]

// ——————— 字体 ————————
#define kFontSizeNavigation 18.0


// ——————— 数据处理宏定义 ————————
#define kResponseNoData  @"服务器无数据返回"
#define kResponseLogout  @"用户尚未登录"
#define kResponseEmpty   @"返回数据为空"
#define kRequestFailure  @"网络请求异常，请检查网络"
#define kDisconnect      @"与服务器断开连接，请重连"

typedef enum : NSInteger{
    Sex_Female = 1,     //女
    Sex_Male = 0,           //男
    Sex_Secrecy = -1,        //保密
} Sex_E;


/**
 渐变方式
 
 - FXGradientChangeDirectionHorizontal:              水平渐变
 - FXGradientChangeDirectionVertical:           竖直渐变
 - FXGradientChangeDirectionUpwardDiagonalLine: 向下对角线渐变
 - FXGradientChangeDirectionDownDiagonalLine:   向上对角线渐变
 */
typedef NS_ENUM(NSInteger, FXGradientChangeDirection) {
    FXGradientChangeDirectionHorizontal,
    FXGradientChangeDirectionVertical,
    FXGradientChangeDirectionUpwardDiagonalLine,
    FXGradientChangeDirectionDownDiagonalLine,
};

/** 导航，tab*/
CG_INLINE CGFloat effectViewAlpha() {
    return 0.9;
}
/** 导航，tab*/
CG_INLINE UIViewContentMode defaultImgContentMode() {
    return UIViewContentModeScaleAspectFit;
}

CG_INLINE BOOL IS_iPhoneX() {
    BOOL isPhoneX = NO;
    if ([UIApplication sharedApplication].statusBarFrame.size.height>20) {
        isPhoneX = YES;
    }
    return isPhoneX;
}


CG_INLINE CGFloat StatusBar_Height() {
    CGFloat statusBarHeight =  [[UIApplication sharedApplication] keyWindow].frame.size.height;
    if (@available(iOS 13.0, *)) {
        statusBarHeight =  [UIApplication sharedApplication].windows[0].windowScene.statusBarManager.statusBarFrame.size.height;
    }else{
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}


CG_INLINE CGFloat NAVIGATION_BAR_HEIGHT() {
    return 44 + StatusBar_Height();
}
CG_INLINE CGFloat kDefaultLineSpacing() {
    return 3;
}
/** 屏幕宽度 */
CG_INLINE CGFloat kAppW() {
    return [[UIScreen mainScreen]bounds].size.width;
}

/** 屏幕高度*/
CG_INLINE CGFloat kAppH() {
    return [[UIScreen mainScreen]bounds].size.height;
}
CG_INLINE CGFloat ScaleW(CGFloat s){
    CGFloat scale = 1;
    if(kAppH()>480){//iphone 4以上
        if(IS_iPhoneX()){
            scale = kAppW()/375.0;
        }else{
            scale = kAppH()/667;
        }
    }
    return s*scale;
}
CG_INLINE CGFloat PageTopBgImgHeight() {
    return ScaleW(185);
}
CG_INLINE CGFloat PageIconTop() {
    return ScaleW(-25);
}
CG_INLINE CGFloat IOS11_OR_LATER_SPACE(float par) {
    float space = 0.0;
    if (@available(iOS 11.0, *))
    space = par;
    return space;
}

CG_INLINE UIWindow * JF_KEY_WINDOW() {
    return [UIApplication sharedApplication].windows[0];
}

CG_INLINE CGFloat JF_TOP_SPACE() {
    return IOS11_OR_LATER_SPACE(JF_KEY_WINDOW().safeAreaInsets.top);
}

CG_INLINE CGFloat JF_TOP_ACTIVE_SPACE() {
    return IOS11_OR_LATER_SPACE(MAX(0, JF_KEY_WINDOW().safeAreaInsets.top-20));
}

CG_INLINE CGFloat JF_BOTTOM_SPACE() {
    return IOS11_OR_LATER_SPACE(JF_KEY_WINDOW().safeAreaInsets.bottom);
}

CG_INLINE CGFloat TAB_BAR_HEIGHT() {
    return IS_iPhoneX() ? (49 + JF_BOTTOM_SPACE()) : 49;
}

/** 导航条所有控件中心 Y值*/
CG_INLINE float kCenterY() {
    return 44 / 2 + StatusBar_Height();
}

/** 屏幕比例宽度 */
CG_INLINE CGFloat kScaleWidth(float x) {
    return x*kAppW()/375.00;
}

/** 屏幕比例高度 */
CG_INLINE CGFloat kScaleHeight(float x) {
    return x*kAppH()/667.00;
}
CG_INLINE BOOL kDeviceIsiPhoneX() {
     BOOL iPhoneX = NO;
      if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
          return iPhoneX;
      }
      if (@available(iOS 11.0, *)) {
          UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
          if (mainWindow.safeAreaInsets.bottom > 0.0) {
              iPhoneX = YES;
          }
      }
      return iPhoneX;
}
/**
 底部安全区域高度

 @return 高度
 */
CG_INLINE CGFloat kSafeAreaBottomHeight(){
    return kDeviceIsiPhoneX() ? 34 : 0;
}
CG_INLINE CGFloat kSafeAreaTopHeight(){
    return IOS11_OR_LATER_SPACE(JF_KEY_WINDOW().safeAreaInsets.top);
}
CG_INLINE CGFloat kSafeAreaBottom(){
    return (kAppH() - kSafeAreaBottomHeight());
}
CG_INLINE CGFloat kSafeAreaTop(){
    return (kAppH() - kSafeAreaTopHeight());
}
static inline UIColor *Hex_Str_COLOR(NSString *_STR_) {
    if (_STR_.length!=7) {
        NSLog(@"=============================颜色值%@传错了=========================",_STR_);
        return UIColor.clearColor;
    }
    return  ([UIColor colorWithRed:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(1, 2)] UTF8String], 0, 16)] intValue] / 255.0 green:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(3, 2)] UTF8String], 0, 16)] intValue] / 255.0 blue:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(5, 2)] UTF8String], 0, 16)] intValue] / 255.0 alpha:1]);
}
static inline UIColor *HexAlpha_Str_COLOR(NSString *_STR_,CGFloat alpha) {
    if (_STR_.length!=7) {
        NSLog(@"=============================颜色值%@传错了=========================",_STR_);
        return UIColor.clearColor;
    }
    return  ([UIColor colorWithRed:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(1, 2)] UTF8String], 0, 16)] intValue] / 255.0 green:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(3, 2)] UTF8String], 0, 16)] intValue] / 255.0 blue:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(5, 2)] UTF8String], 0, 16)] intValue] / 255.0 alpha:alpha]);
}
static inline UIColor *RGBColor(NSInteger r,NSInteger g,NSInteger b)  {
    return  [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f];
}
static inline UIColor *RGBAColor(NSInteger r,NSInteger g,NSInteger b ,CGFloat a)  {
    return  [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a];
}

///** 导航名称，类目名称  最黑 */
CG_INLINE UIColor * Text_COLOR_LEVEL1() {
    return Hex_Str_COLOR(@"#333333");
}

///** 次要字体颜色 */
CG_INLINE UIColor * Text_COLOR_LEVEL2() {
    return Hex_Str_COLOR(@"#666666");
}

///** 辅助字体颜色 */
CG_INLINE UIColor * Text_COLOR_LEVEL3() {
    return Hex_Str_COLOR(@"#9E9E9E");
}
///** cell背景颜色颜色 */
CG_INLINE UIColor * CellBGClolr() {
    return Hex_Str_COLOR(@"#41403E");
}
///** 分割线颜色 */
CG_INLINE UIColor * Cut_Line_COLOR() {
    return Hex_Str_COLOR(@"#979797");
}

///** 背景颜色 */
CG_INLINE UIColor * BG_COLOR() {
    return Hex_Str_COLOR(@"#191A1E");
}
///** 主灰色 */
CG_INLINE UIColor * Gray_COLOR() {
    return Hex_Str_COLOR(@"#24252A");
}
// 字体大小
CG_INLINE UIFont * Font(float font) {
    return [UIFont systemFontOfSize:floor(ScaleW(font))];
}

CG_INLINE UIFont * BoldFont(float font) {
    return [UIFont boldSystemFontOfSize:floor(ScaleW(font))];
}


CG_INLINE CGFloat FontH(NSInteger s) {
    return [UIFont systemFontOfSize:ScaleW(s)].lineHeight;
}
CG_INLINE CGFloat FontW(UIFont *font,NSString *str) {
    return  [str boundingRectWithSize:CGSizeMake(MAXFLOAT, font.lineHeight)\
                              options:NSStringDrawingUsesLineFragmentOrigin\
                           attributes:@{NSFontAttributeName:font}\
                              context:nil].size.width;
}
CG_INLINE CGFloat  BFontHeight(float font) {
    return [UIFont boldSystemFontOfSize:font].lineHeight;
}
//宏定义检测block是否可用
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };


static inline BOOL isPhoneNum (NSString *phone) {
    
    return phone.length == 11 || phone.length == 10 || phone.length == 12 || phone.length == 7 || phone.length == 8;
}

static inline BOOL isNullOrHaveNoData(id value) {
    if (value == nil
        || [value isKindOfClass:[NSNull class]]
        || [value isEqual:[NSNull null]]
        || ([value respondsToSelector:@selector(length)] && [(NSData *)value length] == 0)
        || ([value respondsToSelector:@selector(count)] && [(NSArray *)value count] == 0)) {
        return YES;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        if (((NSNumber *)value) == 0) {
            return YES;
        }
    }
    
    if ([value isKindOfClass:[NSArray class]]) {
        if (((NSArray *)value).count == 0) {
            return YES;
        }
    }
    
    if ([value isKindOfClass:[NSString class]]) {
        if (((NSString *)value).length == 0 ||[value isEqualToString:@"(null)"]) {
            return YES;
        }
    }
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = value;
        if (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0) {
            return YES;
        }
    }
    return NO;
}


/** 【缓存】的方式加载本地图片（系统自动缓存） imageNamed  返回 UIImage * */
CG_INLINE UIImage * ImageNamed(NSString * name) {
    return [UIImage imageNamed:name];
}

/** 【不缓存】的方式加载本地图片（系统不自动缓存） imageWithContentsOfFile  返回 UIImage * */
CG_INLINE UIImage * ImageWithContentsOfFile(NSString * name) {
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] bundlePath], name]];
}


/** 主题色 */
CG_INLINE UIColor * mainSchemeColor() {
    return Hex_Str_COLOR(@"#FA446C");
}
/** 主题色 */
CG_INLINE UIColor * LiveSepartorColor() {
    return HexAlpha_Str_COLOR(@"#979797", 0.12);
}
/** 白色 */
CG_INLINE UIColor * WhiteColor() {
    return UIColor.whiteColor;
}
/** 白色 */
CG_INLINE UIColor * WhiteColor_1() {
    return RGBColor(230, 230, 230);
}
/** 渐变主色 开始 */
CG_INLINE UIColor * mainStartColor() {
    return Hex_Str_COLOR(@"#FD2C56");
}
/** 渐变主色 结束 */
CG_INLINE UIColor * mainEndColor() {
    return Hex_Str_COLOR(@"#FE38C7");
}
/** 渐变主色 结束 */
CG_INLINE UIColor * mainSepartorColor() {
    return HexAlpha_Str_COLOR(@"#979797", .2);

}
/** 渐变主色 结束 */
CG_INLINE UIColor * placeholderColor() {
    return HexAlpha_Str_COLOR(@"#979797", 1);
}
/** 渐变主色 结束 */
CG_INLINE UIColor * mainGradientColor(CGSize size) {
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGPoint startPoint = CGPointZero;

    gradientLayer.startPoint = startPoint;
    
    CGPoint endPoint = CGPointZero;
    endPoint = CGPointMake(1.0, 0.0);

    gradientLayer.endPoint = endPoint;
    
    gradientLayer.colors = @[(__bridge id)mainStartColor().CGColor, (__bridge id)mainEndColor().CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}

/** 渐变主色 结束 */
CG_INLINE UIColor * GradientColor(CGSize size ,FXGradientChangeDirection direction,NSString *startColorHexString,NSString *endColorHexString) {
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGPoint startPoint = CGPointZero;
    if (direction == FXGradientChangeDirectionDownDiagonalLine) {
        startPoint = CGPointMake(0.0, 1.0);
    }
    gradientLayer.startPoint = startPoint;
    
    CGPoint endPoint = CGPointZero;
    switch (direction) {
        case FXGradientChangeDirectionHorizontal:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        case FXGradientChangeDirectionVertical:
            endPoint = CGPointMake(0.0, 1.0);
            break;
        case FXGradientChangeDirectionUpwardDiagonalLine:
            endPoint = CGPointMake(1.0, 1.0);
            break;
        case FXGradientChangeDirectionDownDiagonalLine:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        default:
            break;
    }
    gradientLayer.endPoint = endPoint;
    
    gradientLayer.colors = @[(__bridge id)Hex_Str_COLOR(startColorHexString).CGColor, (__bridge id)Hex_Str_COLOR(endColorHexString).CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}

/** 渐变主色 结束 */
CG_INLINE UIColor * GradientColorWithColor(CGSize size ,FXGradientChangeDirection direction,UIColor *startColor,UIColor *endColor) {
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGPoint startPoint = CGPointZero;
    if (direction == FXGradientChangeDirectionDownDiagonalLine) {
        startPoint = CGPointMake(0.0, 1.0);
    }
    gradientLayer.startPoint = startPoint;
    
    CGPoint endPoint = CGPointZero;
    switch (direction) {
        case FXGradientChangeDirectionHorizontal:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        case FXGradientChangeDirectionVertical:
            endPoint = CGPointMake(0.0, 1.0);
            break;
        case FXGradientChangeDirectionUpwardDiagonalLine:
            endPoint = CGPointMake(1.0, 1.0);
            break;
        case FXGradientChangeDirectionDownDiagonalLine:
            endPoint = CGPointMake(1.0, 0.0);
            break;
        default:
            break;
    }
    gradientLayer.endPoint = endPoint;
    
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    UIGraphicsBeginImageContext(size);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}
/**
 * 默认头像
 */
CG_INLINE UIImage * kPlaceholderHeadImage() {
    return [UIImage imageNamed:@"test_user"];
}
/**
 * 默认banner
 */
CG_INLINE UIImage * kPlaceholderBannerImg() {
    return [UIImage imageNamed:@"广告位"];
}
/**
 * 默认商品图
 */
CG_INLINE UIImage * kPlaceholderGoodImg() {
    return [UIImage imageNamed:@"商品推荐占位图"];
}
/**
 * 默认房间头像
 */
CG_INLINE UIImage * kRoomPlaceholder() {
    return [UIImage imageNamed:@"none_room"];
}

/**
 * 默认礼物头像
 */
CG_INLINE UIImage * kGiftPlaceholder() {
    return [UIImage imageNamed:@"none_gift"];
}

/**
 * 默认无数据图
 */
CG_INLINE UIImage * kNoneDataImage() {
    return [UIImage imageNamed:@"default_none_list"];
}

/**
 * 互动消息无数据图
 */
CG_INLINE UIImage * kInterPlayNoneDataImage() {
    return [UIImage imageNamed:@"empty_notNewMessage"];
}

/**
 * 个人主页无数据图
 */
CG_INLINE UIImage * kUserHomePageNoneDataImage() {
    return [UIImage imageNamed:@"dynamic_emptyData"];
}

/**
 * 礼物墙无数据图
 */
CG_INLINE UIImage * kUserGiftWallNoneDataImage() {
    return [UIImage imageNamed:@"empty_notGift"];
}



/** 半屏高度 */
CG_INLINE CGFloat kHalf_ScreenH() {
    return kAppH()*3/5 + 40;
}
CG_INLINE CGFloat CalculateLabelHeight(CGFloat width, UIFont *font,NSString * text){
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    int height =  rect.size.height+1;//不转int值的话 会出现黑边
    return height;
}
CG_INLINE CGFloat CalculateLabelHeightWithLab(UILabel *lab){
    CGRect rect = [lab.text boundingRectWithSize:CGSizeMake(lab.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lab.font} context:nil];
    int height =  rect.size.height+1;//不转int值的话 会出现黑边
    return height;
}
CG_INLINE CGFloat CalculateLabelWidth(CGFloat height, UIFont *font,NSString * text){
    if ([text isKindOfClass:[NSString class]] && text.length!=0) {
       CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
        return floor(rect.size.width+1);//加取整，解决出现黑线问题
    }else{
        return 0;
    }
}
CG_INLINE NSString* todayFormartString(){
    NSDate *currentdate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSInteger sec = [zone secondsFromGMTForDate:currentdate];
    NSDate *new_date = [currentdate dateByAddingTimeInterval:sec];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [formatter stringFromDate:new_date];
    return time;
}

CG_INLINE NSString* JMGlobalWebCssString(NSString *bgColorHexString,NSInteger margin,NSInteger letterSpace,NSString *textColorHexString,NSInteger fontSize,NSString *htmlString){
    
    NSString *string = [NSString stringWithFormat:@"<meta name='viewport' id='viewport'\
                                                    content='width=device-width,height=device-height,\
                                                    target-densitydpi=high-dpi,initial-scale=1,minimum-scale=1,maximum-scale=1, user-scalable=no'>\
                                                    <style>body\
                                                    {background:%@;\
                                                    margin-left:%ldpx;\
                                                    margin-right:%ldpx;\
                                                    letter-spacing:%ldpx;\
                                                    color:%@;\
                                                    font:%ldpx \
                                                    Custom-Font-Name}\
                                                    </style>%@",bgColorHexString,margin,margin,letterSpace,textColorHexString,fontSize,htmlString];
    return string;
}
CG_INLINE NSString* JMGlobalWebDefaultCssString(NSString *htmlString){
    
    NSString *string = JMGlobalWebCssString(@"#191A1E", 16, 3, @"#ffffff", 19, htmlString);
    return string;
}

CG_INLINE NSURL* URLImageWithUrlStr(NSString * url){
    NSURL *rtn;
    if(url.length == 0){
        return rtn;
    }
    NSString *path = url;
    if(![url hasPrefix:@"http"]){
        path = [ImageBaseUrl stringByAppendingPathComponent:url];
    }
    NSString *urlStr = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    rtn = [NSURL URLWithString:urlStr];
    return rtn;
//    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImageBaseUrl,url]];
}
CG_INLINE NSString* LivePullUrlString(NSString * url){
    return [NSString stringWithFormat:@"webrtc://plays.chinagebao.com/live/%@",url];
}
CG_INLINE NSString* OSSImage(NSString* s,NSInteger w,NSInteger h) {
    return [NSString stringWithFormat:@"%@?x-oss-process=image/auto-orient,1/resize,m_lfit,w_%ld,h_%ld/quality,q_40",s,w,h];
}
CG_INLINE NSURL* URL_Guide_ImageWithUrlStr(NSString * url){//引导页压缩图片
    NSURL *rtn;
    if(url.length == 0){
        return rtn;
    }
    NSString *path = url;
    if(![url hasPrefix:@"http"]){
        path = [ImageBaseUrl stringByAppendingPathComponent:url];
    }
    NSString *urlStr = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    rtn = [NSURL URLWithString:OSSImage(urlStr, 810, 1440)];
    return rtn;
}
CG_INLINE NSURL* URL_GoodTop_ImageWithUrlStr(NSString * url){//轮播图压缩图片
    NSURL *rtn;
    if(url.length == 0){
        return rtn;
    }
    NSString *path = url;
    if(![url hasPrefix:@"http"]){
        path = [ImageBaseUrl stringByAppendingPathComponent:url];
    }
    NSString *urlStr = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    rtn = [NSURL URLWithString:OSSImage(urlStr, 1620, 1620)];
    return rtn;
}
CG_INLINE NSURL* URL_AD_ImageWithUrlStr(NSString * url){//轮播图压缩图片
    NSURL *rtn;
    if(url.length == 0){
        return rtn;
    }
    NSString *path = url;
    if(![url hasPrefix:@"http"]){
        path = [ImageBaseUrl stringByAppendingPathComponent:url];
    }
    NSString *urlStr = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    rtn = [NSURL URLWithString:OSSImage(urlStr, 750, 750)];
    return rtn;
}
CG_INLINE NSURL* URL_Icon_ImageWithUrlStr(NSString * url){//用户头像压缩图片
    NSURL *rtn;
    if(url.length == 0){
        return rtn;
    }
    NSString *path = url;
    if(![url hasPrefix:@"http"]){
        path = [ImageBaseUrl stringByAppendingPathComponent:url];
    }
    NSString *urlStr = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    rtn = [NSURL URLWithString:OSSImage(urlStr, 100, 100)];
    return rtn;
}
//
//CG_INLINE void delayOperation(CGFloat s,void(^block)(void))
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        [NSThread sleepForTimeInterval:s];
//        dispatch_async(dispatch_get_main_queue(), block);
//    });
//}
////拨打电话
//CG_INLINE void callNumber(NSString *number)
//{
//
//    if(![[[UIDevice currentDevice]model] isEqualToString:@"iPhone"])
//    {
//        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"错误"
//                                                      message:@"很抱歉,您的设备不支持电话业务"
//                                                     delegate:nil
//                                            cancelButtonTitle:@"确定"
//                                            otherButtonTitles:nil, nil];
//
//        [alert show];
//    }
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]]];
//}
#endif /* JMCommonMacro_h */
