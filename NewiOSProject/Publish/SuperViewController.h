//
//  SuperViewController.h
//  MissAndFound
//
//  Created by apple on 14-12-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CellView.h"
#import "NSString+Helper.h"
#import "UIViewAdditions.h"
#import "Stockpile.h"
#import "AppDelegate.h"
#import "RDVTabBar.h"

//#import "IQKeyboardManager.h"
//#import "IQKeyboardReturnKeyHandler.h"
#import "MBProgressHUD+Add.h"
#import "UITextView+limitText.h"
#import "UIImageView+AFNetworking.h"
#import "CustomProgress.h"
#import "UIButton+AFNetworking.h"
//#import "UIView+MJExtension.h"


//#import "MJRefresh.h"
#import "LineView.h"
#import "UITextField+limitText.h"
#import "UIImage+Helper.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "CustomTextField.h"

//#import "WPHotspotLabel.h"
//#import "NSString+WPAttributedMarkup.h"
//#import "WPAttributedStyleAction.h"
//#import "LogInViewController.h"
#import "zhPopupController.h"
#import "CountDown.h"
#import "UIView+TYAlertView.h"
// if you want blur efffect contain this
#import "TYAlertController+BlurEffects.h"
//#import "MoreSDKDemo-Prefix.pch"
//
//#import "RCDChatViewController.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"




//如果是0，是取消，1是确定
typedef void(^AlertBlock)(NSInteger index);
typedef void(^TiShiKuangBlock)(NSInteger index);
typedef void(^AlertBlock1)(NSInteger index,UIAlertView *tf);
#pragma clang diagnostic pop
@interface SuperViewController : UIViewController
@property(nonatomic,assign)float scale;
@property(nonatomic,copy)void(^fanTime)(NSString *str);
@property(nonatomic,copy)void(^fanaddress)(NSString *str,NSDictionary *dic);
@property(nonatomic,copy)void(^fanzuzhi)(NSString *str,NSString *Id);
@property(nonatomic,strong)MBProgressHUD *HUD,*HUDString;

@property(nonatomic,strong)UIImageView *NavImg;
@property(nonatomic,strong)UILabel *TitleLabel;
@property(nonatomic,strong)UIActivityIndicatorView *activityVC;
@property(nonatomic,strong)UIImageView *Navline;
@property(nonatomic,strong)AppDelegate *appdelegate;
@property(nonatomic,strong)CustomProgress *custompro;
@property(nonatomic,strong)NSTimer *timerSuper;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UIButton *rightBarBtn;
//提示框block
@property(nonatomic,strong)AlertBlock alertBlock;
@property(nonatomic,strong)AlertBlock1 alertBlock1;
@property(nonatomic,strong)TiShiKuangBlock tiShiBlock;



/** 当前页 */
@property (nonatomic,assign)NSInteger index;

/** 数据 */
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableDictionary *dataDict;

@property(nonatomic,assign)BOOL reshEnd;


- (void)defaultNaviConfig;
- (void)setRightBarBtnWithImage:(NSString *)imgName Target:(id)target Action:(SEL)action;
- (void)setRightBarBtnWithTitle:(NSString *)title TitleColor:(UIColor *)color Target:(id)target Action:(SEL)action;

-(UIStatusBarStyle)preferredStatusBarStyle;
-(void)ShowAlertWithMessage:(NSString *)message;
-(void)ShowAlertTitle:(NSString *)title Message:(NSString *)message Delegate:(id)delegate Block:(AlertBlock)block;
-(void)setName:(NSString *)name;
-(NSMutableAttributedString *)stringColorAllString:(NSString *)string redString:(NSString *)redString;
-(float)Text:(NSString *)text Size:(CGSize)size Font:(CGFloat)fone;
-(NSDictionary *)Style;
-(NSMutableAttributedString *)stringColorAllString:(NSString *)string YelloyString:(NSString *)redString;
-(NSString *)getToday;
-(UIImage *) scaleImage: (UIImage *)image scaleFactor:(float)scaleBy;
//-(void)makePhoneWithTel:(NSString *)string;
-(NSMutableAttributedString*)stringColorAllString:(NSString *)string orgin:(NSString *)orgin;
//-(void)roundProgressInitWithFrame:(CGRect)rect maxValue:(CGFloat)value;
/**
 *set字符串如果没有特殊要求请填nil
 */
-(void)startAnimating:(NSString *)set;
-(void)stopAnimating;
-(float)textWithView:(UILabel *)lable withWidth:(float)width;
-(NSMutableAttributedString*)stringColorAllString:(NSString *)string gradColor:(NSString *)orgin;
-(void)startAnimatingWithString:(NSString *)set;

- (NSString *)timerFireMethod:(NSString*)theTimer;
-(void)longProgressInitWithFrame:(CGRect)rect backgroundColor:(UIColor *)bgColor leftColor:(UIColor *)ltColor maxValue:(float)value;

-(UILabel *)getColorLabel:(UILabel *)label stringAndColor:(NSDictionary *)dict;
-(NSString *)timeCToStringWithmmss:(double)tim;
/**
 *判断图片data格式
 */
