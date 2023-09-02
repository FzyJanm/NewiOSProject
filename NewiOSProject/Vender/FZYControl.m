
//
//  FZYControl.m
//
//  Created by 范智渊 on 2016/8/27.
//  Copyright © 2018年 范智渊. All rights reserved.
//

#import "FZYControl.h"

@implementation FZYControl

#pragma mark ----  create Label  ----------
+ (UILabel *)createLabelWithFrame:(CGRect)frame
                             Font:(UIFont *)font
                             Text:(NSString *)text
                            color:(UIColor *)color
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];

    label.font = font;
    //单词折行
    label.lineBreakMode=NSLineBreakByWordWrapping;
    //默认字体颜色是白色
    label.textColor = color;
    //自适应（行数~字体大小按照设置大小进行设置）
    label.text = text;
    label.numberOfLines = 0;
    return label;
}
+(UILabel*)createLabelWithFrame:(CGRect)frame
                           Font:(UIFont*)font
                           Text:(NSString*)text
                          color:(UIColor*)color
                  textAlignment:(NSTextAlignment)alignment
                   numberOfLine:(NSInteger)num{
    UILabel *label = [self createLabelWithFrame:frame Font:font Text:text color:color];
    label.textAlignment = alignment;
    label.numberOfLines = num;
    label.numberOfLines = num;
    return label;
}
+(UILabel*)createAutoHeightLabelWithOrgin:(CGPoint)point andWidth:(CGFloat)width Font:(UIFont *)font Text:(NSString *)text color:(UIColor *)color
{
    UILabel *label = [self createLabelWithFrame:(CGRectMake(point.x, point.y, width, 1)) Font:font Text:text color:color];
    label.height = CalculateLabelHeight(width, font, text);
    label.numberOfLines = 0;
    return label;
}
+(UILabel*)createAutoWidthLabelWithOrgin:(CGPoint)point Font:(UIFont *)font Text:(NSString *)text color:(UIColor *)color;
{
    UILabel *label = [self createLabelWithFrame:(CGRectMake(point.x, point.y, 1, font.lineHeight)) Font:font Text:text color:color];
    CGFloat w = label.width = CalculateLabelWidth(font.lineHeight, font, text);
    if([font isBold]){
        w = CalculateLabelWidth(font.lineHeight, Font(font.pointSize+1), text);
    }
    label.numberOfLines = 0;
   
    return label;
}


#pragma mark ----  create UIButton  ----------

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                             Target:(id)target
                             Action:(SEL)action
                              Title:(NSString *)title
                          titlColor:(UIColor *)color
                               font:(UIFont *)textFont
                                tag:(NSInteger)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    button.titleLabel.font = textFont;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return button;
}

/** action title textFont  backgroudColor */
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                             Target:(id)target
                             Action:(SEL)action
                              Title:(NSString *)title
                          titlColor:(UIColor *)color
                               font:(UIFont *)textFont
                                tag:(NSInteger)tag
                    backgroundColor:(UIColor *)backgroudColor {
    UIButton *button = [self createButtonWithFrame:frame Target:target Action:action Title:title titlColor:color font:textFont tag:tag];
    button.backgroundColor = backgroudColor;
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame buttonTitleFont:(UIFont *)buttonTitleFont buttonTitle:(NSString *)buttonTitle {
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    button.titleLabel.font = buttonTitleFont;
    [button setTitle:buttonTitle forState:(UIControlStateNormal)];
    return button;
}

/** action imageName title */
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                          ImageName:(NSString *)imageName
                             Target:(id)target
                             Action:(SEL)action
                               font:(UIFont *)font
                              Title:(NSString *)title
{
    UIButton *button = [self createButtonWithFrame:frame ImageName:imageName selectedImage:imageName Target:target Action:action Title:title tag:0];
    button.titleLabel.font = font;
    return button;
}

/** imageName selected title selectedTitle color selectedColor action font bgColor*/
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                          ImageName:(NSString *)imageName
                      selectedImage:(NSString *)selected
                              Title:(NSString *)title
                      selectedTitle:(NSString *)selectedTitle
                         titleColor:(UIColor *)color
                 selectedTitleColor:(UIColor *)selectedColor
                             Target:(id)target
                             Action:(SEL)action
                          titleFont:(UIFont *)font
                    backgroundColor:(UIColor *)bgColor
                                tag:(NSInteger)tag {
    UIButton *button = [self createButtonWithFrame:frame ImageName:imageName selectedImage:selected Target:target Action:action Title:nil tag:tag];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitle:selectedTitle forState:(UIControlStateSelected)];
    [button setTitleColor:color forState:(UIControlStateNormal)];
    [button setTitleColor:selectedColor forState:(UIControlStateSelected)];
    button.titleLabel.font = font;
    button.backgroundColor = bgColor;

    return button;
}

