//
//  SuperViewController.m
//  MissAndFound
//
//  Created by apple on 14-12-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "SuperViewController.h"
//#import "LogInViewController.h"
#import "FZYLoginVC.h"


@interface SuperViewController ()<UIAlertViewDelegate,UITextViewDelegate,RDVTabBarControllerDelegate>

@property(nonatomic,strong)UIControl *big;
@property(nonatomic,strong)UIDatePicker *TimePickerView;
@property(nonatomic,strong)UIPickerView *pickView;
@property(nonatomic,strong)NSMutableArray *timeArr,*shiArr,*quArr;
@property(nonatomic,strong)UIImageView *SelectImg;
@property(nonatomic,strong)NSArray *addressArr;
@property(nonatomic,assign)BOOL isround;
@property(nonatomic,assign)int present;


@end
@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataDict = [NSMutableDictionary new];
    self.dataArray = [NSMutableArray new];
    self.index = 1;
    _appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    _scale=1.0;
    if ([[UIScreen mainScreen] bounds].size.height > 480)
    {
        if (StatusBar_Height() > 20)
        {
            _scale= 667.0/568.0;
        }
        else
        {
            _scale = [[UIScreen mainScreen] bounds].size.height / 568.0;
        }
        
    }
//    [self preferredStatusBarStyle];
//    [IQKeyboardManager sharedManager].enable=YES;
//    [IQKeyboardManager sharedManager].enableAutoToolbar=NO;
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    self.fd_prefersNavigationBarHidden=YES;
   self.navigationController.navigationBarHidden=YES;
    
    self.view.backgroundColor = Hex_Str_COLOR(@"#F7F7F5");

   
    self.NavImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,self.view.width,NAVIGATION_BAR_HEIGHT())];
    self.NavImg.backgroundColor=[UIColor whiteColor];
    self.NavImg.userInteractionEnabled = YES;
    self.NavImg.clipsToBounds = YES;
    [self.view  addSubview:self.NavImg];
    
    _Navline = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.NavImg.bottom-.5, self.view.width, .5)];
    _Navline.backgroundColor=kSeparatorColor;
//    [self.NavImg addSubview:_Navline];
//    Descripcion de las cuotas :Cuota utilizada = pedido de prestamo exitosoCuota congelada = pedido en proceso derevision y deposito
//    Cuota disponible = cuota disponible de pedirprestamo
    
    self.TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45*self.scale,rStatusBarHeight, self.view.width-90*self.scale, 44)];
    self.TitleLabel.textColor = kTextColor;
//    self.TitleLabel.alpha=.7;
    self.TitleLabel.textAlignment = 1;
    self.TitleLabel.font = [UIFont fontWithName:@"Helvetica" size:15*_scale];
    self.TitleLabel.backgroundColor = [UIColor clearColor];
    [self.NavImg addSubview:self.TitleLabel];
    
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.TitleLabel.top, self.TitleLabel.height, self.TitleLabel.height)];
    [_backBtn addTarget:self action:@selector(PopVC:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.NavImg addSubview:_backBtn];
    
    
    _rightBarBtn = [[UIButton alloc]initWithFrame:(CGRectMake(APPW-60,_backBtn.top, self.TitleLabel.height, self.TitleLabel.height))];
    [self.NavImg addSubview:_rightBarBtn];
    
    
//    _activityVC=[[UIActivityIndicatorView alloc]init];
//    _activityVC.frame=CGRectMake(0, 0, self.view.width, self.view.height);
//    _activityVC.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
//    _activityVC.color=[UIColor blackColor];
    
}
//  MARK: -  ————导航条————
- (void)defaultNaviConfig {
    [self.backBtn setImage:ImageNamed(@"fanhui") forState:(UIControlStateNormal)];
}
- (void)setRightBarBtnWithImage:(NSString *)imgName Target:(id)target Action:(SEL)action {
    [self.rightBarBtn setImage:ImageNamed(imgName) forState:(UIControlStateNormal)];
    [self.rightBarBtn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)setRightBarBtnWithTitle:(NSString *)title TitleColor:(UIColor *)color Target:(id)target Action:(SEL)action {
    [self.rightBarBtn setTitle:title forState:(UIControlStateNormal)];
    [self.rightBarBtn setTitleColor:color forState:(UIControlStateNormal)];
    [self.rightBarBtn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)PopVC:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex == 3) {
        if (![Stockpile sharedStockpile].isLogin) {
//            LoginVC *loVC = [LoginVC new];
//            [self presentViewController:loVC animated:YES completion:nil];
        }
    }
    return YES;
}

