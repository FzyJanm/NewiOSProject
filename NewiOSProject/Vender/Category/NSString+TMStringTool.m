//
//  NSString+TMStringTool.m
//  TamuVoice
//
//  Created by apple on 2021/8/24.
//

#import "NSString+TMStringTool.h"
#include <CommonCrypto/CommonCrypto.h>

@implementation NSString (TMStringTool)
- (NSMutableAttributedString *)getHtmlStringWithString:(NSString *)string {
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute : @(NSUTF8StringEncoding)};
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    // 设置段落格式
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 8;
    [attStr addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, attStr.length)];
    // 设置文本的Font
    [attStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:NSForegroundColorAttributeName value:WhiteColor() range:NSMakeRange(0, attStr.length)];
    return attStr;
}
-(BOOL)containHtmlString{
    return [self containsString:@"font"] || [self containsString:@"</p>"];
}
- (NSString *)MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (BOOL)containsString:(NSString *)string {
    if (string == nil) return NO;
    return [self rangeOfString:string].location != NSNotFound;
}

- (NSString *)replaceStringStarWithRang:(NSRange)rang {
    if (self.length >= rang.location + rang.length) {
        NSString *rangStr = [self substringWithRange:rang];
        NSString *tempStr = @"";
        for (int i  = 0; i < rang.length; i++) {
            tempStr = [tempStr stringByAppendingString:@"*"];
        }
        NSString *str = [self stringByReplacingOccurrencesOfString:rangStr withString:tempStr];
        return str;
    }
    return @"";
}


- (BOOL)isPassWord {
    //字母数字
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}";
    
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    if (isMatch) {
        return YES ;
    } else
        return NO;
}

- (BOOL)isPhoneMobile {
    NSString * mobile = self;
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11) {
        return NO;
    }
    
    if (![mobile hasPrefix:@"1"]) {
        return NO;
    }
    
    return YES;
}

/** 是否包含中文 */
- (BOOL)isHasChinese {
    if ([self rangeOfString:@"[\\u4e00-\\u9fa5]" options:NSRegularExpressionSearch].location != NSNotFound ){
        return YES;
    }
    return NO;
}

/** 判断是否是url */
- (BOOL)CheckStringIsUrl {
    
    if(self == nil) {
        return NO;
    }
    NSString *url;
    if (self.length>4 && [[self substringToIndex:4] isEqualToString:@"www."]) {
        url = [NSString stringWithFormat:@"http://%@",self];
    } else {
        url = self;
    }
    NSString *urlRegex = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSPredicate* urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    return [urlTest evaluateWithObject:url];
}

