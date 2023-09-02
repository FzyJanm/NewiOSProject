//
//  FZYPublicAlertView.m
//  NewiOSProject
//
//  Created by MAC on 2023/9/1.
//  Copyright © 2023 范智渊. All rights reserved.
//

#import "FZYPublicAlertView.h"
@interface FZYPublicAlertView()
@property(nonatomic)UIView *contentView;
@property(nonatomic)UIButton *closeBtn;
@end
@implementation FZYPublicAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _contentView = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, kAppW(), kAppH()))];
        _contentView.backgroundColor = HexAlpha_Str_COLOR(@"#000000", 0.3);
        
        self.centerX = kAppW()/2;
        _topImgV = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, frame.size.width, 190))];
        _topImgV.image = ImageNamed(@"alert_bg_coin");
        [self addSubview:_topImgV];
        [_contentView addSubview:self];
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title titleTop:(CGFloat)top{
    if(self = [self initWithFrame:frame]){
        _titleLab = [FZYControl createLabelWithFrame:(CGRectMake(0, top, frame.size.width, top==0?70:top)) Font:BoldFont(18) Text:title color:Text_COLOR_LEVEL1()];
        [self addSubview:_titleLab];
    }
    return self;
}
-(void)closeBtnClick{
    [self dismiss];
}

-(void)showAlertWithPosition:(FZYPublicAlertViewPosition)position bottomBtns:(nonnull NSArray *)btnTitles{
    if(position==FZYPublicAlertViewPositionCenter){
        
        self.layer.cornerRadius = 30;
        self.layer.masksToBounds = NO;
        
        if(btnTitles.count==1){
            
            UIButton *botBtn = [FZYControl createButtonWithFrame:(CGRectMake(40, self.height-76, self.width-40, 46)) Target:self Action:@selector(botBtnAction:) Title:btnTitles[0] titlColor:Hex_Str_COLOR(@"#FEFFCC") font:Font(14) tag:0 backgroundColor:Text_COLOR_LEVEL1()];
            [self addSubview:botBtn];
            botBtn.cornerRadius = 12;
        }
        if(btnTitles.count==2){
            UIButton *firstBtn = [FZYControl createButtonWithFrame:(CGRectMake(20, self.height-76, (self.width-50)/2, 46)) Target:self Action:@selector(botBtnAction:) Title:btnTitles[0] titlColor:Hex_Str_COLOR(@"#FEFFCC") font:Font(14) tag:0 backgroundColor:Text_COLOR_LEVEL1()];
            [self addSubview:firstBtn];
            firstBtn.cornerRadius = 12;
            
            UIButton *secBtn = [FZYControl createButtonWithFrame:(CGRectMake(40, self.height-76, self.width-40, 46)) Target:self Action:@selector(botBtnAction:) Title:btnTitles[0] titlColor:Hex_Str_COLOR(@"#FEFFCC") font:Font(14) tag:0 backgroundColor:Text_COLOR_LEVEL1()];
            [self addSubview:secBtn];
            secBtn.cornerRadius = 12;
            
        }
    }else{
        if(btnTitles.count==2){
            
            UIButton *botBtn = [FZYControl createButtonWithFrame:(CGRectMake(20, self.height-76, self.width-40, 46)) Target:self Action:@selector(botBtnAction:) Title:btnTitles[1] titlColor:Hex_Str_COLOR(@"#FEFFCC") font:Font(14) tag:0 backgroundColor:Text_COLOR_LEVEL1()];
            botBtn.tag = 1;
            [self addSubview:botBtn];
            botBtn.cornerRadius = 12;
            
            UIButton *topBtn = [FZYControl createButtonWithFrame:(CGRectMake(40, botBtn.top-56, self.width-40, 46)) Target:self Action:@selector(botBtnAction:) Title:btnTitles[0] titlColor:Hex_Str_COLOR(@"#FEFFCC") font:Font(14) tag:0 backgroundColor:Hex_Str_COLOR(@"#ffffff")];
            [self addSubview:topBtn];
            topBtn.cornerRadius = 12;
            
        }
    }
    [[UIApplication sharedApplication].keyWindow addSubview:_contentView];
}
-(void)botBtnAction:(UIButton *)sender{
    if([self.delegate respondsToSelector:@selector(didClickBtnAtIndex:)]){
        [self.delegate didClickBtnAtIndex:sender.tag];
    }
}
-(void)addCloseBtn{
    _closeBtn = [FZYControl createButtonWithFrame:(CGRectMake(0, 0, 28, 28)) buttonType:(UIButtonTypeSystem) buttonImageWithName:@"close_white" Target:self Action:@selector(closeBtnClick)];
    [_contentView addSubview:_closeBtn];
   
}
-(void)dismiss{
    [_contentView removeFromSuperview];
    [_closeBtn removeFromSuperview];
    _closeBtn = nil;
}

@end
