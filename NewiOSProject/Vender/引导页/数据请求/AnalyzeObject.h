//
//  AnalyzeObject.h
//  JianRenJianZhi
//
//  Created by 软盟 on 2017/2/13.
//  Copyright © 2017年 软盟. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^AnalyzeObjectBlock)(id models, NSString *code ,NSString * msg);
@interface AnalyzeObject : NSObject

+(instancetype)shareAnalyze;

//非上传照片类型
/**
 调用接口
 @param url 接口名称
 @param istoken 是否传入token
 @param parameters 参数
 @param block 回传的数据
 */
-(void)LinkServiceWithUrl:(NSString *)url ForIsToken:(BOOL)istoken ForParameters:(NSDictionary *)parameters  Block:(AnalyzeObjectBlock)block;

//上传照片类型
/**
 调用接口
 @param url 接口名
 @param istoken 是否传入token
 @param parameters 参数
 @param object (单张照片为单个UIImage对象/多张照片为NSArray数组)
 @param fileName 图片参数
 @param block 回传的数据
 */

-(void)LoadServiceWithUrl:(NSString *)url ForIsToken:(BOOL)istoken ForParameters:(NSDictionary *)parameters forpic:(id)object forFielName:(NSString *)fileName Block:(AnalyzeObjectBlock)block;
@end
