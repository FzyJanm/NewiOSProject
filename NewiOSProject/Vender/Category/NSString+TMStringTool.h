//
//  NSString+TMStringTool.h
//  TamuVoice
//
//  Created by apple on 2021/8/24.
//

#import <Foundation/Foundation.h>
#import "YYText.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSString (TMStringTool)
- (NSMutableAttributedString *)getHtmlStringWithString:(NSString *)string ;
-(BOOL)containHtmlString;
- (NSString *)MD5String;

/** 计算字符串size */
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;


/**
 Returns YES if the target string is contained within the receiver.
 @param string A string to test the the receiver.
 
 @discussion Apple has implemented this method in iOS8.
 */
- (BOOL)containsString:(NSString *)string;


/**
 保护用户隐私，字符串部分为*号代替

 @param rang 需要变*的rang
 @return 改变后的字符串
 */
- (NSString *)replaceStringStarWithRang:(NSRange)rang;

/** 是否是密码 */
- (BOOL)isPassWord;

/** 是否是手机号 */
- (BOOL)isPhoneMobile;

/** 是否包含中文 */
- (BOOL)isHasChinese;

/** 判断是否是url */
- (BOOL)CheckStringIsUrl;

/** 是否是验证码 */
- (BOOL)isAuthCode;

/** json字符串转字典 */
- (NSDictionary *)jsonStringToDictionary;

/** 显示富文本 */
- (NSAttributedString *)showAttributedWithWidth:(float)width;

/** 判断是否是纯数字 */
- (BOOL)judgeIsNumberByRegularExpression;



/**
 判断字符串是否为空
 */
- (BOOL)stringIsEmpty;
///是否是空格
-(BOOL)stringIsSpace;

///unicode转换
- (NSString*)stringResolveReplaceUnicode;
#pragma mark ==================    /** 大数字转字符串，显示K，W，KW */    ==================
- (NSString *)bigCountToStringWithtype:(int)type;
- (CGSize)singleLineSizeWithText:(UIFont *)font;
- (CGSize)singleLineSizeWithAttributeText:(UIFont *)font;
@end


@interface NSAttributedString (ADAttributedStringTool)

/// Label后展示“全文”按钮-ios
/// @param label label
/// @param more 按钮文字
/// @param morecolor 按钮文字颜色
/// @param before 更多按钮前显示
/// @param tapAction 点击事件
- (NSAttributedString*)addSeeMoreButton:(YYLabel*)label  more:(NSString*)more moreColor:(UIColor*)morecolor before:(NSString*)before tapAction:(void(^)(UIView*containerView,NSAttributedString*text,NSRange range,CGRect rect))tapAction;

/// Label后展示“收起”按钮-ios
/// @param label label
/// @param packUp 收起按钮文字
/// @param packUpcolor  按钮文字颜色
/// @param tapAction 点击事件
- (NSAttributedString *)addPackUpButton:(YYLabel*)label andPackUpString:(NSString *)packUp andpackUpColor:(UIColor*)packUpcolor tapAction:(void(^)(UIView *containerView,NSAttributedString *text,NSRange range,CGRect rect))tapAction;

/** 计算富文本图文混排高度 */
- (CGSize)sizeWithLabelWidth:(CGFloat)width;

/** 计算富文本图文混排宽度 */
- (CGSize)sizeWithLabelHeight:(CGFloat)height;

/** YYLabel 计算富文本宽高 */
- (CGSize)sizeWithYYlabelSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
