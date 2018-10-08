//
//  PagerDetial.m
//  ZhongHang
//
//  Created by 范智渊 on 2018/7/18.
//  Copyright © 2018年 范智渊. All rights reserved.
//

#import "PagerDetial.h"
#import <WebKit/WebKit.h>
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>

#import "UIActivityIndicatorView+AFNetworking.h"
#import "SDWebView.h"


#import "filterHTML.h"

@interface PagerDetial ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong)UIImageView *ImgView;
@property (nonatomic, strong)NSString *htmlStr;
@property (nonatomic, strong)SDWebView *webView;


@end

@implementation PagerDetial
-(void)viewWillAppear:(BOOL)animated {
    if (self.rdv_tabBarController.tabBarHidden == NO) {
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];;
    }
}
- (void)viewDidLoad {
     [super viewDidLoad];
    [self defaultNaviConfig];
    self.view.backgroundColor = [UIColor whiteColor];
    self.TitleLabel.text =self.TitleStr;
    if ([self.action isEqualToString:@"newsDetail"] ) {
        
        [self.rightBarBtn addTarget:self action:@selector(share) forControlEvents:(UIControlEventTouchUpInside)];
        [self.rightBarBtn setImage:ImageNamed(@"fenxiang1") forState:(UIControlStateNormal)];
    }
    if ([self.action isEqualToString:@"g_news_detail"] ) {
        self.IDType = @"nid";
    }

    [self.backBtn setImage:ImageNamed(@"fanhui1") forState:(UIControlStateNormal)];
    self.webView = [[SDWebView alloc] initWithFrame:CGRectMake(0, NAVGATIONBRHEIGHT, APPW,APPH-NAVGATIONBRHEIGHT)];
    self.webView.webDelegate = self;
    
    NSDictionary *dic = @{@"action":self.action,self.IDType:self.adID};
    [self startAnimating:nil];
    [kHttpRequest LinkServiceWithUrl:nil ForIsToken:nil ForParameters:dic Block:^(id models, NSString *code, NSString *msg) {
        [self stopAnimating];
        
        if( CODE(code)) {
           
            NSString *str = @"";
            NSString *titleCon = @"<meta name='viewport'content='width=device-width, initial-scale=1, maximum-scale=.9,user-scalable=no;'/>";
            NSString *HTMLString=@"";

            if (self.contentTitle && models[@"time"]) {
                titleCon = @"<meta name='viewport'content='width=device-width, initial-scale=1, maximum-scale=.9,user-scalable=no;'/>\
                <b><h3>%@</h3></b>\
                <b><font size='2' color='#333333'>%@<br></br></font></b>\
                ";
                str = [NSString stringWithFormat:titleCon,self.contentTitle,models[@"time"]];
                HTMLString = [str stringByAppendingString:models[@"content"]];

            }else
            {
                HTMLString = [titleCon stringByAppendingString:models[@"content"]];

            }

            [self.webView loadHTMLString:HTMLString baseURL:nil];
        }else {
            [MBProgressHUD showError:msg toView:self.view];
        }
        [self.view addSubview:self.webView];
    }];
}


#pragma mark - 友盟分享
//- (void)share {
//    //显示分享面板
//    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite),@(UMSocialPlatformType_Qzone)]];
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        [self shareWebPageToPlatformType:platformType];
//    }];
//
//}
//- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
//{
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//
//    //创建网页内容对象
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.dataDict[@"shar_title"] descr:self.dataDict[@"shar_content"] thumImage:nil];
//    //设置网页地址
//    //    shareObject.webpageUrl =[ NSString stringWithFormat:@"%@%@",YUMING,self.dataDict[@"shar_link"]];
//    //分享消息对象设置分享内容对象
//    shareObject.webpageUrl =self.dataDict[@"shar_link"];
//    messageObject.shareObject = shareObject;
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
//
//        if (error) {
//            NSLog(@"************Share fail with error %@*********",error);
//        }else{
//            NSLog(@"response data is %@",data);
//            [MBProgressHUD showSuccess:@"分享成功\nSharing success" toView:self.view];
//        }
//    }];
//
//}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSString *js = @"function imgAutoFit(){\
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    
    js = [NSString stringWithFormat:js,[UIScreen mainScreen].bounds.size.width*.95];
    [webView evaluateJavaScript:js completionHandler:nil];
    [webView evaluateJavaScript:@"imgAutoFit()" completionHandler:nil];
    
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