/** 是否是验证码 */
- (BOOL)isAuthCode {
    NSString * authCode = self;
    authCode = [authCode stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (authCode.length!=6) {
        return NO;
    }
    NSString * regex  = @"[0-9]*";
    NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch   = [pred evaluateWithObject:authCode];
    if (isMatch) {
        return YES;
    }
    return NO;
}

/** json字符串转字典 */
- (NSDictionary *)jsonStringToDictionary {
    if (self == nil || ![self isKindOfClass:NSString.class]) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//显示富文本
- (NSAttributedString *)showAttributedWithWidth:(float)width {
//替换图片的高度为屏幕的高度
    NSString *newString = [self stringByReplacingOccurrencesOfString:@"<img" withString:[NSString stringWithFormat:@"<img width=\"%f\"",width]];
    
    NSAttributedString *attributeString=[[NSAttributedString alloc] initWithData:[newString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    return attributeString;
}

/** 判断是否是纯数字 */
- (BOOL)judgeIsNumberByRegularExpression {
    if (self.length == 0) {
    return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}


/**
 判断字符串是否为空
 */
- (BOOL)stringIsEmpty{
    if ([self isKindOfClass:NSNull.class] || self == nil) {
        return YES;
    }else{
        if ([self isEqualToString:@""] || [self isEqualToString:@"(null)"] || [self isEqualToString:@"<null>"]) {
            return YES;
        }
    }
    return NO;
}
///是否是空格
-(BOOL)stringIsSpace{
    if (!self) {
           return true;
       } else {
           NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
           NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
           if ([trimedString length] == 0) {
               return true;
           } else {
               return false;
           }
       }
}
///unicode转换
- (NSString*)stringResolveReplaceUnicode{
    NSMutableString*convertedString = [self mutableCopy];
        [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform =CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString,NULL, transform,YES);
    return convertedString;
}
#pragma mark ==================    /** 大数字转字符串，显示K，W，KW */    ==================
//type 1 正常计算  2，大于10万计算
- (NSString *)bigCountToStringWithtype:(int)type {
    NSInteger count = self.integerValue;
    //超过的位数都舍弃 NSRoundDown
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                       scale:1
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    //除数
    NSDecimalNumber *tempNumber = [[NSDecimalNumber alloc] initWithInteger:count];
    //被除数
    NSDecimalNumber *dividend;
    //结果
    NSDecimalNumber *result;
    
    if (type == 1) {
        if (count < 1000) {
            return [NSString stringWithFormat:@"%ld",count];
        }
        if (count >= 1000 && count < 10000) {
            dividend = [NSDecimalNumber decimalNumberWithString:@"1000"];
            result = [tempNumber decimalNumberByDividingBy:dividend withBehavior:roundUp];
            return [NSString stringWithFormat:@"%.1fk",[[NSString stringWithFormat:@"%@",result] floatValue]];
        }
    } else if (type == 2) {
        if (count < 10000) {
            return [NSString stringWithFormat:@"%ld",count];
        }
    }
    
    if (count >= 10000 && count < 10000000) {
        dividend = [NSDecimalNumber decimalNumberWithString:@"10000"];
        result = [tempNumber decimalNumberByDividingBy:dividend withBehavior:roundUp];
        return [NSString stringWithFormat:@"%.1fw",[[NSString stringWithFormat:@"%@",result] floatValue]];
    }
    
    if (count >= 10000000 && count < 10000000000) {
        dividend = [NSDecimalNumber decimalNumberWithString:@"10000000"];
        result = [tempNumber decimalNumberByDividingBy:dividend withBehavior:roundUp];
        return [NSString stringWithFormat:@"%.1fKW",[[NSString stringWithFormat:@"%@",result] floatValue]];
    }
    
    return @"99KW+";
}
- (CGSize)singleLineSizeWithText:(UIFont *)font{
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}
- (CGSize)singleLineSizeWithAttributeText:(UIFont *)font {
    CTFontRef cfFont = CTFontCreateWithName((CFStringRef) font.fontName, font.pointSize, NULL);
    CGFloat leading = font.lineHeight - font.ascender + font.descender;
    CTParagraphStyleSetting paragraphSettings[1] = { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof (CGFloat), &leading };
    
    CTParagraphStyleRef  paragraphStyle = CTParagraphStyleCreate(paragraphSettings, 1);
    CFRange textRange = CFRangeMake(0, self.length);
    
    CFMutableAttributedStringRef string = CFAttributedStringCreateMutable(kCFAllocatorDefault, self.length);
    
    CFAttributedStringReplaceString(string, CFRangeMake(0, 0), (CFStringRef) self);
    
    CFAttributedStringSetAttribute(string, textRange, kCTFontAttributeName, cfFont);
    CFAttributedStringSetAttribute(string, textRange, kCTParagraphStyleAttributeName, paragraphStyle);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(string);
    CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, CGSizeMake(DBL_MAX, DBL_MAX), nil);
    
    CFRelease(paragraphStyle);
    CFRelease(string);
    CFRelease(cfFont);
    CFRelease(framesetter);
    return size;
}
@end

@implementation NSAttributedString (ADAttributedStringTool)

- (NSAttributedString*)addSeeMoreButton:(YYLabel*)label  more:(NSString*)more moreColor:(UIColor*)morecolor before:(NSString*)before tapAction:(void(^)(UIView *containerView,NSAttributedString *text,NSRange range,CGRect rect))tapAction{

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",before? before:@"",more ? more :@""]];
    if(tapAction) {
        YYTextHighlight *hi = [YYTextHighlight new];
        [hi setColor:self.yy_color?self.yy_color:label.textColor];
        hi.tapAction = tapAction;
        [text yy_setTextHighlight:hi range:[text.string rangeOfString:more]];
    }
    [text yy_setColor: morecolor ? morecolor: [UIColor colorWithRed:0.000 green:0.449 blue:1.000 alpha:1.000]range:[text.string rangeOfString:more]];
    text.yy_font =self.yy_font ? self.yy_font :label.font;
    YYLabel*seeMore = [[YYLabel alloc]init];
    seeMore.attributedText= text;
    [seeMore sizeToFit];
    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.frame.size alignToFont:text.yy_font alignment:YYTextVerticalAlignmentCenter];
    label.truncationToken= truncationToken;
    return truncationToken;
}

- (NSAttributedString *)addPackUpButton:(YYLabel*)label andPackUpString:(NSString *)packUp andpackUpColor:(UIColor*)packUpcolor tapAction:(void(^)(UIView *containerView,NSAttributedString *text,NSRange range,CGRect rect))tapAction{
    
    NSMutableAttributedString *append = [[NSMutableAttributedString alloc] initWithString:packUp attributes:@{NSFontAttributeName : label.font, NSForegroundColorAttributeName : packUpcolor}];
    
    YYTextHighlight *hi = [YYTextHighlight new];
    [append yy_setTextHighlight:hi range:[append.string rangeOfString:packUp]];
    
    hi.tapAction = tapAction;
    
    return append;
}
 


- (CGSize)sizeWithLabelWidth:(CGFloat)width {
    if(width<=0) {
        return CGSizeZero;
    }
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, CGFLOAT_MAX)];
    lab.attributedText = self;
    lab.numberOfLines = 0;
    [lab sizeToFit];
    CGSize labSize = [lab sizeThatFits:lab.bounds.size];
    return labSize;
}

- (CGSize)sizeWithLabelHeight:(CGFloat)height {
    if(height<=0) {
        return CGSizeZero;
    }
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MAX, height)];
    lab.attributedText = self;
    lab.numberOfLines = 0;
    [lab sizeToFit];
    CGSize labSize = [lab sizeThatFits:lab.bounds.size];
    return labSize;
}

#pragma mark - YYLabel 计算富文本宽高
/** YYLabel 计算富文本宽高 */
- (CGSize)sizeWithYYlabelSize:(CGSize)size {
    YYTextContainer *container = [YYTextContainer new];
    container.size = size;
    container.maximumNumberOfRows = 0;
    YYTextLayout *layout =  [YYTextLayout layoutWithContainer:container text:self];
    return layout.textBoundingSize;
}

@end
