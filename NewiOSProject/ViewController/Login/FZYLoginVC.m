//
//  FZYLoginVC.m
//  NewiOSProject
//
//  Created by MAC on 2023/9/1.
//  Copyright © 2023 范智渊. All rights reserved.
//

#import "FZYLoginVC.h"
#import "FZYCaptcheButton.h"
#import <YYLabel.h>

@interface FZYLoginVC ()
{
    NSString *telNumber;
    NSString *codeNumber;;
    NSInteger state;//默认 0未填手机号 未填验证码 1已填写手机号 未填验证码 2验证码和手机号都已经填写
}
@property (nonatomic, strong)UIView *contView;//半透明白色容器试图
@property (nonatomic, strong)UIButton *chooseAreaBtn;//左边箭头也未按钮都可以点击
@property (nonatomic, strong)UILabel *areaAndPhoneLab;//区号加手机号一体

@property (nonatomic, strong)UIView *textTContentV;
@property (nonatomic, strong)FZYCaptcheButton *fetchCodeBtn;//获取手机号
@property (nonatomic, strong)UIButton *areaNumLab;//输入框左侧，显示已选的区号
@property (nonatomic, strong)UITextField *phoneAndCodeTf;//手机号验证码输入框
@property (nonatomic, strong)UILabel *voiceCodeLab;//语音获取手机号

@property (nonatomic, strong)FZYLoadingButton *loginBtn;

@property (nonatomic, strong)YYLabel *agreementLab;//隐私协议
@end

@implementation FZYLoginVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    用户登录流程
//    ● 开发测试时手机号使用当前日期+三位随机数字的形式（如20220701008）
//    ● 用户未输入手机号时，按钮不可点击
//    ● 用户输入手机号后，按钮可点击
//    ● 点击后转到获取验证码步骤
//    ● 点击跳到获取验证码步骤后，自动获取一次验证码，其中发送验证码接口的type传“login”
    
    
//    获取验证码
//    ● 显示手机号的区域点击可返回上一步重新输入手机号
//    ● 输入框右侧点击，为获取验证码，先调用发送验证码次数接口，获取当前用户已发送验证码的次数，其中发送验证码接口的type传“login”。
//    ● 若次数 <= 3，调用发送登录或注册短信【登录页】接口
//    按钮点击直至接口返回时，发送按钮为sending状态
//    ○ 若验证码接口报错，Toast提示接口返回的报错内容
//    ○ 接口调用成功后, 弹窗提示【Código de verificación por SMS obtenido con éxito】，验证码输入框右侧为倒计时一分钟，倒计时结束后显示原发送按钮内容，再次点击则继续重复点击后的逻辑
//  ● 若次数 > 3，调用显示弹窗让用户选择发送方式，也是调用发送登录或注册短信【登录页】接口
//    获取验证码成功之后取消弹窗，开始倒计时
    
    
//    语音验证码
//    ● 语音验证码区域点击，调用发送登录或注册短信【登录页】接口，获取语音验证码
//    ● 发送语言验证码独立于短信验证码输入控右侧按钮，不会产生倒计时
//    ● 发送请求时sending状态如下
//    验证码获取成功后，取消sending状态，弹窗提示【Le llamaremos en 5 min para darle el código de verificación.】
    
//    ● 用户未输入验证码时，登录按钮不可点击
//    ● 用户输入验证码后，按钮可点击，点击后调用短信登录和注册接口，若接口报错，则弹窗提示接口返回的报错内容。接口正常返回的token需添加到以后的请求头中，userId在后续接口中会被调用到。
//    ● 用户登录成功后，跳转到首页
    [self setUI];
}

