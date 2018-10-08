//
//  IMGViewController.m
//  PrepareBusiness
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 com.ruanmeng. All rights reserved.
//

#import "IMGViewController.h"

@interface IMGViewController ()

@end

@implementation IMGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.s
    self.navigationController.navigationBarHidden=YES;
    UIImageView *img = [[UIImageView alloc]initWithFrame:self.view.bounds];
    img.image=[UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:img];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
