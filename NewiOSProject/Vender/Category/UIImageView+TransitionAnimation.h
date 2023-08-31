//
//  UIImageView+TransitionAnimation.h
//  buymore
//
//  Created by apple on 2020/5/26.
//  Copyright © 2020 JLC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (TransitionAnimation)
- (void)animatedChangeToImage:(UIImage *)img;
- (void)setImageUrl:(NSString *)imgUrl;
-(void)setImageWithAnimate:(NSString *)imgUrl ;
@end

NS_ASSUME_NONNULL_END