-(void)setUI{
    
    UIImageView *topImgV = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, kAppW(), ScaleW(412)))];
    topImgV.image = ImageNamed(@"login_bg");
    [self.view addSubview:topImgV];
    
    
    UIImageView *logoImg = [[UIImageView alloc]initWithFrame:(CGRectMake(0, NAVIGATION_BAR_HEIGHT()+49, 64, 64))];
    [logoImg setImage:ImageNamed(@"login_logo")];
    [self.view addSubview:logoImg];
    logoImg.centerX = kAppW()/2;
    
    UILabel *titleLab = [FZYControl createLabelWithFrame:(CGRectMake(0, logoImg.bottom+12, kAppW(), FontH(18))) Font:fontWithWeight(18, UIFontWeightSemibold) Text:@"<app name >做可配置" color:Text_COLOR_LEVEL1()];
    titleLab.textAlignment = 1;
    [self.view addSubview:titleLab];
    
    
    _contView = [[UIView alloc]initWithFrame:(CGRectMake(16, titleLab.bottom+49, kAppW()-32, ScaleW(420)))];
    _contView.cornerRadius = 40;
    _contView.backgroundColor = HexAlpha_Str_COLOR(@"#ffffff", 0.86);
    [self.view addSubview:_contView];
    
    UILabel *contTitleLab = [FZYControl createLabelWithFrame:(CGRectMake(20, 40, kAppW(), FontH(25))) Font:BoldFont(24) Text:@"Inicio de sesión" color:Text_COLOR_LEVEL1()];
    [_contView addSubview:contTitleLab];
    
    
    //手机号显示区域
    _chooseAreaBtn = [FZYControl createButtonWithFrame:(CGRectMake(20, contTitleLab.bottom+41, 8, 14)) ImageName:@"login_back" Target:self Action:@selector(chooseAreaCode) font:nil Title:nil];
    [_contView addSubview:_chooseAreaBtn];
    
    _areaAndPhoneLab = [[UILabel alloc]initWithFrame:(CGRectMake(_chooseAreaBtn.right+10, 0, kAppW(), FontH(16)))];
    _areaAndPhoneLab.textColor = Text_COLOR_LEVEL1();
    _areaAndPhoneLab.font = Font(16);
    _areaAndPhoneLab.text = @"Número de teléfono";
    [_contView addSubview:_areaAndPhoneLab];
    _areaAndPhoneLab.centerY = _chooseAreaBtn.centerY;
    
    [_chooseAreaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.chooseAreaBtn.mas_right);
        make.top.centerY.equalTo(self.chooseAreaBtn.mas_centerY);
        make.width.equalTo(@8);
        make.width.equalTo(@14);
    }];
    
    
    //手机号验证码输入区域
    _textTContentV = [[UIView alloc]initWithFrame:(CGRectMake(_chooseAreaBtn.left, _chooseAreaBtn.bottom+21, _contView.width-40, 46))];
    _textTContentV.backgroundColor = Hex_Str_COLOR(@"#F4F4F4");
    _textTContentV.cornerRadius = 12;
    [_contView addSubview:_textTContentV];
    
    //区号选额
    _areaNumLab = [FZYControl createLabelWithFrame:(CGRectZero) Font:fontWithWeight(16, UIFontWeightMedium) Text:@"+52" color:Text_COLOR_LEVEL1()];
    [_textTContentV addSubview:_areaNumLab];
    WeakSelf
    [_areaNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.textTContentV).offset(12);
        make.top.bottom.equalTo(weakSelf.textTContentV);
    }];
    
    
    //登陆 和 获取验证码按钮
    _fetchCodeBtn = [FZYCaptcheButton new];
    _fetchCodeBtn.disabledTitleColor = Text_COLOR_LEVEL1();
    [_fetchCodeBtn addTarget:self action:@selector(fetchBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_fetchCodeBtn setTitle:@"Obtener codigo" forState:(UIControlStateNormal)];
    [_fetchCodeBtn setTitleColor:Button_ENABLE_TEXTCOLOR() forState:(UIControlStateNormal)];
    [_fetchCodeBtn setTitleColor:Button_UNABLE_TEXTCOLOR() forState:(UIControlStateSelected)];
    [_fetchCodeBtn setBackgroundImage:[UIImage imageWithColor:Button_ENABLE_BG_COLOR()] forState:(UIControlStateNormal)];
    [_fetchCodeBtn setBackgroundImage:[UIImage imageWithColor:Button_UNABLE_BG_COLOR()] forState:(UIControlStateSelected)];
    [_fetchCodeBtn setTitleColor:Button_UNABLE_TEXTCOLOR() forState:(UIControlStateSelected)];
    [_textTContentV addSubview:_fetchCodeBtn];
    _fetchCodeBtn.selected = YES;
    
    [_fetchCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.textTContentV.mas_right).offset(-12);
        make.top.bottom.equalTo(weakSelf.textTContentV);
    }];
    
    _fetchCodeBtn.countStartBlock = ^{
        [weakSelf.loginBtn startLoading];
    };
    _fetchCodeBtn.countFinshBlock = ^{
        [weakSelf.loginBtn endLoading];
        [weakSelf.fetchCodeBtn setTitle:@"Conseguir código" forState:(UIControlStateNormal)];
        [_fetchCodeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.textTContentV.mas_right).offset(-12);
            make.top.bottom.equalTo(weakSelf.textTContentV);
        }];
    };
    
    
    
    
    //验证码输入框
    _phoneAndCodeTf = [[UITextField alloc]init];
