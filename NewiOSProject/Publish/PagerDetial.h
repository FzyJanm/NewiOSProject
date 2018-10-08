//
//  PagerDetial.h
//  ZhongHang
//
//  Created by 范智渊 on 2018/7/18.
//  Copyright © 2018年 范智渊. All rights reserved.
//

#import "SuperViewController.h"

@interface PagerDetial : SuperViewController
@property (nonatomic, strong)NSString *TitleStr;
//广告类型对应的 action
@property (nonatomic, strong)NSString *action;
//广告对应ID
@property (nonatomic, strong)NSString * adID;
//不同广告对应的Id参数的 key
@property (nonatomic, strong)NSString *IDType;

@property (nonatomic, strong)NSString *timeStr;

@property (nonatomic, strong)NSString *contentTitle;

@end