- (NSMutableAttributedString *)setPlaceBoldFontWithNSString:(NSString *)string andLength:(NSInteger )len{
    //修改具体每个字的设置
    NSMutableAttributedString *placehoder = [[NSMutableAttributedString alloc] initWithString:string];
    [placehoder setAttributes:@{NSForegroundColorAttributeName : kTextColorThree} range:NSMakeRange(0, len)];
    [placehoder setAttributes:@{
                                NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:14*self.scale]
                                } range:NSMakeRange(0, len)];
    return placehoder;
}

-(void)longProgressInitWithFrame:(CGRect)rect backgroundColor:(UIColor *)bgColor leftColor:(UIColor *)ltColor maxValue:(float)value{
    _custompro = [[CustomProgress alloc] initWithFrame:rect];
    _custompro.maxValue = value;
    _custompro.bgimg.backgroundColor =bgColor;
    _custompro.leftimg.backgroundColor =ltColor;
    [self performSelectorInBackground:@selector(multiThread) withObject:nil];
}

- (void)multiThread
{
    if (![NSThread isMainThread]) {
        
        _timerSuper = [NSTimer timerWithTimeInterval:.005f target:self selector:@selector(timerGo) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timerSuper forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }
}


-(void)timerGo{
    _present++;
    if (_present<=_custompro.maxValue) {
        [_custompro setPresent:_present];
        
    }else
    {
        [_timerSuper invalidate];
        _timerSuper = nil;
        _present = 0;
    }
}

- (NSString *)timerFireMethod:(NSString*)theTimer{
    
    NSDateFormatter *f1 = [[NSDateFormatter alloc] init];
    [f1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[theTimer doubleValue]];
    NSString *confromTimespStr = [f1 stringFromDate:confromTimesp];
    return confromTimespStr;
}

-(UIView *)kongbaiYeWithImgName:(NSString *)imgName text:(NSString *)text inView:(UIView *)view{
    
    UIView *bgVi = [[UIView alloc]initWithFrame:CGRectMake(0, self.NavImg.bottom, view.width, view.height-self.NavImg.bottom)];
    bgVi.backgroundColor=[UIColor clearColor];
    bgVi.userInteractionEnabled=YES;
    
    
    UIImageView *im = [[UIImageView alloc]init];
    //    im.frame=CGRectMake(0, 30*self.scale, 0, 0);
    im.userInteractionEnabled=YES;
    im.width=80*self.scale;
    im.height=80*self.scale;
//    im.layer.masksToBounds=YES;
//    im.layer.cornerRadius=im.width/2;
    im.center=bgVi.center;
    im.top=bgVi.height/2-im.height-30*self.scale;
    [bgVi addSubview:im];
    im.image=[UIImage imageNamed:imgName];
    UILabel *laa = [[UILabel alloc]initWithFrame:CGRectMake(0, im.bottom+5*self.scale, self.view.width, 20*self.scale)];
    laa.text=text;
    laa.font=DefaultFont(self.scale);
    laa.textColor=[UIColor grayColor];
    laa.textAlignment=NSTextAlignmentCenter;
    [bgVi addSubview:laa];
    
    return bgVi;
    
}
///** 计算文本视图高度 ---用于自适应*/
//-(CGFloat)countCellWithStr:(NSString *)str Font:(UIFont *)font width:(CGFloat)width{
//
//    UILabel *lab = [FZYControl createLabelWithFrame:(CGRectMake(0, 0, width, 0)) Font:font Text:str color:nil textAlignment:(NSTextAlignmentLeft) numberOfLines:0];
//
//    CGFloat height = [lab sizeThatFits:lab.size].height;
//
//    return height;
//}
#pragma mark-------token过期之后需要重新登录的方法
-(BOOL)loginWithOldTokenWithBlock:(void (^)(BOOL))block{
    
    if ([JMProjectManager isLogin]==NO) {
        
//        [self ShowAlertTitle:nil Message:@"请先登录" Delegate:self Block:^(NSInteger index) {
//            if (index==1) {
                self.hidesBottomBarWhenPushed=YES;
                FZYLoginVC *login = [FZYLoginVC new];
        
                [self presentViewController:login animated:YES completion:nil];
//            }
//         }];
        return NO;
    }
    
    return YES;
}
-(BOOL)doActionWithLoginState:(void (^)(void))actionBlock needForceLogin:(BOOL)needForce{
    
    if ([JMProjectManager isLogin]==NO) {
        self.hidesBottomBarWhenPushed=YES;
        FZYLoginVC *login = [FZYLoginVC new];
        login.loginResultBlock = ^(BOOL loginResult) {
            if(loginResult==YES){
                actionBlock();
            }else{
                if(needForce){
                    [self ShowAlertWithMessage:@"请先登录"];
                }else{
                    [login dismissModalViewControllerAnimated:YES];
                }
            }
        };
        [self presentViewController:login animated:YES completion:nil];
        return NO;
    }
    
    return YES;
}

-(NSString *)numofQ:(NSString *)string{

    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.numberStyle =NSNumberFormatterDecimalStyle;
    NSString *newAmount = [formatter stringFromNumber:[NSNumber numberWithFloat:[string floatValue]]];
    return newAmount;
}


-(NSString *)timeWithString:(NSString *)string{

    NSDateFormatter *fo = [NSDateFormatter new];
    [fo setDateFormat:@"yyyy-MM-dd"];
    NSDate *da = [fo dateFromString:string];
    return [fo stringFromDate:da];
}

-(NSString *)timeWithDate:(NSDate *)date{
    
    NSDateFormatter *fo = [NSDateFormatter new];
    [fo setDateFormat:@"yyyy-MM-dd"];
    NSString *da = [fo stringFromDate:date];
    NSDate *d = [fo dateFromString:da];
    return [fo stringFromDate:d];
}

-(NSString *)timeCToString:(double)tim{

    NSDate *dat = [NSDate dateWithTimeIntervalSince1970:tim];
    NSDateFormatter *fo = [NSDateFormatter new];
    [fo setDateFormat:@"yyyy-MM-dd"];
    return [fo stringFromDate:dat];
}

-(NSString *)timeCToStringWithmmss:(double)tim{
    
    NSDate *dat = [NSDate dateWithTimeIntervalSince1970:tim];
    NSDateFormatter *fo = [NSDateFormatter new];
    [fo setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [fo stringFromDate:dat];
}


-(UILabel *)getColorLabel:(UILabel *)label stringAndColor:(NSDictionary *)dict{
    
    NSMutableAttributedString * attributeString=[[NSMutableAttributedString alloc]initWithAttributedString:label.attributedText];
    NSRange outRange={0,0};
    
    
    
    for (NSString * key in dict.allKeys) {
        
        NSLog(@"%@",key);
        
        if (key) {
            
            if ([[dict valueForKey:key] isKindOfClass:[UIColor class]]) {
                NSRange range=[label.text rangeOfString:key options:NSNumericSearch range:NSMakeRange(0, outRange.location)];
                [attributeString  addAttribute:NSForegroundColorAttributeName value:(UIColor *)[dict valueForKey:key] range:range];
                
                NSRange range1=[label.text rangeOfString:key options:NSNumericSearch range:NSMakeRange(outRange.location+outRange.length, label.text.length-(outRange.location+outRange.length))];
                [attributeString addAttribute:NSForegroundColorAttributeName value:(UIColor *)[dict valueForKey:key] range:range1];
                
                
                
                outRange=range1;
                
                
            }
        }
    }
    label.attributedText=attributeString;
    return label;}

#pragma mark-----请求服务器  开始和结束的动画

-(void)startAnimating:(NSString *)set{
//    if (self.HUD) {
//        [self.HUD removeFromSuperview];
//        self.HUD=nil;
//    }
//
//    self.HUD = [MBProgressHUD showHUDAddedTo:self.appdelegate.window animated:YES];
//    self.HUD.mode = MBProgressHUDModeIndeterminate;
//    if ([[NSString stringWithFormat:@"%@",set] isEmptyString]) {
//        set=@"正在加载...";
//    }
//    self.HUD.label.text = set;
//    self.HUD.removeFromSuperViewOnHide = NO;
}



-(void)startAnimatingWithString:(NSString *)set{
//    if ([[NSString stringWithFormat:@"%@",set] isEmptyString]) {
//        return;
//    }
//    self.HUDString = [MBProgressHUD showHUDAddedTo:self.appdelegate.window animated:YES];
//    self.HUDString.mode = MBProgressHUDModeText;
//    self.HUDString.label.text= set;
//    self.HUDString.removeFromSuperViewOnHide = YES;
//    [self.HUDString hideAnimated:yes afterDelay:1.5];
}

-(void)stopAnimating{
//    [self.HUD hideAnimated:YES];
//    self.HUD = nil;
}

#pragma mark--------图片按比例压缩，
-(UIImage *) scaleImage: (UIImage *)image scaleFactor:(float)scaleBy
{
    if (image.size.width>1000) {
        scaleBy = 1000/image.size.width;
    }else{
        scaleBy= 1.0;
    }
    CGSize size = CGSizeMake(image.size.width * scaleBy, image.size.height * scaleBy);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformScale(transform, scaleBy, scaleBy);
    CGContextConcatCTM(context, transform);
    [image drawAtPoint:CGPointMake(0.0f, 0.0f)];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

-(NSString *)getOrderNum{

    NSDate *date = [NSDate date];
    NSDateFormatter *fo = [NSDateFormatter new];
    [fo setDateFormat:@"yyyyMMddHHmmss"];
    return [fo stringFromDate:date];

}

#pragma mark-----string某个字变色
-(NSMutableAttributedString*)stringColorAllString:(NSString *)string orgin:(NSString *)orgin{

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange range1=[string rangeOfString:[NSString stringWithFormat:@"%@",string]];
    
    [str addAttribute:NSForegroundColorAttributeName value:kTextColor range:range1];

    NSRange range=[string rangeOfString:[NSString stringWithFormat:@"%@",orgin]];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
    
    return str;


}
- (void)addKeyboardNotification {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillshow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    if ([self respondsToSelector:@selector(viewDidDisappear:)]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];    }
}
- (void)keyboardWillshow:(NSNotification *)noti {
    
}
- (void)keyboardWillHide:(NSNotification *)noti {
    
}
#pragma mark-----string某个字变色
-(NSMutableAttributedString*)stringColorAllString:(NSString *)string gradColor:(NSString *)orgin{
    
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange range1=[string rangeOfString:[NSString stringWithFormat:@"%@",string]];
    
    [str addAttribute:NSForegroundColorAttributeName value:kTextColor range:range1];

    NSRange range=[string rangeOfString:[NSString stringWithFormat:@"%@",orgin]];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:range];
    
    return str;
    
    
}
- (NSString *)getImgStrWithImgUrlStr:(NSString *)imgUrlStr quality:(CGFloat)compressionQuality {
    UIImageView *imgv = [UIImageView new];
    
    [imgv setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:nil];
    
    UIImage *_originImage = imgv.image;
    
    NSData *_data = UIImageJPEGRepresentation(_originImage,compressionQuality);
    
    //                NSString *_encodedImageStr = [_data base64Encoding];
    NSString *encodedImageStr = [_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}
- (NSString *)typeForImageData:(NSData *)data {
    
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            
            return @"image/jpeg";
            
        case 0x89:
            
            return @"image/png";
            
        case 0x47:
            
            return @"image/gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"image/tiff";
            
    }
    
    return nil;
    
}


-(NSMutableAttributedString *)stringColorAllString:(NSString *)string redString:(NSString *)redString{
    
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    
    NSRange range1=[string rangeOfString:[NSString stringWithFormat:@"%@",string]];
    
    [str addAttribute:NSForegroundColorAttributeName value:kTextColor range:range1];

    
    
    NSRange range=[string rangeOfString:[NSString stringWithFormat:@"%@",redString]];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    
    return str;
    
}

-(NSMutableAttributedString *)stringColorAllString:(NSString *)string YelloyString:(NSString *)redString{
    
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange range1=[string rangeOfString:[NSString stringWithFormat:@"%@",string]];
    
    [str addAttribute:NSForegroundColorAttributeName value:kTextColor range:range1];

    NSRange range=[string rangeOfString:[NSString stringWithFormat:@"%@",redString]];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255/255.0 green:150/255.0 blue:0 alpha:1] range:range];
    
    return str;
    
}


