//
//  FZYPublicAlertView.h
//  NewiOSProject
//
//  Created by MAC on 2023/9/1.
//  Copyright © 2023 范智渊. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, FZYPublicAlertViewPosition) {
    FZYPublicAlertViewPositionCenter,
    FZYPublicAlertViewPositionBottom,
};
typedef NS_ENUM(NSInteger, FZYPublicAlertViewButtonDirection) {
    FZYPublicAlertViewButtonDirectionHor,
    FZYPublicAlertViewButtonDirectionVer,
};


NS_ASSUME_NONNULL_BEGIN
@protocol FZYPublicAlertViewDelegate<NSObject>
- (void)didClickBtnAtIndex:(NSInteger)index;

@optional
- (void)coverViewDidClick;
@end






@interface FZYPublicAlertView : UIView

-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title titleTop:(CGFloat)top;

//点击空白是否能消失
@property(nonatomic,assign)BOOL canDismiss;

@property(nonatomic)UILabel *titleLab;
@property(nonatomic)UIImageView *topImgV;
@property (nonatomic,weak)id<FZYPublicAlertViewDelegate>delegate;
-(void)setTopBgImageWithImgName:(NSString *)imgName;
-(void)showAlertWithPosition:(FZYPublicAlertViewPosition)position bottomBtns:(NSArray *)btnTitles;
-(void)showAlertWithPosition:(FZYPublicAlertViewPosition)position bottomBtns:(NSArray *)btnTitles btnDirect:(FZYPublicAlertViewButtonDirection)direction;
@end

NS_ASSUME_NONNULL_END