/** imageName selected */

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                          ImageName:(NSString *)imageName
                      selectedImage:(NSString *)selected
                             Target:(id)target
                             Action:(SEL)action
                              Title:(NSString *)title
                                tag:(NSInteger)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    [button setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [button setTitle:title forState:UIControlStateNormal];
    //设置背景图片，可以使文字与图片共存
    if (imageName.length) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    }

    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                backgroundImageName:(NSString *)imageName
                      selectedImage:(NSString *)selected
                             Target:(id)target
                             Action:(SEL)action
                              Title:(NSString *)title
                                tag:(NSInteger)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    [button setTitleColor:UIColor.blackColor forState:(UIControlStateNormal)];
    [button setTitle:title forState:UIControlStateNormal];
    //设置背景图片，可以使文字与图片共存
    if (imageName.length) {
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    }

    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    return button;
}

/** font title titleColor backgorudColor */
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                    buttonTitleFont:(UIFont *)font
                        buttonTitle:(NSString *)title
                   buttonTitleColor:(UIColor *)titleColor
                     backgorudColor:(UIColor *)backgorudColor {
    UIButton *button = [self createButtonWithFrame:frame buttonTitleFont:font buttonTitle:title];
    [button setTitleColor:titleColor forState:(UIControlStateNormal)];
    button.backgroundColor = backgorudColor;
    return button;
}

/** font title titleColor backgorudColor borderColor borderWidth*/
+ (UIButton *)createButtonWithFrame:(CGRect)frame
                    buttonTitleFont:(UIFont *)font
                        buttonTitle:(NSString *)title
                   buttonTitleColor:(UIColor *)titleColor
                     backgorudColor:(UIColor *)backgorudColor
                        borderColor:(CGColorRef)borderColor
                        borderWidth:(CGFloat)borderWidth
                             action:(SEL)action
                             target:(id)target {
    UIButton *button = [self createButtonWithFrame:frame buttonTitleFont:font buttonTitle:title buttonTitleColor:titleColor backgorudColor:backgorudColor];
    button.layer.borderColor = borderColor;
    button.layer.borderWidth = borderWidth;
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    return button;
}

+ (UIButton *)createButtonWithFrame:(CGRect)frame
                        buttonImage:(NSString *)imageName {
    UIButton *button = [self createButtonWithFrame:frame];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}
+ (UIButton *)createButtonWithFrame:(CGRect)frame
              buttonBackgroundImage:(NSString *)imageName {
    UIButton *button = [self createButtonWithFrame:frame];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}
+ (UIButton *)createButtonWithFrame:(CGRect)frame buttonType:(UIButtonType)type buttonImageWithName:(NSString *)imageName Target:(id)target Action:(SEL)action {
    UIButton *button = [self createButtonWithFrame:frame];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];

    return button;
}
+(void)changeTextTraitWithLabel:(UILabel *)label changeStr:(NSString *)str font:(CGFloat )fontSize{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:label.text];

// 在界面上显示 label
    if (label.attributedText) {
        attr = label.attributedText.mutableCopy;
    }
    if (![label.text containsString:str]) {
        return;
    }
    //    attr.yy_lineSpacing = 5;
    NSRange range = [label.text rangeOfString:str];
    // 设置字体为斜体
    UIFont *italicFont = [UIFont italicSystemFontOfSize:fontSize];
    // 设置字体为加粗且斜体
