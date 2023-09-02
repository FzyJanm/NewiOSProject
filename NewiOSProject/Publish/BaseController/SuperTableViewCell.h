//
//  SuperTableViewCell.h
//  Wedding
//
//  Created by apple on 15/7/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineView.h"
//#import "YYKit.h"

@interface SuperTableViewCell : UITableViewCell
@property(nonatomic,assign)float scale;

-(float)Text:(NSString *)text Size:(CGSize)size Font:(CGFloat)fone;
//-(CGFloat)countCellWithStr:(NSString *)str Font:(UIFont *)font width:(CGFloat)width;
//-(YYLabel*)createLabel;
-(UIView*)createCellLineSetX:(CGFloat)setX  SetY:(CGFloat)setY setWidth:(CGFloat)width setHeight:(CGFloat)height;
-(UIView*)createCellLineSetX:(CGFloat)setX  SetY:(CGFloat)setY;
@end
