//
//  FZYControl.h
//
//  Created by 范智渊 on 2016/8/27.
//  Copyright © 2018年 范智渊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FZYControl : NSObject
NS_ASSUME_NONNULL_BEGIN
#pragma mark --创建Label

+(UILabel*)createAutoHeightLabelWithOrgin:(CGPoint)point
                                 andWidth:(CGFloat)width
                                     Font:(UIFont*)font
                                     Text:(NSString*)text
                                    color:(UIColor*)color;

+(UILabel*)createAutoWidthLabelWithOrgin:(CGPoint)point
                                     Font:(UIFont*)font
                                     Text:(NSString*)text
                                   color:(UIColor*)color;

+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             Font:(UIFont *)font
                             Text:(NSString *)text
                            color:(UIColor *)color;

+(UILabel*)createLabelWithFrame:(CGRect)frame
                           Font:(UIFont*)font
                           Text:(NSString*)text
                          color:(UIColor*)color
                  textAlignment:(NSTextAlignment)alignment
                   numberOfLine:(NSInteger)num;

#pragma mark --创建View

+(UIView*)viewWithFrame:(CGRect)frame;
+(UIView*)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;
+(UIView*)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color borderColor:(CGColorRef )borderColor borderWidth:(CGFloat)borderWidth ;
+(UIView*)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color viewTagValue:(NSInteger)tag;

#pragma mark --创建imageView

+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName;
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName contentMode:(UIViewContentMode)contentMode;
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName imageTagValue:(NSInteger)tag;


#pragma mark --创建button

/** imageName selected action  title selectedTitle titleColor selectedColor font backgroudColor*/
+(UIButton*)createButtonWithFrame:(CGRect)frame
                        ImageName:(NSString*)imageName
                    selectedImage:(NSString *)selected
                            Title:(NSString*)title
                    selectedTitle:(NSString *)selectedTitle
                       titleColor:(UIColor *)color
               selectedTitleColor:(UIColor *)selectedColor
                           Target:(id)target
                           Action:(SEL)action
                        titleFont:(UIFont *)font
                  backgroundColor:(UIColor *)bgColor
                              tag:(NSInteger)tag;

+(UIButton*)createButtonWithFrame:(CGRect)frame
              backgroundImageName:(NSString*)imageName
                    selectedImage:(NSString *)selected
                           Target:(id)target
                           Action:(SEL)action
                            Title:(NSString*)title
                              tag:(NSInteger)tag;
/** action  title titleColor font backgroudColor*/
+(UIButton*)createButtonWithFrame:(CGRect)frame
                           Target:(id)target
                           Action:(SEL)action
                            Title:(NSString*)title
                        titlColor:(UIColor *)color
                             font:(UIFont *)textFont
                              tag:(NSInteger)tag
                  backgroundColor:(UIColor *)backgroudColor;

/** action  title imageName font */
+(UIButton*)createButtonWithFrame:(CGRect)frame
                        ImageName:(NSString*)imageName
                           Target:(id)target
                           Action:(SEL)action
                             font:(UIFont *)font
                            Title:(NSString*)title;

/** action  title imageName selected font */
+(UIButton*)createButtonWithFrame:(CGRect)frame
                        ImageName:(NSString*)imageName
                    selectedImage:(NSString *)selected
                           Target:(id)target
                           Action:(SEL)action
                            Title:(NSString*)title
                              tag:(NSInteger)tag;

/**  title imageName selected font action backgorudColor  borderColor borderWidth*/
+(UIButton *)createButtonWithFrame:(CGRect)frame
                   buttonTitleFont:(UIFont *)font
                       buttonTitle:(NSString *)title
                  buttonTitleColor:(UIColor *)titleColor
                    backgorudColor:(UIColor *)backgorudColor
                       borderColor:(CGColorRef)borderColor
                       borderWidth:(CGFloat)borderWidth
                            action:(SEL)action
                            target:(id)target;

+(UIButton *)createButtonWithFrame:(CGRect)frame;

+(UIButton *)createButtonWithFrame:(CGRect)frame
                       buttonImage:(NSString *)imageName;
+(UIButton *)createButtonWithFrame:(CGRect)frame
             buttonBackgroundImage:(NSString *)imageName;

+(UIButton *)createButtonWithFrame:(CGRect)frame buttonTitleFont:(UIFont *)buttonTitleFont buttonTitle:(NSString *)buttonTitle;


