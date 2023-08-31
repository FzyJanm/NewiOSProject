//
//  JMBaseRequest.h
//  JMBaseProject
//
//  Created by Liuny on 2020/8/8.
//  Copyright © 2020 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JMRequestBaseViewController;
NS_ASSUME_NONNULL_BEGIN

typedef void(^FailBlock)(NSString *errorMsg);
typedef void(^SuccessBlock)( NSDictionary *_Nullable dataDic, NSArray *_Nullable dataArray);

@interface JMBaseRequest : NSObject
@property (nonatomic, weak) JMRequestBaseViewController *superVC;

+(JMBaseRequest *)sharedInstance;

/*
/// 初始化
/// @param superVC 使用接口的ViewController
-(instancetype)initWithSuperVC:(JMRequestBaseViewController *)superVC;
 */


/// Post请求
/// @param url 地址
/// @param params 参数
/// @param success 成功
/// @param fail 失败
-(void)requestBasePost:(NSString *)url
                params:(NSDictionary *)params
               success:(SuccessBlock _Nullable)success
                  fail:(FailBlock _Nullable)fail;


/// Post请求，转换成相应的model数据
/// @param url api地址
/// @param params 参数
/// @param modelName model类名
/// @param success 成功
/// @param fail 失败
-(void)requestModelBasePost:(NSString *)url
                     params:(NSDictionary *)params
                  modelName:(NSString *)modelName
                    success:(SuccessBlock)success
                       fail:(FailBlock)fail;

/// POST请求，转换成相应的model数组
/// @param url api地址
/// @param params 参数
/// @param modelName model类名
/// @param success 成功
/// @param fail 失败
-(void)requestListBasePost:(NSString *)url
                    params:(NSDictionary *)params
                 modelName:(NSString *)modelName
                   success:(SuccessBlock)success
                      fail:(FailBlock)fail;

/// POST表单上传图片
/// @param url api地址
/// @param params 参数
/// @param pictures 图片数据，key：图片data value：接口字段_名字
/// @param success 成功
/// @param fail 失败
-(void)requestUploadBasePost:(NSString *)url
                      params:(NSDictionary *)params
                    pictures:(NSDictionary<NSData *, NSString *> * _Nullable)pictures
                     success:(SuccessBlock)success
                        fail:(FailBlock)fail;
@end

NS_ASSUME_NONNULL_END
