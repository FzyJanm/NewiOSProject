//
//  JMCommonMethod.h
//  JMBaseProject
//
//  Created by Liuny on 2018/8/23.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^returnBlock)(NSString *imageUrl);
typedef void(^returnBlocks)(NSArray *imageUrls);
typedef void(^failBlock)(NSString *errorMsg);

@interface JMCommonMethod : NSObject

extern NSString* BasePostRequestUrl(NSString * url);
extern NSString* fPinUrl(NSString* url);
extern NSString* h5Url(NSString* ss);
extern NSString* bundleVersion();
extern NSString* serviceUrlWith(NSString *url);
extern NSString* serviceUrl();
extern NSString* loginUserHeadImgUrlString();
extern NSURL* loginUserHeadImgURL();

//导航栏标题文字属性
+(NSMutableAttributedString *)navigationTitleWithColor:(UIColor *)color title:(NSString *)title;
//导航栏左右按钮文字属性
+(void)navigationItemSet:(UIButton *)item fontColor:(UIColor *)color;
//接口请求基础数据
+(NSMutableDictionary *)baseRequestParams;
//网络请求图片
+(NSURL *)imageUrlWithPath:(NSString *)imagePath;
//图片完整地址
+(NSString *)pinImagePath:(NSString *)path;
//阴影
+(void)shadowView:(UIView *)view;
//UITextField占位文字颜色
+(void)placeholderColor:(UITextField *)textField;
//html图片屏幕适配
+(NSString *)autoFitHtml:(NSString *)content;
//提交按钮
+(void)commitButtonStyle:(UIButton *)btn;
//阅读量显示规则
+(NSString *)readCountFormat:(NSString *)readCount;
//发布时间显示规则
+(NSString *)timeFormat:(NSString *)time;
//获取视频封面
+(UIImage *)coverImageForNetVideo:(NSURL *)url;
//获取本地缓存图片
+(UIImage *)coverImageForLocalCache:(NSString *)url;
//上传图片
+(void)uploadImageWithImage:(UIImage *)image success:(returnBlock)success fail:(failBlock)fail;
//上传多张图片
+(void)uploadImageWithImages:(NSArray<UIImage *> *)images success:(returnBlocks)success fail:(failBlock)fail;
//直播默认消息默认携带参数
+(NSMutableDictionary *)defaultExtraDict;

@end
NS_ASSUME_NONNULL_END