///9月17日 新增
+(UIButton *)createButtonWithFrame:(CGRect)frame
                        buttonType:(UIButtonType)type
               buttonImageWithName:(NSString *)imageName
                            Target:(id)target
                            Action:(SEL)action;

#pragma mark ----- 创建tableView -----
+(UITableView *)createTableViewWithFrame:(CGRect)frame
                                   style:(UITableViewStyle)style
                              dataSource:(id<UITableViewDataSource>)dataSource
                                delegate:(id<UITableViewDelegate>)delegate;


+(UITableView *)createTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style
                          backgroudColor:(UIColor *)backgroudColor
                              dataSource:(id<UITableViewDataSource>)dataSource
                                delegate:(id<UITableViewDelegate>)delegate;


+(UITableView *)createTableViewWithFrame:(CGRect)frame
                                   style:(UITableViewStyle)style
                          backgroudColor:(UIColor *)backgroudColor
                              dataSource:(id<UITableViewDataSource>)dataSource
                                delegate:(id<UITableViewDelegate>)delegate
                          separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle;

//**
// *   处理 cell上 textfield或者 textView键盘弹出问题
// *
// *   @param frame
// *   @param style
// *   @param backgroudColor
// *   @param dataSource
// *   @param delegate
// *   @param separatorStyle
// *
// *   @return
// */

#pragma mark ----- 创建UICollectionView -----


//+(UICollectionView *)createCollectionViewFromFrame:(CGRect)frame
//                              collectionViewLayout:(UICollectionViewLayout *)layout
//                                        dataSource:(id<UICollectionViewDataSource>)dataSource
//                                          delegate:(id<UICollectionViewDelegate>)delegate ;
//
//+(UICollectionView *)createCollectionViewFromFrame:(CGRect)frame
//                              collectionViewLayout:(UICollectionViewLayout *)layout
//                                        dataSource:(id<UICollectionViewDataSource>)dataSource
//                                          delegate:(id<UICollectionViewDelegate>)delegate
//                                    backgroudColor:(UIColor *)backgroudColor;

+(UICollectionView *)createCollectionViewFromFrame:(CGRect)frame
                                          itmeSize:(CGSize)itmeSize
                                      sectionInset:(UIEdgeInsets)sectionInset
                                minimumLineSpacing:(CGFloat)minimumLineSpacing
                           minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
                                   scrollDirection:(UICollectionViewScrollDirection)scrollDirection
                                        dataSource:(id<UICollectionViewDataSource>)dataSource
                                          delegate:(id<UICollectionViewDelegate>)delegate
                                    backgroudColor:(UIColor *)backgroudColor;

+(UICollectionView *)createCollectionViewFromFrame:(CGRect)frame
                                          itmeSize:(CGSize)itmeSize
                                      sectionInset:(UIEdgeInsets)sectionInset
                                minimumLineSpacing:(CGFloat)minimumLineSpacing
                           minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
                                   scrollDirection:(UICollectionViewScrollDirection)scrollDirection
                                        dataSource:(id<UICollectionViewDataSource>)dataSource
                                          delegate:(id<UICollectionViewDelegate>)delegate
                                    backgroudColor:(UIColor *)backgroudColor
                             headerReuseIdentifier:(NSString *)headerReuseIdentifier
                             footerReuseIdentifier:(NSString *)footerReuseIdentifier;
#pragma mark --创建UITextField

+ (UITextField *__nonnull)creatTextfieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder textfieldTextFont:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

+(UITextField *)creatTextfieldWithFrame:(CGRect)frame
                            placeholder:(NSString*)placeholder
                               delegate:(id<UITextFieldDelegate>)delegate
                      textfieldTextFont:(UIFont *)font
                        clearButtonMode:(UITextFieldViewMode)clearButtonMode;