//    UIFont *boldItalicFont = [UIFont fontWithName:@"Helvetica-BoldOblique" size:fontSize];
    [attr addAttribute:NSFontAttributeName value:italicFont range:range];
   
    label.attributedText = attr;
}
+(void)changeTextBoldAndTraitWithLabel:(UILabel *)label changeStr:(NSString *)str font:(CGFloat )fontSize{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:label.text];

// 在界面上显示 label
    if (label.attributedText) {
        attr = label.attributedText.mutableCopy;
    }
    if (![label.text containsString:str]) {
        return;
    }
    //    attr.yy_lineSpacing = 5;
    NSRange range = [label.text rangeOfString:str];
    // 设置字体为斜体
//    UIFont *italicFont = [UIFont italicSystemFontOfSize:fontSize];
    // 设置字体为加粗且斜体
    UIFont *boldItalicFont = [UIFont fontWithName:@"Helvetica-BoldOblique" size:fontSize];
    [attr addAttribute:NSFontAttributeName value:boldItalicFont range:range];
   
    label.attributedText = attr;
}
#pragma mark ----- 创建tableView -----
+ (UITableView *)createTableViewWithFrame:(CGRect)frame
                                    style:(UITableViewStyle)style
                               dataSource:(id<UITableViewDataSource>)dataSource
                                 delegate:(id<UITableViewDelegate>)delegate {
    UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:style];
    tableView.dataSource = dataSource;
    tableView.delegate = delegate;

    return tableView;
}

+ (UITableView *)createTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style
                           backgroudColor:(UIColor *)backgroudColor
                               dataSource:(id<UITableViewDataSource>)dataSource
                                 delegate:(id<UITableViewDelegate>)delegate {
    UITableView *tableView = [self createTableViewWithFrame:frame style:style dataSource:dataSource delegate:delegate];
    tableView.backgroundColor = backgroudColor;
    return tableView;
}

+ (UITableView *)createTableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style
                           backgroudColor:(UIColor *)backgroudColor
                               dataSource:(id<UITableViewDataSource>)dataSource
                                 delegate:(id<UITableViewDelegate>)delegate
                           separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle {
    UITableView *tableView = [self createTableViewWithFrame:frame style:style backgroudColor:backgroudColor dataSource:dataSource delegate:delegate];
    tableView.separatorStyle = separatorStyle;

    return tableView;
}

#pragma mark ----- 创建UICollectionView -----
+ (UICollectionView *)createCollectionViewFromFrame:(CGRect)frame
                                           itmeSize:(CGSize)itmeSize
                                       sectionInset:(UIEdgeInsets)sectionInset
                                 minimumLineSpacing:(CGFloat)minimumLineSpacing
                            minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
                                    scrollDirection:(UICollectionViewScrollDirection)scrollDirection
                                         dataSource:(id<UICollectionViewDataSource>)dataSource
                                           delegate:(id<UICollectionViewDelegate>)delegate
                                     backgroudColor:(UIColor *)backgroudColor {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = itmeSize;
    layout.sectionInset = sectionInset;
    layout.minimumLineSpacing = minimumLineSpacing;
    layout.minimumInteritemSpacing = minimumInteritemSpacing;
    layout.scrollDirection = scrollDirection;

    UICollectionView *view = [self createCollectionViewFromFrame:frame collectionViewLayout:layout dataSource:dataSource delegate:delegate];
    view.backgroundColor = backgroudColor;
    [view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];

    return view;
}