-(NSString *)getToday{

    NSDate *date = [NSDate date];
    NSDateFormatter *fo =[[NSDateFormatter alloc]init];
    [fo setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [fo stringFromDate:date];
    return str;

}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wimplicit-retain-self"



-(void)ShowAlertWithMessage:(NSString *)message{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
-(void)setName:(NSString *)name{
    self.navigationController.title=name;
}
-(void)ShowAlertTitle:(NSString *)title Message:(NSString *)message Delegate:(id)delegate Block:(AlertBlock)block{

    if (!delegate && !block) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
        //alert.tintColor=pinkTextColor;
        [alert show];
        _alertBlock=block;
    }

}


-(void)ShowAlertTitleWithText:(NSString *)title Message:(NSString *)message Delegate:(id)delegate Block:(AlertBlock1)block{

    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"取消" otherButtonTitles: @"确定",nil];
    alert.tag=900080000;
    alert.alertViewStyle=UIAlertViewStyleSecureTextInput;
    [alert show];
    _alertBlock1=block;
}

//给UILabel设置行间距和字间距

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = 6; //设置行间距
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    //设置字间距 NSKernAttributeName:@1.5f
    
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.2f
                          };
    
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    
    label.attributedText = attributeStr;
    
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    [alertView dismissWithClickedButtonIndex:0 animated:YES];
//
//    if (alertView.tag==900080000) {
//        if (_alertBlock1) {
//            _alertBlock1(buttonIndex,alertView);
//        }
//
//    }else{
//        if (_alertBlock) {
//            _alertBlock(buttonIndex);
//        }
//
//
//    }
//
//}



