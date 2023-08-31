//
//  JMBaseRequest.m
//  JMBaseProject
//
//  Created by Liuny on 2020/8/8.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "JMBaseRequest.h"

@interface JMBaseRequest ()

@end

@implementation JMBaseRequest

+(JMBaseRequest *)sharedInstance{
    static JMBaseRequest *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

-(id)copyWithZone:(NSZone *)zone{
    return self;
}

/*
/// 初始化
/// @param superVC 使用接口的ViewController
-(instancetype)initWithSuperVC:(JMRequestBaseViewController *)superVC{
    self = [super init];
    if(self){
        self.superVC = superVC;
        self.superVC.request = self;
    }
    return self;
}
 */

/// Post请求
/// @param url 地址
/// @param params 参数
/// @param success 成功
/// @param fail 失败
-(void)requestBasePost:(NSString *)url
                params:(NSDictionary *)params
               success:(SuccessBlock)success
                  fail:(FailBlock)fail{
    NSMutableDictionary *para = [JMCommonMethod baseRequestParams];
    if(params==nil){
        params = para;
    }

    [[JMRequestManager sharedManager] POST:url parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            if(response.statusCode!=2){
                [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
            }
            if(fail){
                fail(response.errorMsg);
            }
        }else{
            if(success){
                NSDictionary *dataDic = response.responseObject[@"data"];
                success(dataDic,nil);
            }
        }
    }];
}

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
                       fail:(FailBlock)fail{
    [[JMRequestManager sharedManager] POST:url parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
            if(fail){
                fail(response.errorMsg);
            }
        }else{
            if(success){
                NSDictionary *dataDic = response.responseObject[@"data"];
                if([dataDic isKindOfClass:[NSDictionary class]]){
                    if(JMIsEmpty(modelName)){
                        success(response.responseObject, nil);
                    }else{
                        Class class = NSClassFromString(modelName);
                        JMBaseModel *model = [[class alloc] initWithDictionary:dataDic];
                        success(dataDic, @[model]);
                    }
                }else{
                    success(response.responseObject, nil);
                }
            }
        }
    }];
}

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
                      fail:(FailBlock)fail{
    [[JMRequestManager sharedManager] POST:url parameters:params completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
            if(fail){
                fail(response.errorMsg);
            }
        }else{
            if(success){
                id dataDic = response.responseObject[@"data"];
                if([dataDic isKindOfClass:[NSDictionary class]]){
                    //data是字典类型
                    if(JMIsEmpty(modelName)){
                        success(response.responseObject, nil);
                    }else{
                        NSMutableArray *array = [[NSMutableArray alloc] init];
                        NSArray *listArray = dataDic[@"list"];
                        for(NSDictionary *dic in listArray){
                            Class class = NSClassFromString(modelName);
                            JMBaseModel *model = [[class alloc] initWithDictionary:dic];
                            [array addObject:model];
                        }
                        success(dataDic, array);
                    }
                }else if([dataDic isKindOfClass:[NSArray class]]){
                    //data是数组类型
                    if(JMIsEmpty(modelName)){
                        success(response.responseObject, nil);
                    }else{
                        NSMutableArray *array = [[NSMutableArray alloc] init];
                        NSArray *listArray = dataDic;
                        for(NSDictionary *dic in listArray){
                            Class class = NSClassFromString(modelName);
                            JMBaseModel *model = [[class alloc] initWithDictionary:dic];
                            [array addObject:model];
                        }
                        success(dataDic, array);
                    }
                }else{
                    success(response.responseObject, nil);
                }
            }
        }
    }];
}

/// POST表单上传图片
/// @param url api地址
/// @param params 参数
/// @param pictures 图片数据，key：图片data value：接口字段_名字
/// @param success 成功
/// @param fail 失败
-(void)requestUploadBasePost:(NSString *)url
                      params:(NSDictionary *)params
                    pictures:(NSDictionary<NSData *, NSString *> *)pictures
                     success:(SuccessBlock)success
                        fail:(FailBlock)fail{
    [[JMRequestManager sharedManager] upload:url parameters:params formDataBlock:^NSDictionary<NSData *,JMDataName *> *(id<AFMultipartFormData> formData, NSMutableDictionary<NSData *,JMDataName *> *needFillDataDict) {
        if(pictures){
            [needFillDataDict addEntriesFromDictionary:pictures];
        }
        return needFillDataDict;
    } progress:nil completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
            if(fail){
                fail(response.errorMsg);
            }
        }else{
            if(success){
                NSDictionary *dataDic = response.responseObject[@"data"];
                success(dataDic, nil);
            }
        }
    }];
}
@end
