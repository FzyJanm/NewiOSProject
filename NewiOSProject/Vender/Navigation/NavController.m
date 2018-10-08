//
//  NavController.m
//  zufangwang
//
//  Created by 范智渊 on 2018/6/22.
//  Copyright © 2018年 范智渊. All rights reserved.
//

#import "NavController.h"

@interface NavController ()

@end

@implementation NavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.改变导航栏按钮的颜色
    self.navigationBar.tintColor = [UIColor grayColor];
    // 2.滑动返回手势
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    
}

#pragma mark 返回按钮
-(void)popself {
    [self popViewControllerAnimated:YES];
}

#pragma mark 创建返回按钮
-(UIBarButtonItem *)createBackButton {
    
    UIBarButtonItem *backBarBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui1"] style:UIBarButtonItemStylePlain target:self action:@selector(popself)];
    backBarBtnItem.title = @"";
    
    
    return  backBarBtnItem;
}

#pragma mark 重写方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1) {
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
    }
}

@end
