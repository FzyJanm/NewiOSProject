//
//  EAIntroView.h
//  EAIntroView
//
//  Copyright (c) 2013 Evgeny Aleksandrov.
//

#import <UIKit/UIKit.h>
#import "EAIntroPage.h"

@protocol EAIntroDelegate
@optional
- (void)introDidFinish;
@end
typedef void (^CYCscrollerViewBlock)(void);

@interface EAIntroView : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) id<EAIntroDelegate> delegate;

// titleView Y position - from top of the screen
// pageControl Y position - from bottom of the screen
@property (nonatomic, assign) bool swipeToExit;
@property (nonatomic, assign) bool hideOffscreenPages;
@property (nonatomic, retain) UIImage *bgImage;
@property (nonatomic, retain) UIView *titleView;
@property (nonatomic, assign) CGFloat titleViewY;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat pageControlY;
@property (nonatomic, retain) UIButton *skipButton;

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UIImageView *pageBgBack;
@property (nonatomic, retain) UIImageView *pageBgFront;
@property (nonatomic, retain) NSArray *pages;

@property (nonatomic,copy )CYCscrollerViewBlock scrollerViewBlock ;

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray;
- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray animationDuration:(NSTimeInterval)animationDuration;

- (void)showInView:(UIView *)view animateDuration:(CGFloat)duration;
- (void)hideWithFadeOutDuration:(CGFloat)duration;
- (void)skipIntroduction;
@end
