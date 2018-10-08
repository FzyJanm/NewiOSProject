//
//  SuperTabBarViewController.m
//  AFNetworking
//
//  Created by 范智渊 on 2018/6/28.
//

#import "SuperTabBarViewController.h"
#import "RDVTabBarItem.h"
#import "EAIntroView.h"

#import "HomeVC.h"
#import "MeVC.h"
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
    
//    self.tabBar.backgroundView.layer.shadowColor = [UIColor grayColor].CGColor;
//    self.tabBar.backgroundView.layer.shadowOpacity = .23;
    self.tabBar.height = iPhoneX?83:49;
    self.rdv_tabBarItem.itemHeight = 49;
    //
  
    
//    self.rdv_tabBarItem.top = 0;
    self.delegate = self;
    
    UINavigationController *firstNVC    = [[UINavigationController alloc]
                                        initWithRootViewController:[NSClassFromString(@"HomeVC") new]];
    UINavigationController *secondNVC   = [[UINavigationController alloc]
                                        initWithRootViewController:[NSClassFromString(@"CategoryVC") new]];
    UINavigationController *thirdNVC    = [[UINavigationController alloc]
                                        initWithRootViewController:[NSClassFromString(@"ShoppingCartVC") new]];
    UINavigationController *meNVC       = [[UINavigationController alloc]
                                        initWithRootViewController:[NSClassFromString(@"MeVC") new]];
    
    
    
    [self setViewControllers:@[firstNVC, secondNVC,thirdNVC,meNVC]];
    thirdNVC.rdv_tabBarItem.badgeBackgroundColor = kThemeColor;
//     [ShoppingCartVC sharedShoppingCartVC].rdv_tabBarItem.size = CGSizeMake(22, 18);
    thirdNVC.rdv_tabBarItem.badgeTextFont = FONT(9*SCALE/2.25);
    [self customizeTabBarForController:self];
    
    
}


- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    //    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    //    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"shouye", @"fenlei", @"gouwuche",@"wode"];
    NSArray *tabBarTitles = @[@"首页",@"分类",@"购物车",@"我的"];
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        //        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@1",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                        [tabBarItemImages objectAtIndex:index]]];
        
        item.title = tabBarTitles[index];
        item.selectedTitleAttributes =  @{ NSFontAttributeName: [UIFont systemFontOfSize:11],
                                           NSForegroundColorAttributeName: kThemeColor,};
        item.unselectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont systemFontOfSize:11],
                                           NSForegroundColorAttributeName: kSelectedColor,
                                           };
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
