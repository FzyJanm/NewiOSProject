//
//  SuperTabBarViewController.m
//  AFNetworking
//
//  Created by 范智渊 on 2018/6/28.
//

#import "SuperTabBarViewController.h"
#import "RDVTabBarItem.h"
#import "EAIntroView.h"
#import "FZYHomeVC.h"
#import "FZYMeVC.h"
#import "FZYOrderVC.h"
@interface SuperTabBarViewController ()<EAIntroDelegate> {
    UIView *_contentView;
    EAIntroView *_intro;//一个 view
    NSMutableArray *_pageArray;
    NSMutableArray *_startImageDataArray;
    
    NSMutableArray *randomArray;
}
@end

@implementation SuperTabBarViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    if(IS_iPhoneX()){
        self.tabBar.height = 83;
    }else{
        self.tabBar.height = 49;
    }
    self.rdv_tabBarItem.itemHeight = 49;
    self.tabBar.separtorLine.backgroundColor = UIColor.clearColor;
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, kAppW(), self.tabBar.height+20))];
    bgImg.backgroundColor = WhiteColor();
    bgImg.layer.cornerRadius = 20;
    bgImg.layer.masksToBounds = YES;
//    [self.tabBar insertSubview:bgImg atIndex:3];
    [[UITabBar appearance] insertSubview:bgImg atIndex:0];
    self.tabBar.tintColor = UIColor.clearColor;
    self.tabBar.backgroundColor = UIColor.clearColor;
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.tabBar.tintColor = UIColor.clearColor;
    self.rdv_tabBarItem.top = 0;
    self.delegate = self;
    UITabBarAppearance *apperance =  self.tabBarController.tabBar.standardAppearance.copy;
    apperance.shadowImage = [UIImage imageWithColor:UIColor.clearColor];
    apperance.backgroundColor = UIColor.clearColor;
    apperance.backgroundEffect = nil;
    self.tabBarController.tabBar.standardAppearance = apperance;
    self.tabBarController.tabBar.scrollEdgeAppearance = apperance;
    for (UIView *subV in self.tabBarController.tabBar.subviews) {
//        UIVisualEffectBackdropView
        if([subV isKindOfClass:[UIVisualEffectView class]] || [subV isKindOfClass:NSClassFromString(@"UIVisualEffectBackdropView")]){
            subV.backgroundColor = UIColor.clearColor;
        }
    }
//    if #available(iOS 13, *) {
//        let appearance = self.tabBar.standardAppearance.copy()
//        //appearance.shadowImage = UIImage.withColor(.yellow)///设置阴影
//        //appearance.shadowColor = .yellow///设置阴影
//        appearance.backgroundImage = UIImage.withColor(.yellow)
//        appearance.backgroundColor = .yellow
//        appearance.backgroundEffect = nil////这句话非常重要，在不动.translucent属性前提下，设置纯背景颜色，特别是设置tabbar透明，非常重要
//        self.tabBar.standardAppearance = appearance
//        if #available(iOS 15.0, *) {
//          ///用这个方法的，这个一定要加，否则15.0系统下会出问题，一滑动tabbar就变透明!!!
//           self.tabBar.scrollEdgeAppearance = appearance
//          } else { }
//        }
    UINavigationController *firstNVC    = [[UINavigationController alloc]
                                        initWithRootViewController:[NSClassFromString(@"FZYHomeVC") new]];
    UINavigationController *secondNVC   = [[UINavigationController alloc]
                                        initWithRootViewController:[NSClassFromString(@"FZYOrderVC") new]];
//    UINavigationController *thirdNVC    = [[UINavigationController alloc]
//                                        initWithRootViewController:[NSClassFromString(@"ShoppingCartVC") new]];
    UINavigationController *meNVC       = [[UINavigationController alloc]
                                        initWithRootViewController:[NSClassFromString(@"FZYMeVC") new]];
    
    
    
    [self setViewControllers:
     @[firstNVC,
       secondNVC,
//       thirdNVC,
       meNVC]];
//    thirdNVC.rdv_tabBarItem.badgeBackgroundColor = kThemeColor;
////     [ShoppingCartVC sharedShoppingCartVC].rdv_tabBarItem.size = CGSizeMake(22, 18);
//    thirdNVC.rdv_tabBarItem.badgeTextFont = FONT(9*SCALE/2.25);
    [self customizeTabBarForController:self];
    
    
}


- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    //    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    //    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"shouye",
                                  @"order",
//                                  @"gouwuche",
                                  @"wode"];
    NSArray *tabBarTitles = @[@"首页",
                              @"分类",
//                              @"购物车",
                              @"我的"];
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        //        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@1",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                        [tabBarItemImages objectAtIndex:index]]];
        
//        item.title = tabBarTitles[index];
//        item.selectedTitleAttributes =  @{ NSFontAttributeName: [UIFont systemFontOfSize:11],
//                                           NSForegroundColorAttributeName: kThemeColor,};
//        item.unselectedTitleAttributes = @{
//                                           NSFontAttributeName: [UIFont systemFontOfSize:11],
//                                           NSForegroundColorAttributeName: kSelectedColor,
//                                           };
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        index++;
    }
}
    
-(BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
//    UINavigationController *nav=(UINavigationController *)viewController;
//    if ([nav.visibleViewController isKindOfClass:[MeVC class]]) {
//
//        if ([Stockpile sharedStockpile].isLogin== NO) {
//            LoginVC *login = [[LoginVC alloc]init];
//            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:login] animated:YES completion:^{
//            }];
//            return NO;
//        }
//    }
    return YES;
}






@end
