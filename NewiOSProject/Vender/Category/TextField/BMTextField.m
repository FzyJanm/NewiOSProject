//
//  BMTextField.m
//  buymore
//
//  Created by apple on 2019/5/5.
//  Copyright © 2019年 Mac. All rights reserved.
//

#import "BMTextField.h"

@implementation BMTextField

//改变小图标位置
//- (CGRect)leftViewRectForBounds:(CGRect)bounds {
//    CGRect leftRect = [super leftViewRectForBounds:bounds];
//    leftRect.origin.x += 10; //右边偏10
//    return leftRect;
//}

//改变右侧小图标位置
//- (CGRect)rightViewRectForBounds:(CGRect)bounds {
//    CGRect rightRect = [super rightViewRectForBounds:bounds];
//    rightRect.origin.x -= 10; //左边偏10
//    return rightRect;
//}

//改变文字位置
-(CGRect) textRectForBounds:(CGRect)bounds{
    CGRect iconRect=[super textRectForBounds:bounds];
    iconRect.origin.x+=10;
    return iconRect;
}
//改变编辑时文字位置
-(CGRect) editingRectForBounds:(CGRect)bounds{
    CGRect iconRect=[super editingRectForBounds:bounds];
    iconRect.origin.x+=10;
    return iconRect;
}
@end