-(float)textWithView:(UILabel *)lable withWidth:(float)width{
    
    CGSize sizeToFit = [lable sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
    
}

#pragma mark------计算字符串的宽高，自适应

-(float)Text:(NSString *)text Size:(CGSize)size Font:(CGFloat)fone{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fone], NSParagraphStyleAttributeName:paragraphStyle.copy};
    return   [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
}
-(NSDictionary *)Style{
    NSDictionary *style=@{
                          @"body":[UIFont systemFontOfSize:12*self.scale],
                          @"Big":[UIFont systemFontOfSize:14*self.scale],
                          @"red":[UIColor redColor],
                          @"orange":@[[UIColor colorWithRed:255/255.0 green:132/225.0 blue:0/255.0 alpha:1],[UIFont fontWithName:@"HelveticaNeue" size:15*self.scale]],
                          @"gray13":@[[UIColor grayColor],[UIFont fontWithName:@"HelveticaNeue" size:13*self.scale  ]],
                          @"red13":@[[UIColor redColor],[UIFont systemFontOfSize:13*self.scale]],
                          @"gray10":@[[UIColor grayColor],[UIFont systemFontOfSize:10*self.scale]],
                          @"gray12":@[[UIColor grayColor],[UIFont systemFontOfSize:12*self.scale]],
                          @"red12":@[[UIColor redColor],[UIFont systemFontOfSize:12*self.scale]],
                          @"red15":@[[UIColor redColor],[UIFont systemFontOfSize:15*self.scale]],
                          @"Org10":@[  [UIColor colorWithRed:255/255 green:136/255.0 blue:34/255.0 alpha:1],[UIFont systemFontOfSize:10*self.scale]],
                          };
    return style;
}
#pragma mark - 屏幕选转
- (BOOL)shouldAutorotate
{
    return NO;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//  MARK: - 提示框
/**
 *  提示框
 */
-(void)showTiShiKuang:(NSString *)title msg:(NSString *)msg type:(TYAlertTransitionAnimation)type
{
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:title message:msg];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert transitionAnimation:type];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
/**
 *  提示框
 *
 *  @param title 标题
 *  @param msg   内容
 *  @param block TiShiKuangBlock
 */
