//
//  homeVC.m
//  FeiHuaJiaoYu
//
//  Created by 范智渊 on 2018/10/8.
//  Copyright © 2018 范智渊. All rights reserved.
//

#import "FZYHomeVC.h"
#import "JMDropMenu.h"

@interface FZYHomeVC ()
{
    NSInteger verifyStatus;
    CGFloat top;
    
    UIButton *tipsBtn;
    UIButton *coverBtn;
    
    
    UIView *topBgContentV;
    UIView *verifyView;
    UIView *integralBoardV;
    UIButton *delegateBtn;
}
@property (nonatomic, strong)UIScrollView *mainSV;
@property (nonatomic, strong) JMDropMenu *menuView;

@end

@implementation FZYHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    JMProjectManager.sharedJMProjectManager.appConfig.isFirstVerify = NO;;
    JMProjectManager.sharedJMProjectManager.appConfig.isVerified = YES;
    [self setUI];
}
//MARK: - UI
-(void)setTopView{
    //配额板块
    topBgContentV = [[UIView alloc]initWithFrame:(CGRectMake(0, -40, kAppW(), 332+40))];
    [_mainSV addSubview:topBgContentV];
    topBgContentV.backgroundColor = WhiteColor();
    topBgContentV.layer.cornerRadius = 40;
    topBgContentV.layer.masksToBounds = NO;
    [topBgContentV setLayerShadow:HexAlpha_Str_COLOR(@"#74793D", 0.08) offset:(CGSizeMake(0, 2)) radius:16];
  
    UILabel *titleLab = [FZYControl createLabelWithFrame:(CGRectMake(20,25+40, kAppW(), FontH(31))) Font:BoldFont(28) Text:@"Mexiwallet" color:Text_COLOR_LEVEL1()];
    [topBgContentV addSubview:titleLab];
    
    if(JMProjectManager.sharedJMProjectManager.appConfig.isVerified){//认证通过UI
        
        UIView *subContentV = [[UIView alloc]initWithFrame:(CGRectMake(20, titleLab.bottom+25, kAppW()-40, 218+16))];
        subContentV.cornerRadius = 40;
        subContentV.backgroundColor = Hex_Str_COLOR(@"#F6FF82");
        [topBgContentV addSubview:subContentV];
        
        UILabel *leftLab = [FZYControl createAutoWidthLabelWithOrgin:(CGPointMake(20, 25)) Font:Font(12) Text:@"Cuota máximo disponible($)" color:Text_COLOR_LEVEL2()];
        [subContentV addSubview:leftLab];
        
        UILabel *chargeLab = [FZYControl createLabelWithFrame:(CGRectMake(20, leftLab.bottom+10, subContentV.width-141, FontH(39))) Font:BoldFont(36) Text:@"17,000" color:Hex_Str_COLOR(@"#222220")];
        [subContentV addSubview:chargeLab];
        
        tipsBtn = [FZYControl createButtonWithFrame:(CGRectMake(subContentV.width-34, 25, 15, 15)) buttonType:(UIButtonTypeSystem) buttonImageWithName:@"home_?" Target:self Action:@selector(tipsBtnClick)];
        [subContentV addSubview:tipsBtn];
        
        UILabel *tipsLab = [FZYControl createAutoWidthLabelWithOrgin:(CGPointMake(0, 25)) Font:Font(12) Text:@"Ver descripción" color:Text_COLOR_LEVEL2()];
        [subContentV addSubview:tipsLab];
        tipsLab.right = tipsBtn.left-5;
        
        UIView *botView = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, subContentV.width, 129))];
        [subContentV addSubview:botView];
        botView.bottom = subContentV.height;
        botView.backgroundColor = GradientColor(botView.size, FXGradientChangeDirectionHorizontal, @"#0F1511" ,@"#32383E");
        botView.cornerRadius = 40;
        
        UIImageView *topRightImg = [[UIImageView alloc]initWithFrame:(CGRectMake(subContentV.width-131, botView.top-52, 102, 52))];
        topRightImg.image = ImageNamed(@"home_topRightImg");
        [subContentV addSubview:topRightImg];
        
        
        top = 20;
        CGFloat space = (botView.height-FontH(14)*3-50)/2+FontH(14);
        
        for (int i=0; i<3; i++) {
            UILabel *keyLab = [FZYControl createLabelWithFrame:(CGRectMake(20, top, botView.width/2-20, FontH(14))) Font:Font(14) Text:@"Cuota utilizada" color:WhiteColor()];
            [botView addSubview:keyLab];
            
            UILabel *valueLab = [FZYControl createLabelWithFrame:(CGRectMake(botView.width/2, top, botView.width/2-20, FontH(16))) Font:mediumFont(16) Text:@"$500" color:Hex_Str_COLOR(@"#F6FF82")];
            [botView addSubview:valueLab];
            valueLab.textAlignment = 2;
            valueLab.centerY = keyLab.centerY;
            top += space;
        }
        if(JMProjectManager.sharedJMProjectManager.appConfig.isFirstVerify){
            
        }
    }else{//未认证通过UI
        UIView *subContentV = [[UIView alloc]initWithFrame:(CGRectMake(20, titleLab.bottom+25, kAppW()-40, 227))];
        subContentV.cornerRadius = 40;
        subContentV.backgroundColor = Hex_Str_COLOR(@"#F6FF82");
        [topBgContentV addSubview:subContentV];
        //最高限额
        UILabel *titleLab = [FZYControl createAutoWidthLabelWithOrgin:(CGPointMake(20, 25)) Font:Font(12) Text:@"Cuota máximo disponible($)" color:Text_COLOR_LEVEL2()];
        titleLab.textAlignment = 1;
        [subContentV addSubview:titleLab];
        
        //配额
        UILabel *chargeLab = [FZYControl createLabelWithFrame:(CGRectMake(20, titleLab.bottom+10, subContentV.width, FontH(42))) Font:BoldFont(40) Text:@"???" color:Hex_Str_COLOR(@"#222220")];
        chargeLab.textAlignment = 1;
        [subContentV addSubview:chargeLab];
        
        UIImageView *leftImg = [[UIImageView alloc]initWithFrame:(CGRectMake(20, chargeLab.bottom+23, (subContentV.width-53)/2, 70))];
        [leftImg setImage:ImageNamed(@"home_bgImg")];
        [subContentV addSubview:leftImg];
        
        UILabel *leftTipsLab = [FZYControl createAutoWidthLabelWithOrgin:(CGPointMake(20, 15)) Font:Font(12) Text:@"PIazo de préstamo" color:Text_COLOR_LEVEL2()];
        leftTipsLab.textAlignment = 1;
        [leftImg addSubview:leftTipsLab];
        
        UILabel *leftSubLab = [FZYControl createAutoWidthLabelWithOrgin:(CGPointMake(20, leftTipsLab.bottom+10)) Font:Font(16) Text:@"120 Días" color:Text_COLOR_LEVEL1()];
        leftTipsLab.textAlignment = 0;
        [leftImg addSubview:leftSubLab];
        
        UIImageView *rightImg = [[UIImageView alloc]initWithFrame:(CGRectMake(leftImg.right+13, chargeLab.bottom+23, (subContentV.width-53)/2, 70))];
        [rightImg setImage:ImageNamed(@"home_bgImg")];
        [subContentV addSubview:rightImg];
        
        UILabel *rightTipsLab = [FZYControl createAutoWidthLabelWithOrgin:(CGPointMake(20, 15)) Font:Font(12) Text:@"Tasa de Interés" color:Text_COLOR_LEVEL2()];
        rightTipsLab.textAlignment = 1;
        [rightImg addSubview:rightTipsLab];
        
        UILabel *rightSubLab = [FZYControl createAutoWidthLabelWithOrgin:(CGPointMake(20, leftTipsLab.bottom+10)) Font:Font(16) Text:@"0.05% Por día" color:Text_COLOR_LEVEL1()];
        rightSubLab.textAlignment = 0;
        [rightImg addSubview:rightSubLab];
        
        //获取配额按钮
        UIButton *cuotaBtn = [FZYControl createButtonWithFrame:(CGRectMake(40, subContentV.bottom+25, kAppW()-80, 36)) Target:self Action:@selector(cuotaBtnClick) Title:@"Obtener cuota" titlColor:Hex_Str_COLOR(@"#FEFFCC") font:Font(14) tag:0 backgroundColor:Text_COLOR_LEVEL1()];
        [topBgContentV addSubview:cuotaBtn];
        cuotaBtn.cornerRadius = 12;
        topBgContentV.height = cuotaBtn.bottom+40;
        
        
    }
}
-(void)setVerifyView{
    verifyView = [[UIView alloc]initWithFrame:(CGRectMake(0, topBgContentV.bottom, kAppW(), 140))];
    UILabel *verifyTitleLab = [FZYControl createLabelWithFrame:(CGRectMake(0, 13, kAppW(), FontH(18))) Font:BoldFont(18) Text:@"Tres pasos" color:Text_COLOR_LEVEL1() textAlignment:(NSTextAlignmentCenter) numberOfLine:0];
    [verifyView addSubview:verifyTitleLab];
    
    NSArray *titles = @[@"Autenticación",@"Revision rapida",@"Depósito inmediato"];
    for (int i=0; i<3; i++) {
        UIButton *iconBtn = [FZYControl createButtonWithFrame:(CGRectMake(kAppW()/3*i, verifyTitleLab.bottom+10, kAppW()/3, 74)) ImageName:[NSString stringWithFormat:@"home_icon%ld",i+1] Target:self Action:@selector(verifyBtnClick:) font:Font(12) Title:titles[i]];
        [verifyView addSubview:iconBtn];
        
        [iconBtn TiaoZhengButtonWithOffsit:3 TextImageSite:(UIButtonTextBottom)];
        
        if(i<2){
            UIImageView *arrowBtn = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, 10, 10))];
            [arrowBtn setImage:ImageNamed(@"home_arrow")];
            [verifyView addSubview:arrowBtn];
            arrowBtn.centerY = iconBtn.centerY-12-6;
            arrowBtn.centerX = kAppW()/3*(i+1);
        }
    }
    [_mainSV addSubview:verifyView];
    top = verifyView.bottom;

}
-(void)setIntegralView{
    //第二板块
    integralBoardV = [[UIView alloc]initWithFrame:(CGRectMake(18, top+13, kAppW()-18, 106))];
    integralBoardV.backgroundColor = WhiteColor();
    integralBoardV.layer.cornerRadius = 40;
    integralBoardV.layer.masksToBounds = NO;
    [integralBoardV setLayerShadow:HexAlpha_Str_COLOR(@"#E4E4E4", 0.47) offset:(CGSizeMake(0, 2)) radius:20];
    [_mainSV addSubview:integralBoardV];
    
    UILabel * integralTitleLab = [FZYControl createAutoHeightLabelWithOrgin:(CGPointMake(20, 20)) andWidth:integralBoardV.width-144 Font:fontWithWeight(14, UIFontWeightMedium) Text:@"Obtener el puntaje que usan losprestamistas" color:UIColor.blackColor];
    [integralBoardV addSubview:integralTitleLab];
    integralTitleLab.numberOfLines = 0;
    [FZYControl changeTextBoldAndTraitWithLabel:integralTitleLab changeStr:integralTitleLab.text font:14];
    
    
    UILabel * integralSubTitleLab = [FZYControl createAutoHeightLabelWithOrgin:(CGPointMake(20, integralTitleLab.bottom+5)) andWidth:integralBoardV.width-144 Font:fontWithWeight(11, UIFontWeightMedium) Text:@"Conocer su credito lo ayuda a solicitar prestamos de manera rapida y justa!" color:Hex_Str_COLOR(@"#BFC2C5")];
    [integralBoardV addSubview:integralSubTitleLab];
    integralSubTitleLab.numberOfLines = 0;
    [FZYControl changeTextTraitWithLabel:integralSubTitleLab changeStr:integralSubTitleLab.text font:11];
    
    
    
    UIButton *detailBtn = [FZYControl createButtonWithFrame:(CGRectMake(integralSubTitleLab.width-20, integralSubTitleLab.height-15, 15, 15)) buttonType:(UIButtonTypeSystem) buttonImageWithName:@"home_>" Target:self Action:@selector(detailBtnClick)];
    [integralBoardV addSubview:detailBtn];
    detailBtn.bottom = integralSubTitleLab.bottom;
    
    UIImageView *rightImg = [[UIImageView alloc]initWithFrame:(CGRectMake(integralBoardV.width-124, 10, 104, 89))];
    rightImg.image = ImageNamed(@"home_instrumentBoard");
    [integralBoardV addSubview:rightImg];
    top = integralBoardV.bottom;
    
}
-(void)setUI{
    self.view.backgroundColor = Hex_Str_COLOR(@"#F7F7F5");
    
    _mainSV = [[UIScrollView alloc]initWithFrame:(CGRectMake(0, NAVIGATION_BAR_HEIGHT(), kAppW(), kAppH()-TAB_BAR_HEIGHT()-NAVIGATION_BAR_HEIGHT()))];
    _mainSV.bounces = NO;
    [self.view addSubview:_mainSV];

    [self setTopView];
    if(JMProjectManager.sharedJMProjectManager.appConfig.isVerified){
        [self setIntegralView];
        [self setThirdView];
    }else{
        [self setVerifyView];
        [self setIntegralView];
    }
    
    delegateBtn = [FZYControl createButtonWithFrame:(CGRectMake(0, top, kAppW(), 37)) Target:self Action:@selector(delegateBtnClick) Title:@"《 Politica de privacidad 》" titlColor:Hex_Str_COLOR(@"#83860C") font:Font(12) tag:1 backgroundColor:UIColor.clearColor];
    [_mainSV addSubview:delegateBtn];
    
    
    _mainSV.contentSize =CGSizeMake(kAppW(), delegateBtn.bottom+40);
    
    
   
}
-(void)setThirdView{
    
    //第三板块
    NSArray *topTitles = @[@"Descongelar la cuota",@"Aumentar la cuota",@"Pedir préstamo"];
    NSArray *subTitles = @[@"Fracaso de transaccion",@"Go Tunai",@"1,000"];
    NSArray *contents = @[@"Verifique sus datos decuenta bancaria",@"Cuota posterior al reembolso",@"Importe máximo($）"];
    
    
    for (int i=0; i<topTitles.count; i++) {
     
        UIView *contentV = [[UIView alloc]initWithFrame:(CGRectMake(16, integralBoardV.bottom+220*i+15, kAppW()-32, 200))];
        [_mainSV addSubview:contentV];
        contentV.backgroundColor = WhiteColor();
        contentV.layer.cornerRadius = 40;
        contentV.layer.masksToBounds = NO;
        
        
        UILabel *topTitleLab = [FZYControl createLabelWithFrame:(CGRectMake(20, 15, kAppW(), FontH(17))) Font:BoldFont(16) Text:topTitles[i] color:Text_COLOR_LEVEL1()];
        [contentV addSubview:topTitleLab];
        
        UIView *subContentV = [[UIView alloc]initWithFrame:(CGRectMake(0, topTitleLab.bottom+25, contentV.width, 150))];
        subContentV.cornerRadius = 40;
        subContentV.backgroundColor = Hex_Str_COLOR(@"#F6FF82");
        [contentV addSubview:subContentV];
        subContentV.backgroundColor = GradientColor(subContentV.size, FXGradientChangeDirectionVertical, @"#FCFFDE", @"#FFFFFF");
        subContentV.bottom = contentV.height;
        
        
        UILabel *subTitleLab = [FZYControl createLabelWithFrame:(CGRectMake(20, 20, kAppW(), FontH(21))) Font:BoldFont(20) Text:subTitles[i] color:Text_COLOR_LEVEL1()];
        [subContentV addSubview:subTitleLab];
        
        UILabel *contentLab = [FZYControl createAutoHeightLabelWithOrgin:(CGPointMake(20, subTitleLab.bottom+5)) andWidth:subContentV.width-136 Font:Font(12) Text:contents[i] color:Hex_Str_COLOR(@"#9B9B9B")];
        [subContentV addSubview:contentLab];
        contentLab.numberOfLines = 0;
        
        UIButton *modificarBtn = [FZYControl createButtonWithFrame:(CGRectMake(subTitleLab.left, subContentV.height-56, 120, 36)) Target:self Action:@selector(modificarBtnClick:) Title:@"modificar" titlColor:Hex_Str_COLOR(@"#FEFFCC") font:Font(14) tag:i backgroundColor:Text_COLOR_LEVEL1()];
        [subContentV addSubview:modificarBtn];
        modificarBtn.cornerRadius = 12;
        
        UIImageView *coinImg = [[UIImageView alloc]initWithFrame:(CGRectMake(modificarBtn.right+15, 0, 28, 28))];
        coinImg.centerY = modificarBtn.centerY;
        coinImg.image =ImageNamed(@"home_coin");
        [subContentV addSubview:coinImg];
        
        NSString *imageName = [NSString stringWithFormat:@"home_image0%ld",i+1];
        UIImageView *rightImg = [[UIImageView alloc]initWithFrame:(CGRectMake(subContentV.width-120, 0, 110, i==0?110:164))];
        rightImg.image =ImageNamed(imageName);
        [contentV addSubview:rightImg];
        rightImg.bottom = contentV.height;
        top = contentV.bottom;
    }
}
-(JMDropMenu *)menuView {
    UIWindow * Window =[[[UIApplication sharedApplication] delegate] window];
    CGRect rect =[tipsBtn convertRect:tipsBtn.bounds toView:Window];
    NSArray *titles = @[@"Descripcion de las cuotas :Cuota utilizada = pedido de prestamo exitosoCuota congelada = pedido en proceso derevision y deposito Cuota disponible = cuota disponible de pedirprestamo",@"秋"];
    CGRect menuRect = CGRectMake(40, rect.origin.y+rect.size.height, kAppW()-80, 150);
    if(!_menuView){
        CGFloat top = 0;
        top = NAVIGATION_BAR_HEIGHT();
        _menuView = [JMDropMenu showDropMenuFrame:(menuRect) ArrowOffset:90-20 TitleArr:titles ImageArr:nil Type:(JMDropMenuTypeQQ) LayoutType:(JMDropMenuLayoutTypeTitle) RowHeight:150 Delegate:nil radius:20];
        _menuView.tableView.scrollEnabled = NO;
        _menuView.titleColor = WhiteColor();
        _menuView.alignment = NSTextAlignmentLeft;
        coverBtn = [[UIButton alloc]initWithFrame:(CGRectMake(0, 0, kAppW(), kAppH()))];
        [self.view addSubview:coverBtn];
        [coverBtn addTarget:self action:@selector(coverBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }else{
        _menuView.frame = menuRect;
    }
    
    return _menuView;
}


//MARK: - action
-(void)delegateBtnClick{
    
}
-(void)modificarBtnClick:(UIButton *)sender{
    
}
-(void)cuotaBtnClick{
    
}
-(void)tipsBtnClick{
    [self.view addSubview:self.menuView];
}
-(void)coverBtnClick{
    [self.menuView removeFromSuperview];
}
-(void)detailBtnClick{
}
-(void)verifyBtnClick:(UIButton *)sender{
    [self doActionWithLoginState:^{
            
    } needForceLogin:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
