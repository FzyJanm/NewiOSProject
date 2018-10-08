//
//  SuperTableViewCell.m
//  Wedding
//
//  Created by apple on 15/7/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SuperTableViewCell.h"

@implementation SuperTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _scale=1.0;
        if ([[UIScreen mainScreen] bounds].size.height > 480)
        {
            if (rStatusBarHeight > 20)
            {
                _scale= 667.0/568.0;
            }
            else
            {
                _scale = [[UIScreen mainScreen] bounds].size.height / 568.0;
            }
        }
    }
    return self;
}

//-(YYLabel*)createLabel
//{
//    YYLabel * label = [[YYLabel alloc]init];
//    label.textColor = kTextColor;
//    label.font = DefaultFont(self.scale);
//    label.userInteractionEnabled  = NO;
//    return label;
//}

/** 计算文本视图高度 ---用于自适应*/
-(CGFloat)countCellWithStr:(NSString *)str Font:(UIFont *)font width:(CGFloat)width{
    UILabel *lab = [FZYControl createLabelWithFrame:(CGRectMake(0, 0, width, 0)) Font:font Text:str color:nil textAlignment:(NSTextAlignmentLeft) numberOfLines:0];
    
    CGFloat height = [lab sizeThatFits:lab.size].height;
    
    return height;
}

//+(CGFloat)countCellWithStr:(NSString *)str Font:(UIFont *)font width:(CGFloat)width {
//    return  [self countCellWithStr:str Font:font width:width];
//}

-(float)Text:(NSString *)text Size:(CGSize)size Font:(CGFloat)fone {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fone], NSParagraphStyleAttributeName:paragraphStyle.copy};
    return   [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
}

-(UIView*)createCellLineSetX:(CGFloat)setX  SetY:(CGFloat)setY setWidth:(CGFloat)width setHeight:(CGFloat)height
{
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(setX, setY, width, height)];
    lineView.backgroundColor = kSeparatorColor;
    return lineView;
}

-(UIView*)createCellLineSetX:(CGFloat)setX  SetY:(CGFloat)setY
{
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(setX, setY, [UIScreen mainScreen].bounds.size.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    return lineView;
}

@end
