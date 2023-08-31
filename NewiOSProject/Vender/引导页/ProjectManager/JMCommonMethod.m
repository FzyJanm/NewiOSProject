//
//  JMCommonMethod.m
//  JMBaseProject
//
//  Created by Liuny on 2018/8/23.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMCommonMethod.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreServices/CoreServices.h>

@implementation JMCommonMethod

+(NSMutableAttributedString *)navigationTitleWithColor:(UIColor *)color title:(NSString *)title{
    NSMutableAttributedString *rtn = [[NSMutableAttributedString alloc] initWithString:title];
    UIFont *font = [UIFont boldSystemFontOfSize:19.0];
    [rtn addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, title.length)];
    [rtn addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, title.length)];
    return rtn;
}
+(void)navigationItemSet:(UIButton *)item fontColor:(UIColor *)color{
    [item setTitleColor:color forState:UIControlStateNormal];
    item.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [item setTitleColor:color forState:UIControlStateNormal];
    UIColor *disableColor = [UIColor colorWithRGB:color.rgbValue alpha:0.2];
    [item setTitleColor:disableColor forState:UIControlStateDisabled];
}

+(NSMutableDictionary *)baseRequestParams{
    NSMutableDictionary *rtn = [[NSMutableDictionary alloc] init];
    NSString *sessionId = [JMProjectManager sharedJMProjectManager].loginUser.sessionId;
    [rtn setJsonValue:sessionId key:@"sessionId"];
    return rtn;
}

//网络请求图片
//网络请求图片
+(NSURL *)imageUrlWithPath:(NSString *)imagePath{
    NSURL *rtn;
    if(![imagePath isKindOfClass:[NSString class]])
    {
        return rtn;;
    }
    if(imagePath.length == 0){
        return rtn;
    }
    NSString *path = imagePath;
    if(![imagePath hasPrefix:@"http"]){
        path = [ImageBaseUrl stringByAppendingPathComponent:imagePath];
    }
    NSString *url = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    rtn = [NSURL URLWithString:url];
    return rtn;
}

+(NSString *)pinImagePath:(NSString *)path{
    NSString *rtn;
    if(path.length == 0){
        return @"";
    }
    if(![path hasPrefix:@"http"]){
        NSString *allPath = [ImageBaseUrl stringByAppendingString:path];
        rtn = [allPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }else{
        rtn = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    return rtn;
}

+(void)shadowView:(UIView *)view{
    //阴影
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 5);
    view.layer.shadowOpacity = 0.04;
    //    view.layer.shadowRadius = 5;
}

//UITextField占位文字颜色
+(void)placeholderColor:(UITextField *)textField{
    UIColor *color = [UIColor colorWithHexString:@"#4C4C50"];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:textField.placeholder attributes:
    @{NSForegroundColorAttributeName:color}];
    textField.attributedPlaceholder = attrString;
}

//html图片屏幕适配
+(NSString *)autoFitHtml:(NSString *)content{
    NSMutableString *headHtml = [[NSMutableString alloc] initWithCapacity:0];
    [headHtml appendString : @"<html>" ];
    
    [headHtml appendString : @"<head>" ];
    
    [headHtml appendString : @"<meta charset=\"utf-8\">" ];
    
    [headHtml appendString : @"<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\" />" ];
    
    [headHtml appendString : @"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />" ];
    
    [headHtml appendString : @"<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />" ];
    
    [headHtml appendString : @"<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />" ];
    
    //设置行间距和字体
    [headHtml appendString : @"<style>body{margin:0;background-color:transparent;font:16px;line-height: 25px;Custom-Font-Name}</style>"];
    
    //适配图片宽度，让图片宽度等于屏幕宽度
    //[headHtml appendString : @"<style>img{width:100%;}</style>" ];
    //[headHtml appendString : @"<style>img{height:auto;}</style>" ];
    
    //适配图片宽度，让图片宽度最大等于屏幕宽度
    //    [headHtml appendString : @"<style>img{max-width:100%;width:auto;height:auto;}</style>"];
    
    
    //适配图片宽度，如果图片宽度超过手机屏幕宽度，就让图片宽度等于手机屏幕宽度，高度自适应，如果图片宽度小于屏幕宽度，就显示图片大小
    [headHtml appendString : @"<script type='text/javascript'>"
     "window.onload = function(){\n"
     "var maxwidth=document.body.clientWidth;\n" //屏幕宽度
     "for(i=0;i <document.images.length;i++){\n"
     "var myimg = document.images[i];\n"
     "if(myimg.width > maxwidth){\n"
     "myimg.style.width = '100%';\n"
     "myimg.style.height = 'auto'\n;"
     "}\n"
     "}\n"
     "}\n"
     "</script>\n"];
    
    [headHtml appendString : @"<style>table{width:100%;}</style>" ];
    [headHtml appendString : @"<title>webview</title>" ];
    NSString *bodyHtml;
    bodyHtml = [NSString stringWithString:headHtml];
    bodyHtml = [bodyHtml stringByAppendingString:content];
    return bodyHtml;
//    return [NSString stringWithFormat:@"<html><head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><style>*{ width: 100%%; margin: 0; padding: 0 3; box-sizing: border-box;} img{ width: 100%%;}</style></head><body>%@</body></html>", self];
}


