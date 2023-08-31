//
//  BMCornerSearchTextField.m
//  buymore
//
//  Created by 范智渊 on 2020/7/15.
//  Copyright © 2020 JLC. All rights reserved.
//

#import "BMCornerSearchTextField.h"

@implementation BMCornerSearchTextField
//改变文字位置
-(CGRect) textRectForBounds:(CGRect)bounds{
    CGRect iconRect=[super textRectForBounds:bounds];
    iconRect.origin.x+=17;
    return iconRect;
}
//改变编辑时文字位置
-(CGRect) editingRectForBounds:(CGRect)bounds{
    CGRect iconRect=[super editingRectForBounds:bounds];
    iconRect.origin.x+=17;
    return iconRect;
}
@end