+ (UICollectionView *)createCollectionViewFromFrame:(CGRect)frame
                                           itmeSize:(CGSize)itmeSize
                                       sectionInset:(UIEdgeInsets)sectionInset
                                 minimumLineSpacing:(CGFloat)minimumLineSpacing
                            minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing
                                    scrollDirection:(UICollectionViewScrollDirection)scrollDirection
                                         dataSource:(id<UICollectionViewDataSource>)dataSource
                                           delegate:(id<UICollectionViewDelegate>)delegate
                                     backgroudColor:(UIColor *)backgroudColor
                              headerReuseIdentifier:(NSString *)headerReuseIdentifier
                              footerReuseIdentifier:(NSString *)footerReuseIdentifier {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = itmeSize;
    layout.sectionInset = sectionInset;
    layout.minimumLineSpacing = minimumLineSpacing;
    layout.minimumInteritemSpacing = minimumInteritemSpacing;
    layout.scrollDirection = scrollDirection;

    UICollectionView *view = [self createCollectionViewFromFrame:frame collectionViewLayout:layout dataSource:dataSource delegate:delegate];
    view.backgroundColor = backgroudColor;
    [view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [view registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
    [view registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerReuseIdentifier];
    return view;
}

+ (UICollectionView *)createCollectionViewFromFrame:(CGRect)frame
                               collectionViewLayout:(UICollectionViewLayout *)layout
                                         dataSource:(id<UICollectionViewDataSource>)dataSource
                                           delegate:(id<UICollectionViewDelegate>)delegate {
    UICollectionView *colltionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    colltionView.delegate = delegate;
    colltionView.dataSource = dataSource;

    return colltionView;
}

+ (UICollectionView *)createCollectionViewFromFrame:(CGRect)frame
                               collectionViewLayout:(UICollectionViewLayout *)layout
                                         dataSource:(id<UICollectionViewDataSource>)dataSource
                                           delegate:(id<UICollectionViewDelegate>)delegate
                                     backgroudColor:(UIColor *)backgroudColor {
    UICollectionView *collectionView = [self createCollectionViewFromFrame:frame collectionViewLayout:layout dataSource:dataSource delegate:delegate];
    collectionView.backgroundColor = backgroudColor;

    return collectionView;
}

#pragma----- UIImageView部分  --------

//创建并返回一个UIImageview,设置大小和图片
+ (UIImageView *)createImageViewWithFrame:(CGRect)frame ImageName:(NSString *)imageName
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    if (imageName.length) {
        imageView.image = [UIImage imageNamed:imageName];
    }
//    imageView.userInteractionEnabled=YES;
    return imageView;
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame ImageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode {
    UIImageView *imageView = [self createImageViewWithFrame:frame ImageName:imageName];
    imageView.contentMode = contentMode;

    return imageView;
}

+ (UIImageView *)createImageViewWithFrame:(CGRect)frame ImageName:(NSString *)imageName imageTagValue:(NSInteger)tag {
    UIImageView *imageView = [self createImageViewWithFrame:frame ImageName:imageName];
    imageView.tag = tag;

    return imageView;
}

#pragma-----  UIView部分   --------

+ (UIView *)viewWithFrame:(CGRect)frame {
    UIView *view = [[UIView alloc]initWithFrame:frame];
    return view;
}

+ (UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color {
    UIView *view = [FZYControl viewWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

+ (UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color borderColor:(CGColorRef)borderColor borderWidth:(CGFloat)borderWidth {
    UIView *view = [self viewWithFrame:frame backgroundColor:color];
    view.layer.borderColor = borderColor;
    view.layer.borderWidth = borderWidth;

    return view;
}

+ (UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color viewTagValue:(NSInteger)tag {
    UIView *view = [FZYControl viewWithFrame:frame backgroundColor:color];
    view.tag = tag;
    return view;
}

#pragma mark ----- UITextField部分 -------
+ (UITextField *__nonnull)creatTextfieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder textfieldTextFont:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.font = font;
    textField.textAlignment = textAlignment;
    return textField;
}

+ (UITextField *)creatTextfieldWithFrame:(CGRect)frame
                             placeholder:(NSString *)placeholder
                                delegate:(id<UITextFieldDelegate>)delegate
                       textfieldTextFont:(UIFont *)font
                         clearButtonMode:(UITextFieldViewMode)clearButtonMode {
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.delegate = delegate;
    textField.placeholder = placeholder;
    textField.font = font;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;

    if ([placeholder containsString:@"手机号"]  || [placeholder containsString:@"联系方式"] || [placeholder containsString:@"联系电话"]) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
//        [textField limitText:@(20)];
    }
    if ([placeholder containsString:@"验证码"]) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
//        [textField limitText:@(6)];
    }
    if ([placeholder containsString:@"密码"]) {
        textField.secureTextEntry = YES;
        textField.keyboardType = UIKeyboardTypeURL;
//        [textField limitText:@(20)];
    }
    if ([placeholder containsString:@"邮箱"]) {
        textField.keyboardType = UIKeyboardTypeURL;
//        [textField limitText:@(30)];
    }

    if ([placeholder containsString:@"银行卡号"]) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
//        [textField limitText:@(19)];
    }
    if ([placeholder containsString:@"姓名"]) {
//        textField.keyboardType = UIReturnKeyDefault;
//        [textField limitText:@(20)];
    }
//

    return textField;
}

+ (UITextField *)creatTextfieldWithFrame:(CGRect)frame
                             placeholder:(NSString *)placeholder
                                delegate:(id<UITextFieldDelegate>)delegate
                       textfieldTextFont:(UIFont *)font
                         clearButtonMode:(UITextFieldViewMode)clearButtonMode
                            keyboardType:(UIKeyboardType)keyboardType {
    UITextField *textField = [self creatTextfieldWithFrame:frame placeholder:placeholder delegate:delegate textfieldTextFont:font clearButtonMode:clearButtonMode];
    return textField;
}

+ (UITextField *)creatTextfieldWithFrame:(CGRect)frame
                             placeholder:(NSString *)placeholder
                                delegate:(id<UITextFieldDelegate>)delegate
                       textfieldTextFont:(UIFont *)font
                         clearButtonMode:(UITextFieldViewMode)clearButtonMode
                            keyboardType:(UIKeyboardType)keyboardType
                               textColor:(UIColor *)color {
    UITextField *textField = [self creatTextfieldWithFrame:frame placeholder:placeholder delegate:delegate textfieldTextFont:font clearButtonMode:clearButtonMode keyboardType:keyboardType];
    textField.textColor = color;
    return textField;
}

+ (UITextField *)creatTextfieldWithFrame:(CGRect)frame
                             placeholder:(NSString *)placeholder
                                delegate:(id<UITextFieldDelegate>)delegate
                       textfieldTextFont:(UIFont *)font
                         clearButtonMode:(UITextFieldViewMode)clearButtonMode
                            keyboardType:(UIKeyboardType)keyboardType
                               textColor:(UIColor *)color
                        placeholderColor:(UIColor *)placeholderColor
                         bottomLineColor:(UIColor *)LineColor
                                isSecret:(BOOL)secret
{
    return nil;
}

+ (UITextField *)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView *)imageView rightImageView:(UIImageView *)rightImageView Font:(float)font
{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    //灰色提示框
    textField.placeholder = placeholder;
    //文字对齐方式
    textField.textAlignment = NSTextAlignmentLeft;
    textField.secureTextEntry = YESorNO;
    //边框
    //textField.borderStyle=UITextBorderStyleLine;
    //键盘类型
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    //关闭首字母大写
    textField.autocapitalizationType = NO;
    //清除按钮
    textField.clearButtonMode = YES;
    //左图片
    textField.leftView = imageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    //右图片
    textField.rightView = rightImageView;
    //编辑状态下一直存在
    textField.rightViewMode = UITextFieldViewModeAlways;
    //自定义键盘
    //textField.inputView
    //字体
    textField.font = [UIFont systemFontOfSize:font];
    //字体颜色
    textField.textColor = [UIColor blackColor];

    return textField;
}

#pragma mark 适配器方法
+ (UITextField *)createTextFieldWithFrame:(CGRect)frame
                              placeholder:(NSString *)placeholder
                                 passWord:(BOOL)YESorNO
                            leftImageView:(UIImageView *)imageView
                           rightImageView:(UIImageView *)rightImageView
                                     Font:(float)font
                      backgRoundImageName:(NSString *)imageName
{
    UITextField *text = [self createTextFieldWithFrame:frame placeholder:placeholder passWord:YESorNO leftImageView:imageView rightImageView:rightImageView Font:font];
    if (imageName) {
        text.background = [UIImage imageNamed:imageName];
    }
    return text;
}

+ (UIScrollView *)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];

    scrollView.pagingEnabled = YES;
    scrollView.contentSize = size;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    return scrollView;
}

