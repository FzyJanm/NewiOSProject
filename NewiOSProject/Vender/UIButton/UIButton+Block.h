//
//  UIButton+Block.h
//  zufangwang
//
//  Created by 范智渊 on 2018/6/21.
//  Copyright © 2018年 范智渊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Block)
typedef void (^ActionBlock)(void);
/*
 *  handleControlEvent:withBlock:
 *  使用block处理button事件
 *  入参:event 触发类型                 例: UIControlEventTouchUpInside
 *      block 满足触发条件后的事件        例:^{}
 *  注:最后入参有效,同时只能保存一个block触发事件
 */
- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block;
@end