//    _phoneAndCodeTf.placeholder = @"Código de verificaci";
    _phoneAndCodeTf.placeholder = @"Número de teléfono";
    _phoneAndCodeTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_textTContentV addSubview:_phoneAndCodeTf];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeValue:) name:UITextFieldTextDidChangeNotification object:_phoneAndCodeTf];
    [_phoneAndCodeTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.areaNumLab.mas_right).offset(10);
        make.right.equalTo(weakSelf.fetchCodeBtn.mas_left).offset(10);
        make.top.bottom.equalTo(weakSelf.textTContentV);
    }];
    
    
    
    //语音验证码图片
    UIImageView *phoneImg = [[UIImageView alloc]initWithFrame:(CGRectMake(_textTContentV.left, _textTContentV.bottom+15, 14, 14))];
    [phoneImg setImage:ImageNamed(@"login_phone")];
    [_contView addSubview:phoneImg];
    
    //获取语音验证码
    _voiceCodeLab = [FZYControl createAutoWidthLabelWithOrgin:(CGPointMake(phoneImg.right+5, phoneImg.top)) Font:Font(12) Text:@"Código de verificación de voz >" color:Text_COLOR_LEVEL1()];
    [_contView addSubview:_voiceCodeLab];
    @weakify(self)
    [_voiceCodeLab tapAction:^(UIView *sender) {
        
    }];
    

    //登陆和获取验证码按钮

    _loginBtn = [[FZYLoadingButton alloc]initWithFrame:(CGRectMake(phoneImg.left, phoneImg.bottom+49, _contView.width-phoneImg.left*2, 46)) title:@"Obtener cuota" font:Font(16) titleLabelColor:Button_ENABLE_TEXTCOLOR() backgoundColor:Button_ENABLE_BG_COLOR() action:^{
        [weakSelf.loginBtn startLoading];
        delayOperation(5, ^{
            [weakSelf.loginBtn endLoading];
        });
        [weakSelf updateUI];
    }];
    _loginBtn.cornerRadius = 12;
    [_contView addSubview:_loginBtn];
    
    
    
    //协议
    _agreementLab = [[YYLabel alloc]initWithFrame:(CGRectMake(phoneImg.left, _loginBtn.bottom+15, _contView.width-phoneImg.left*2, 100))];
    _agreementLab.numberOfLines = 0;
    _agreementLab.lineBreakMode = NSLineBreakByCharWrapping;
    [_contView addSubview:_agreementLab];
    
    NSString *agreementStr =@"lnicio de sesión de la cuenta se considera que está deacuerdo del 《Acuerdo de Servicio》 al Usuario y el《Politica de privacidad》";

    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:ScaleW(12)], NSForegroundColorAttributeName: Hex_Str_COLOR(@"#9B9B9B")};
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:agreementStr attributes:attributes];
    
    NSRange range = [agreementStr rangeOfString:@"《Acuerdo de Servicio》"];
    [text yy_setTextHighlightRange:range color:Agreement_Text_COLOR() backgroundColor:UIColor.clearColor tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {

    }];
    
    NSRange range1 = [agreementStr rangeOfString:@"《Politica de privacidad》"];
    [text yy_setTextHighlightRange:range1 color:Agreement_Text_COLOR() backgroundColor:UIColor.clearColor tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
    }];
    _agreementLab.attributedText = text;
    
}
-(void)updateUI{
    WeakSelf;
    if(state==0){
        if([telNumber isValidMexicanPhoneNumber]){
            state = 1;
            self.fetchCodeBtn.selected = NO;
        }else{
            state = 0;
            self.fetchCodeBtn.selected = YES;
        }
    }
    if(state==1){
        if(_phoneAndCodeTf.text.length == 6){
            self.fetchCodeBtn.selected = NO;
            state = 2;
        }else{
            self.fetchCodeBtn.selected = YES;
            state = 1;
        }
    }
}
//MARK: - Action
-(void)fetchBtnClick:(FZYCaptcheButton *)sender{
    WeakSelf;
    [sender setTitle:@"60s" forState:(UIControlStateNormal)];
    [sender fire];
    [sender mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.textTContentV.mas_right).offset(-12);
        make.top.bottom.equalTo(weakSelf.textTContentV);
    }];
}
-(void)chooseAreaCode{
    
}

//这里可以通过发送object消息获取注册时指定的UITextField对象
- (void)textFieldDidChangeValue:(NSNotification *)notification
{
    UITextField *sender = (UITextField *)[notification object];
    [self updateUI];
    // self.model.text = sender.text;
}


//MARK: -lazyLoad


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