- (NSString *)typeForImageData:(NSData *)data;
-(void)ShowAlertTitleWithText:(NSString *)title Message:(NSString *)message Delegate:(id)delegate Block:(AlertBlock1)block;
/**
 *token过期之后需要重新登录
 */
-(BOOL)loginWithOldTokenWithBlock:(void(^)(BOOL code))block;

/**
 *时间规范
 */
-(NSString *)timeWithString:(NSString *)string;

/**
 *时间戳改字符串
 */
-(NSString *)timeCToString:(double)tim;

/**
 *date改字符串
 */
-(NSString *)timeWithDate:(NSDate *)date;

-(UIView *)kongbaiYeWithImgName:(NSString *)imgName text:(NSString *)text inView:(UIView *)view;

-(NSString *)getOrderNum;
-(NSString *)numofQ:(NSString *)string;


-(CGFloat)countCellWithStr:(NSString *)str Font:(UIFont *)font width:(CGFloat)width;

/** 设置placeholder 富文本属性 */
- (NSMutableAttributedString *)setPlaceBoldFontWithNSString:(NSString *)string andLength:(NSInteger )len;

/** 图片url(网络)--> 转字符串 */
- (NSString *)getImgStrWithImgUrlStr:(NSString *)imgUrlStr quality:(CGFloat)compressionQuality;

/** 图片url(本地)--> 转字符串 */
//- (NSString *)getImgStrWithLocalImgUrlStr:(NSString *)localPath quality:(CGFloat)compressionQuality;

//  MARK: - 新增
//给UILabel设置行间距和字间距
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font;

/**
 *  提示框
 */
-(void)showTiShiKuang:(NSString *)title msg:(NSString *)msg type:(TYAlertTransitionAnimation)type;
/**
 *  提示框
 *
 *  @param title 标题
 *  @param msg   内容
 *  @param block TiShiKuangBlock
 */
-(void)showTiShiKuang:(NSString *)title msg:(NSString *)msg block:(TiShiKuangBlock)block;
/**
 *  模糊弹出自定义提示框
 *
 *  @param View UIView
 */
-(void)showMoHuZiDingYiView:(UIView *)View;
/**
 *  弹出自定义提示框
 *
 *  @param View UIView
 *  @param tap  tap 点击View附近是否隐藏View
 */
-(void)showZiDingYiView:(UIView *)View isTap:(BOOL)tap;

#pragma mark - zhPopupController视图

/**
 从顶部有弧度的下降
 
 @param Drop 弧度
 @param View 视图
 @param duration 动画时间
 @param Animated 是否动画
 */
-(void)showZhPopupDropWithDrop:(NSInteger)Drop View:(UIView *)View Duration:(NSTimeInterval)duration Animated:(BOOL)Animated;

/**
 可以设置弹出多少秒后消失
 
 @param MaskType 0:模糊黑 1:模糊白 2:不透明白 3:全透明白 4:透明黑
 @param slideStyle 0:上 1：下 2：左 3：右 4：中间 5：渐变
 @param allowPan 是否允许拖动
 @param View 视图
 @param duration 动画时间
 @param Animated 是否动画
 @param displayTime 多少秒后消失
 */
-(void)showZhPopupDisplayWithMaskType:(zhPopupMaskType)MaskType slideStyle:(NSInteger)slideStyle allowPan:(BOOL)allowPan View:(UIView *)View Duration:(NSTimeInterval)duration Animated:(BOOL)Animated displayTime:(NSTimeInterval)displayTime;

/**
 火箭，--》
 @param slideStyle 0:上 1：下 2：左 3：右 4：中间 5：渐变 （默认：1）
 @param Touched 点击背景是否让视图消失
 @param Direction YES:从上消失 NO:从下消失
 @param View 视图
 @param duration 动画时间
 @param Animated 是否动画
 */
-(void)showZhPopupHuoJianWithMaskSlideStyle:(NSInteger)slideStyle Touched:(BOOL)Touched Direction:(BOOL)Direction  View:(UIView *)View Duration:(NSTimeInterval)duration Animated:(BOOL)Animated;

/**
 展示视图
 
 @param layoutType 弹出方向 0:上 1：下 2：左 3：右 4：中间
 @param allowPan 是否允许拖动
 @param View 视图
 @param duration 动画时间
 @param Animated 是否动画
 */
-(void)showZhPopupPushWithlayoutType:(zhPopupLayoutType)layoutType allowPan:(BOOL)allowPan   View:(UIView *)View Duration:(NSTimeInterval)duration Animated:(BOOL)Animated;

-(UIView*)createCellLineSetX:(CGFloat)setX  SetY:(CGFloat)setY setWidth:(CGFloat)width setHeight:(CGFloat)height;
-(UIView*)createCellLineSet:(CGFloat)setX  SeY:(CGFloat)setY;
//-(YYLabel*)createLabel;
extern UIView * createBottomLine(CGFloat Insert,UIView *superView);
- (BOOL)isContainsTwoEmoji:(NSString *)string;
- (NSString *)convertToJsonData:(NSMutableArray *)dictArr;

@end
