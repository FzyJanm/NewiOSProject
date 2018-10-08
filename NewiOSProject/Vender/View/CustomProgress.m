
//
//  CustomProgress.m
//  WisdomPioneer
//
//  Created by 主用户 on 16/4/11.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "CustomProgress.h"

@implementation CustomProgress
@synthesize bgimg,leftimg,presentlab;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        bgimg.layer.borderColor = [UIColor clearColor].CGColor;
        bgimg.layer.borderWidth =  1;
        bgimg.layer.cornerRadius = bgimg.frame.size.height/2;
        [bgimg.layer setMasksToBounds:YES];

        [self addSubview:bgimg];
        leftimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
        leftimg.layer.borderColor = [UIColor clearColor].CGColor;
        leftimg.layer.borderWidth =  1;
        leftimg.layer.cornerRadius = leftimg.frame.size.height/2;
        [leftimg.layer setMasksToBounds:YES];
        [self addSubview:leftimg];
        
        presentlab = [[UILabel alloc] initWithFrame:bgimg.bounds];
        presentlab.textAlignment = NSTextAlignmentCenter;
        presentlab.textColor = [UIColor whiteColor];
        presentlab.font = [UIFont systemFontOfSize:16];
        presentlab.hidden=YES;
        [self addSubview:presentlab];
    }
    return self;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wimplicit-retain-self"


-(void)setPresent:(int)present
{
    dispatch_async(dispatch_get_main_queue(), ^{
        presentlab.text = [NSString stringWithFormat:@"%d％",present];
        leftimg.frame = CGRectMake(0, 0, self.frame.size.width/100*present, self.frame.size.height);
    });
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//这里写出现警告的代码就能实现去除警告
#pragma clang diagnostic pop
@end
