//
//  UIViewController+PushDestoryCurrent.m
//  JMBaseProject
//
//  Created by mac on 2022/7/26.
//  Copyright © 2022 liuny. All rights reserved.
//

#import "UIViewController+PushDestoryCurrent.h"

@implementation UIViewController (PushDestoryCurrent)
- (void)pushSelf {
    [UIViewController.currentViewController.navigationController pushViewController:self animated:YES];
}
-(void)pushVCDestoryCurrent:(UIViewController *)vc {
    // 获取当前路由的控制器数组
    NSMutableArray *vcArray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    // 打印当前路由的控制器数组
    NSLog(@"==the vcArray is %@", vcArray);
    // 获取档期控制器在路由的位置
    int index = (int)[vcArray indexOfObject:self];
    // 移除当前路由器
    [vcArray removeObjectAtIndex:index];
     // 添加新控制器
    [vcArray addObject:vc];
    // 打印新增后的控制器数组
    NSLog(@"==the vcArray is %@", vcArray);
     // 重新设置当前导航控制器的路由数组
    [self.navigationController setViewControllers:vcArray animated:YES];
}
+ (UIViewController*) currentViewController {
    
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}

#pragma mark - 内部方法
+ (UIViewController *) findBestViewController:(UIViewController*)vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
        
    }
}

@end
