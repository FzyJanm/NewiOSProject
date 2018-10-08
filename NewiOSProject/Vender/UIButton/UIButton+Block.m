//
//  UIButton+Block.m
//  zufangwang
//
//  Created by 范智渊 on 2018/6/21.
//  Copyright © 2018年 范智渊. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>
@implementation UIButton (Block)

- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block
{
    
    objc_setAssociatedObject(self, &"myBlock", block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
             action:@selector(blockEvent:)
   forControlEvents:event];
    //    NSArray *array=[self actionsForTarget:self forControlEvent:UIControlEventTouchUpInside];
    //    for(int i=0;i<array.count;i++)
    //    {
    //        if([self allTargets].allObjects[i]!=self)
    //        {
    ////            NSArray *arr=[self actionsForTarget:([self allTargets].allObjects[i])
    ////                                forControlEvent:UIControlEventTouchUpInside];
    //            [self removeTarget:self
    //                        action:(SEL)array[i]
    //              forControlEvents:UIControlEventTouchUpInside];
    //        }
    //    }
}
-(void)blockEvent:(UIButton *)sender
{
    ActionBlock block=objc_getAssociatedObject(self, &"myBlock");
    if(block)
    {
        block();
    }
}
@end
