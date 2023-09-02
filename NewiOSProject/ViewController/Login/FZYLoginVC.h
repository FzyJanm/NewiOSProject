//
//  FZYLoginVC.h
//  NewiOSProject
//
//  Created by MAC on 2023/9/1.
//  Copyright © 2023 范智渊. All rights reserved.
//

#import "SuperViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FZYLoginVC : SuperViewController
@property (nonatomic,copy)void (^loginResultBlock)(BOOL loginResult);

@end

NS_ASSUME_NONNULL_END
