//
//  UIImageView+TransitionAnimation.m
//  buymore
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 JLC. All rights reserved.
//

#import "UIImageView+TransitionAnimation.h"

@implementation UIImageView (TransitionAnimation)
- (void)animatedChangeToImage:(UIImage *)img
{
    [UIView transitionWithView:self
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.image = img;
                    } completion:NULL];
}
- (void)setImageUrl:(NSString *)imgUrl {
    if([imgUrl containsString:@"https://gebao.oss-cn-beijing.aliyuncs.com"]){
//        [self sd_setImageWithURL:imgUrl placeholderImage:kPlaceholderBannerImg()];
    }else{
//        [self sd_setImageWithURL:URLImageWithUrlStr(imgUrl) placeholderImage:kPlaceholderBannerImg()];
    }
    
}
-(void)setImageWithAnimate:(NSString *)imgUrl {
    self.alpha = .0;
    
    [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:URLImageWithUrlStr(imgUrl)  completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        
        [UIView animateWithDuration:0.4f animations:^{
            self.image = image;
            self.alpha = 1.f;
        }];
    }];
}
@end