-(void)showTiShiKuang:(NSString *)title msg:(NSString *)msg block:(TiShiKuangBlock)block
{
    
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:title message:msg];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        
    }]];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        _tiShiBlock=block;
        if (block) {
            _tiShiBlock(1);
        }
    }]];
    
    // first way to show ,use UIView Category
    [alertView showInWindowWithOriginY:200 backgoundTapDismissEnable:YES];
    
    
}
/**
 *  模糊弹出自定义提示框
 *
 *  @param View UIView
 */
-(void)showMoHuZiDingYiView:(UIView *)View
{
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:View preferredStyle:TYAlertControllerStyleAlert];
    
    // blur effect
    [alertController setBlurEffectWithView:self.view];
    alertController.backgoundTapDismissEnable = YES;
    //alertController.alertViewOriginY = 60;
    [self presentViewController:alertController animated:YES completion:nil];
    
}
/**
 *  弹出自定义提示框
 *
 *  @param View UIView
 *  @param tap  tap 点击View附近是否隐藏View
 */
-(void)showZiDingYiView:(UIView *)View isTap:(BOOL)tap
{
    [View showInWindowWithBackgoundTapDismissEnable:tap];
}
#pragma mark - zhPopupController视图
-(void)showZhPopupDropWithDrop:(NSInteger)Drop View:(UIView *)View Duration:(NSTimeInterval)duration Animated:(BOOL)Animated
{
    self.zh_popupController = [[zhPopupController alloc] init];
    [self.zh_popupController dropAnimatedWithRotateAngle:Drop];
    [self.zh_popupController presentContentView:View duration:duration springAnimated:Animated];
}
-(void)showZhPopupDisplayWithMaskType:(zhPopupMaskType)MaskType slideStyle:(NSInteger)slideStyle allowPan:(BOOL)allowPan View:(UIView *)View Duration:(NSTimeInterval)duration Animated:(BOOL)Animated displayTime:(NSTimeInterval)displayTime
{
    self.zh_popupController = [zhPopupController popupControllerWithMaskType:MaskType];
    self.zh_popupController.slideStyle = slideStyle;
    self.zh_popupController.allowPan = allowPan;
    // 弹出2秒后消失
    [self.zh_popupController presentContentView:View duration:duration springAnimated:Animated inView:nil displayTime:displayTime];
    
}
-(void)showZhPopupHuoJianWithMaskSlideStyle:(NSInteger)slideStyle Touched:(BOOL)Touched Direction:(BOOL)Direction  View:(UIView *)View Duration:(NSTimeInterval)duration Animated:(BOOL)Animated
{
    self.zh_popupController = [zhPopupController new];
    self.zh_popupController.dismissOnMaskTouched = Touched;
    self.zh_popupController.dismissOppositeDirection = Direction;
    self.zh_popupController.slideStyle = slideStyle;
    [self.zh_popupController presentContentView:View duration:duration springAnimated:Animated];
}
-(void)showZhPopupPushWithlayoutType:(zhPopupLayoutType)layoutType allowPan:(BOOL)allowPan   View:(UIView *)View Duration:(NSTimeInterval)duration Animated:(BOOL)Animated
{
    self.zh_popupController = [zhPopupController new];
    self.zh_popupController.layoutType = layoutType;
    self.zh_popupController.allowPan = allowPan;
    
    self.zh_popupController.maskTouched = ^(zhPopupController * _Nonnull popupController) {
        [popupController dismissWithDuration:0.25 springAnimated:NO];
    };
    [self.zh_popupController presentContentView:View duration:duration springAnimated:Animated];
    
}