+ (UIPageControl *)makePageControlWithFram:(CGRect)frame
{
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:frame];
    pageControl.numberOfPages = 2;
    pageControl.currentPage = 0;
    return pageControl;
}

+ (UISlider *)makeSliderWithFrame:(CGRect)rect AndImage:(UIImage *)image
{
    UISlider *slider = [[UISlider alloc]initWithFrame:rect];
    slider.minimumValue = 0;
    slider.maximumValue = 1;
    [slider setThumbImage:[UIImage imageNamed:@"qiu"] forState:UIControlStateNormal];
    slider.maximumTrackTintColor = [UIColor grayColor];
    slider.minimumTrackTintColor = [UIColor yellowColor];
    slider.continuous = YES;
    slider.enabled = YES;
    return slider;
}

+ (NSString *)stringFromDateWithHourAndMinute:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];

    return destDateString;
}

#pragma mark 内涵图需要的方法
+ (NSString *)stringDateWithTimeInterval:(NSString *)timeInterval
{
    NSTimeInterval seconds = [timeInterval integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [format stringFromDate:date];
}

+ (CGFloat)textHeightWithString:(NSString *)text width:(CGFloat)width fontSize:(NSInteger)fontSize
{
    NSDictionary *dict = @{ NSFontAttributeName: [UIFont systemFontOfSize:fontSize] };
    // 根据第一个参数的文本内容，使用280*float最大值的大小，使用系统14号字，返回一个真实的frame size : (280*xxx)!!
    CGRect frame = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height + 5;
}

// 返回一个整数字符串加1后的新字符串
+ (NSString *)addOneByIntegerString:(NSString *)integerString
{
    NSInteger integer = [integerString integerValue];
    return [NSString stringWithFormat:@"%ld", integer + 1];
}

+ (void)changeTextFontWithLabel:(UILabel *)label changeStr:(NSString *)str font:(UIFont *)font {
    if (label==nil) {
        return;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:label.text];
    if (label.attributedText) {
        attr = label.attributedText.mutableCopy;
    }
    if (![label.text containsString:str]) {
        return;
    }
//    attr.yy_lineSpacing = 5;
    NSRange range = [label.text rangeOfString:str];
    [attr addAttribute:NSFontAttributeName value:font range:range];
    label.attributedText = attr;
}

+ (void)changeTextColorWithLabel:(UILabel *)label changeStr:(NSString *)str color:(UIColor *)color {
    if (label==nil) {
        return;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:label.text];
    if (label.attributedText) {
        attr = label.attributedText.mutableCopy;
    }
    if (![label.text containsString:str]) {
        return;
    }
    NSRange range = [label.text rangeOfString:str];
    [attr addAttribute:NSForegroundColorAttributeName value:color range:range];
    label.attributedText = attr;
}

+ (void)addUnderLineWithLabel:(UILabel *)label changeStr:(NSString *)str {
    if (label==nil) {
        return;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:label.text];
    if (label.attributedText) {
        attr = label.attributedText.mutableCopy;
    }
    if (![label.text containsString:str]) {
        return;
    }
    NSRange range = [label.text rangeOfString:str];
    [attr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:range];
    label.attributedText = attr;
}

+ (void)addUnderLineWithLabel:(UILabel *)label changeStr:(NSString *)str andFont:(UIFont *)font {
    if (label==nil) {
        return;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:label.text];
    if (label.attributedText) {
        attr = label.attributedText.mutableCopy;
    }
    if (![label.text containsString:str]) {
        return;
    }

    NSRange range = [label.text rangeOfString:str];
    [attr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:range];
    [attr addAttribute:NSForegroundColorAttributeName value:Text_COLOR_LEVEL3() range:range];

    [attr addAttribute:NSFontAttributeName value:font range:range];
    label.attributedText = attr;
}

+ (void)addUnderLineWithLabel:(UILabel *)label range:(NSRange)range andFont:(UIFont *)font {
    if (label==nil) {
        return;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:label.text];
    if (label.attributedText) {
        attr = label.attributedText.mutableCopy;
    }


    [attr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:range];
    [attr addAttribute:NSForegroundColorAttributeName value:Text_COLOR_LEVEL3() range:range];

    [attr addAttribute:NSFontAttributeName value:font range:range];
    label.attributedText = attr;
}

+ (void)changeTextColorWithLabel:(UILabel *)label range:(NSRange)range color:(UIColor *)color {
    if (label==nil) {
        return;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:label.text];
    if (label.attributedText) {
        attr = label.attributedText.mutableCopy;
    }
   
    if (range.location + range.length > label.text.length) {
        NSLog(@"range越界 -- %@,%ld,%ld", label.text, range.location, range.length);
        return;
    }
    [attr addAttribute:NSForegroundColorAttributeName value:color range:range];
    label.attributedText = attr;
}

+ (void)changeTextFontWithLabel:(UILabel *)label range:(NSRange)range font:(UIFont *)font {
    if (label==nil) {
        return;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:label.text];
    if (label.attributedText) {
        attr = label.attributedText.mutableCopy;
    }
    if (range.location + range.length > label.text.length) {
        NSLog(@"range越界 -- %@,%ld,%ld", label.text, range.location, range.length);
        return;
    }
    [attr addAttribute:NSFontAttributeName value:font range:range];
    label.attributedText = attr;
}
    
+(void)changeTextWithLabel:(UILabel *)label changeStr:(NSString *)str font:(UIFont *)font andColor:(UIColor *)color {
    if (label==nil) {
        return;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:label.text];
    if (label.attributedText) {
        attr = label.attributedText.mutableCopy;
    }
    if (![label.text containsString:str]) {
        return;
    }
    NSRange range = [label.text rangeOfString:str];
    [attr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attr addAttribute:NSFontAttributeName value:font range:range];
    label.attributedText = attr;
}

+ (void)changeTextFontWithLabel:(UILabel *)label changeStrings:(NSArray<NSString *> *)strings font:(UIFont *)font {
    if (label==nil) {
        return;
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:label.text];
    if (label.attributedText) {
        attr = label.attributedText.mutableCopy;
    }
    
    for (NSString *str in strings) {
        NSRange range = [label.text rangeOfString:str];
        [attr addAttribute:NSFontAttributeName value:font range:range];
    }

    label.attributedText = attr;
}

// label 高度
+(CGFloat)loadDynamicLabelHeightWithLabel:(UILabel *)lab
{
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    lab.numberOfLines = 0;
    NSDictionary *attributes = @{NSFontAttributeName:lab.font};
    CGSize size = [lab.text boundingRectWithSize:CGSizeMake(lab.frame.size.width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.height;
}

// label 宽度
+(CGFloat)loadDynamicLabelWidthWithLabel:(UILabel *)lab
{
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    lab.numberOfLines = 1;
    NSDictionary *attributes = @{NSFontAttributeName:lab.font};
    CGSize size = [lab.text boundingRectWithSize:CGSizeMake(MAXFLOAT,lab.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size.width;
}

+(UIView *)addHorLineWithSpace:(CGFloat)leftAndRightSpace top:(CGFloat)top height:(CGFloat)h bgColor:(UIColor *)color toView:(UIView *)superView{
    UIView *line = [[UIView alloc]initWithFrame:(CGRectMake(leftAndRightSpace, top,superView.width-leftAndRightSpace*2, h))];
    line.backgroundColor = color;
    [superView addSubview:line];
    return line;
}
+ (UIView *)addHorLineWithSpaceWithDefaultColor:(CGFloat)leftAndRightSpace top:(CGFloat)top height:(CGFloat)h toView:(UIView *)superView{
    UIView *line = [[UIView alloc]initWithFrame:(CGRectMake(leftAndRightSpace, top,superView.width-leftAndRightSpace*2, h))];
    line.backgroundColor = kColorSeparator;
    [superView addSubview:line];
    return line;
}
+(UIView *)addHorLineWithLeftSpace:(CGFloat)leftSpace top:(CGFloat)top andRightSpace:(CGFloat)rightSpace height:(CGFloat)h bgColor:(UIColor *)color toView:(UIView *)superView{
    UIView *line = [[UIView alloc]initWithFrame:(CGRectMake(leftSpace, top,superView.width-leftSpace-rightSpace, h))];
    line.backgroundColor = kColorSeparator;
    [superView addSubview:line];
    return line;
}
@end