+(void)commitButtonStyle:(UIButton *)btn{
    if(btn){
        UIImage *normalImage = [UIImage imageWithColor:kColorMain];
        UIImage *disableImage = [UIImage imageWithColor:[UIColor colorWithHexString:@"#666666"]];
        [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
        [btn setBackgroundImage:disableImage forState:UIControlStateDisabled];
        btn.backgroundColor = nil;
    }
}


//阅读量显示规则
+(NSString *)readCountFormat:(NSString *)readCount{
    NSString *rtn;
    if(readCount.integerValue > 10000){
        rtn = [NSString stringWithFormat:@"%ldw",readCount.integerValue/10000];
    }else{
        rtn = readCount;
    }
    return rtn;
}

//发布时间显示规则
//+(NSString *)timeFormat:(NSString *)time{
//    NSDate *date = [NSDate dateWithString:time format:@"yyyy-MM-dd HH:mm:ss"];
//    return [date timeAgoSinceNow];
//}


+(UIImage *)coverImageForNetVideo:(NSURL *)url{
    AVURLAsset *urlAsset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:urlAsset];

    imageGenerator.appliesPreferredTrackTransform = YES;    // 截图的时候调整到正确的方向

    CMTime time = CMTimeMakeWithSeconds(0, 30);   // 1.0为截取视频1.0秒处的图片，30为每秒30帧

    CGImageRef cgImage = [imageGenerator copyCGImageAtTime:time actualTime:nil error:nil];

    UIImage *image11 = [UIImage imageWithCGImage:cgImage];
    return image11;
}
+(void)uploadImageWithImage:(UIImage *)image success:(returnBlock)success fail:(failBlock)fail{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    NSMutableDictionary *pictures = [[NSMutableDictionary alloc] init];
    NSArray * images = @[image];
    for(int i=0;i<images.count;i++){
        UIImage *image = images[i];
        pictures[UIImageJPEGRepresentation(image, 0.5)] = [NSString stringWithFormat:@"img%d_image.jpg",(i+1)];
    }
//    [[JMRequestManager sharedManager] requestUploadBasePost:kGlobal_UrlUploadImage params:params pictures:pictures success:success fail:fail];
    [[JMBaseRequest sharedInstance] requestUploadBasePost:BasePostRequestUrl(@"image/getImageAddress") params:params pictures:pictures success:^(NSDictionary * _Nullable dataDic, NSArray * _Nullable dataArray) {
        NSArray *urls =  dataDic;
        NSString *url = urls.firstObject;
        success(url);
    } fail:^(NSString * _Nonnull errorMsg) {
        
    }];

}
+(void)uploadImageWithImages:(NSArray<UIImage *>*)images success:(returnBlock)success fail:(failBlock)fail{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    NSMutableDictionary *pictures = [[NSMutableDictionary alloc] init];
    for(int i=0;i<images.count;i++){
        UIImage *image = images[i];
        pictures[UIImageJPEGRepresentation(image, 0.5)] = [NSString stringWithFormat:@"img%d_image.jpg",(i+1)];
    }
//    [[JMRequestManager sharedManager] requestUploadBasePost:kGlobal_UrlUploadImage params:params pictures:pictures success:success fail:fail];
    [[JMBaseRequest sharedInstance] requestUploadBasePost:BasePostRequestUrl(@"image/getImageAddress") params:params pictures:pictures success:^(NSDictionary * _Nullable dataDic, NSArray * _Nullable dataArray) {
        NSArray *urls =  dataDic;
        NSString *url = urls.firstObject;
        success(url);
    } fail:^(NSString * _Nonnull errorMsg) {
        
    }];

}