UIView * createBottomLine(CGFloat Insert,UIView *superView) {
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(Insert,superView.bottom-.5, APPW-Insert*2, .5)];
    lineView.backgroundColor = kSeparatorColor;
    return lineView;
}
//  MARK: - 其他
-(UIView*)createCellLineSetX:(CGFloat)setX  SetY:(CGFloat)setY setWidth:(CGFloat)width setHeight:(CGFloat)height
{
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(setX, setY, width, height)];
    lineView.backgroundColor = kSeparatorColor;
    return lineView;
}
-(UIView*)createCellLineSet:(CGFloat)setX  SeY:(CGFloat)setY
{
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(setX, setY, [UIScreen mainScreen].bounds.size.width, 0.5)];
    //    lineView.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    lineView.backgroundColor = kSeparatorColor;
    return lineView;
}
//-(YYLabel*)createLabel
//{
//    YYLabel * label = [[YYLabel alloc]init];
//    label.textColor = kTextColor;
//    label.font = DefaultFont(self.scale);
//    label.userInteractionEnabled  = NO;
//    return label;
//}

- (BOOL)isContainsTwoEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         //         NSLog(@"hs++++++++%04x",hs);
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     isEomji = YES;
                 }
                 //                 NSLog(@"uc++++++++%04x",uc);
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3|| ls ==0xfe0f) {
                 isEomji = YES;
             }
             //             NSLog(@"ls++++++++%04x",ls);
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
         
     }];
    return isEomji;
}
// 字典转json字符串方法
- (NSString *)convertToJsonData:(NSMutableArray *)dictArr {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictArr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }
    else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma clang diagnostic pop
@end