//
//
//+(UITextField *)creatTextfieldWithFrame:(CGRect)frame
//                            placeholder:(NSString*)placeholder
//                               delegate:(id<UITextFieldDelegate>)delegate
//                      textfieldTextFont:(UIFont *)font
//                        clearButtonMode:(UITextFieldViewMode)clearButtonMode
//                           keyboardType:(UIKeyboardType)keyboardType;
//
//
//+(UITextField *)creatTextfieldWithFrame:(CGRect)frame
//                            placeholder:(NSString*)placeholder
//                               delegate:(id<UITextFieldDelegate>)delegate
//                      textfieldTextFont:(UIFont *)font
//                        clearButtonMode:(UITextFieldViewMode)clearButtonMode
//                           keyboardType:(UIKeyboardType)keyboardType
//                              textColor:(UIColor *)color;
//
//
//+(UITextField*)createTextFieldWithFrame:(CGRect)frame
//                            placeholder:(NSString*)placeholder
//                               passWord:(BOOL)YESorNO
//                          leftImageView:(UIImageView*)imageView
//                         rightImageView:(UIImageView*)rightImageView
//                                   Font:(float)font;
//
//
//
////适配器的方法  扩展性方法
////现有方法，已经在工程里面存在，如果修改工程内所有方法，工作量巨大，就需要使用适配器的方法
//+(UITextField*)createTextFieldWithFrame:(CGRect)frame
//                            placeholder:(NSString*)placeholder
//                               passWord:(BOOL)YESorNO
//                          leftImageView:(UIImageView*)imageView
//                         rightImageView:(UIImageView*)rightImageView
//                                   Font:(float)font backgRoundImageName:(NSString*)imageName;

#pragma mark 创建UIScrollView
+(UIScrollView*)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size;

#pragma mark 创建UIPageControl
+(UIPageControl*)makePageControlWithFram:(CGRect)frame;

#pragma mark 创建UISlider
+(UISlider*)makeSliderWithFrame:(CGRect)rect AndImage:(UIImage*)image;

#pragma mark 创建时间转换字符串
+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date;

#pragma mark --判断导航的高度64or44

#pragma mark 内涵图需要的方法
+ (NSString *)stringDateWithTimeInterval:(NSString *)timeInterval;

+ (CGFloat)textHeightWithString:(NSString *)text width:(CGFloat)width fontSize:(NSInteger)fontSize;

+ (NSString *)addOneByIntegerString:(NSString *)integerString;


+(void)changeTextColorWithLabel:(UILabel*)label changeStr:(NSString *)str color:(UIColor *)color;
+(void)changeTextColorWithLabel:(UILabel *)label range:(NSRange)range color:(UIColor *)color;

+(void)changeTextFontWithLabel:(UILabel*)label range:(NSRange)range font:(UIFont *)font;
+(void)changeTextFontWithLabel:(UILabel*)label changeStr:(NSString *)str font:(UIFont *)font;
+(void)changeTextWithLabel:(UILabel*)label changeStr:(NSString *)str font:(UIFont *)font andColor:(UIColor *)color;
+(void)changeTextFontWithLabel:(UILabel*)label changeStrings:(NSArray <NSString*>*)strings font:(UIFont *)font;


+(void)changeTextTraitWithLabel:(UILabel*)label range:(NSRange)range font:(CGFloat )fontSize;
+(void)changeTextTraitWithLabel:(UILabel *)label changeStr:(NSString *)str font:(CGFloat )fontSize;

+(void)changeTextBoldAndTraitWithLabel:(UILabel *)label changeStr:(NSString *)str font:(CGFloat )fontSize;

+(void)addUnderLineWithLabel:(UILabel *)label range:(NSRange)range andFont:(UIFont *)font;
+(void)addUnderLineWithLabel:(UILabel *)label changeStr:(NSString *)str andFont:(UIFont *)font;
+(void)addUnderLineWithLabel:(UILabel *)label changeStr:(NSString *)str;


///动态获取label的高  9月17日新增
+(CGFloat)loadDynamicLabelHeightWithLabel:(UILabel *)lab;
///动态获取label的宽  9月17日新增
+(CGFloat)loadDynamicLabelWidthWithLabel:(UILabel *)lab;


+(UIView *)addHorLineWithSpaceWithDefaultColor:(CGFloat)leftAndRightSpace top:(CGFloat)top height:(CGFloat)h toView:(UIView *)superView;
+(UIView *)addHorLineWithSpace:(CGFloat)leftAndRightSpace top:(CGFloat)top  height:(CGFloat)h bgColor:(UIColor *)color toView:(UIView *)superView;
+(UIView *)addHorLineWithLeftSpace:(CGFloat)leftSpace top:(CGFloat)top  andRightSpace:(CGFloat)rightSpace height:(CGFloat)h bgColor:(UIColor *)color toView:(UIView *)superView;


@end
NS_ASSUME_NONNULL_END