+(UIImage *)coverImageForLocalCache:(NSString *)url{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString* key = [manager cacheKeyForURL:[JMCommonMethod imageUrlWithPath:url]];
    SDImageCache* cache = [SDImageCache sharedImageCache];
    UIImage *cacheImg = [cache imageFromDiskCacheForKey:key];
    return cacheImg;
}


typedef enum:NSInteger{
    Environment_RemoteService,
    Environment_RemoteSafeService,
    Environment_RemoteService_IP,
    Environment_TestService,
    Environment_LocalService,
}Environment_Product;
NSString *serviceUrlWith(NSString *url){
    return [NSString stringWithFormat:@"%@/%@",serviceUrl(),url];
}
NSString* h5Url(NSString *ss){
    return serviceUrlWith([NSString stringWithFormat:@"h5?sessionId=%@&%@",JMProjectManager.sharedJMProjectManager.loginUser.sessionId,ss]);
}

NSString* serviceUrl(){
    
    Environment_Product environment = Environment_RemoteSafeService;
#if DEBUG
    if(JMProjectManager.sharedJMProjectManager.appConfig){
        Review_State local = JMProjectManager.sharedJMProjectManager.appConfig.localReviewStatus;
        Review_State service = JMProjectManager.sharedJMProjectManager.appConfig.serviceReviewStatus;
      
        if(local){
            //debug环境下 保存每次存储的正式或测试环境配置
            JMProjectManager.sharedJMProjectManager.appConfig.serviceReviewStatus = local;
        }
        ///可直接根据后台状态直接修改 特定环境下的服务器地址，也可以通过后台设置 iOSReviewState 来切换服务器地址
        if(JMProjectManager.sharedJMProjectManager.appConfig.serviceReviewStatus == Review_State_Rev_Apple){//苹果审核时服务器地址
            environment = Environment_RemoteSafeService;
        }
        if(JMProjectManager.sharedJMProjectManager.appConfig.serviceReviewStatus == Review_State_Test){//测试服务器地址
            environment = Environment_TestService;
        }
        if(JMProjectManager.sharedJMProjectManager.appConfig.serviceReviewStatus == Review_State_Dev){//开发环境服务器地址
            environment = Environment_RemoteSafeService;
        }
        if(JMProjectManager.sharedJMProjectManager.appConfig.serviceReviewStatus == Review_State_Dist){
            //生产环境（如果后台设置为生产环境，则无论版本号大小，无论线上 和 测试机组 均为生产环境地址）
            environment = Environment_RemoteService;
        }
        if(JMProjectManager.sharedJMProjectManager.appConfig.serviceReviewStatus == Review_State_Rev_User){
            environment = Environment_RemoteService;
        }
        
    }else{
        Environment_Product environment = Environment_RemoteService;
    }
#else
    environment = Environment_RemoteService;
#endif
          
//    environment = Environment_RemoteService;//如果不想通过后台控制打开即可
    NSString *urlStr = @"";
    switch (environment) {
        case Environment_RemoteService:
            urlStr = @"http://www.chinagebao.com";
            break;
        case Environment_RemoteSafeService:
            urlStr = @"http://www.chinagebao.com";
            break;
        case Environment_RemoteService_IP:
            urlStr = @"http://8.136.128.213";
            break;
        case Environment_TestService:
            urlStr = @"http://test.chinagebao.com";
            break;
        case Environment_LocalService:
            urlStr = @"http://192.168.0.114:8080";
            break;
        default:
            break;
    }
    NSLog(@"\n\n当前服务器地址%@\n\n",urlStr);
    return urlStr;
}

NSString* BasePostRequestUrl(NSString * url){
    return [NSString stringWithFormat:@"%@/%@/api/%@",serviceUrl(),@"gebao",url];
}

NSString* fPinUrl(NSString* url) {
    return [NSString stringWithFormat:@"%@/%@/%@",serviceUrl(),@"gebao",url];
}
NSString* bundleVersion() {
    NSString *bundleVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey];
    return bundleVersion;
}
NSString* loginUserHeadImgUrlString(){
    return [JMCommonMethod pinImagePath:JMProjectManager.sharedJMProjectManager.loginUser.headUrl];
}
NSURL* loginUserHeadImgURL(){
    return [NSURL URLWithString:[JMCommonMethod pinImagePath:JMProjectManager.sharedJMProjectManager.loginUser.headUrl]];
}


@end
