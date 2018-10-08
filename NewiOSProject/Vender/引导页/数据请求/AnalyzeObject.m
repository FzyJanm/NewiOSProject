//
//  AnalyzeObject.m
//  JianRenJianZhi
//
//  Created by 软盟 on 2017/2/13.
//  Copyright © 2017年 软盟. All rights reserved.
//

#import "AnalyzeObject.h"
#import "AFAppDotNetAPIClient.h"
#import "NSError+Helper.h"
#import "NSString+Encrypt.h"
#import "Stockpile.h"
#import "AFAppDotNetAPIClient.h"
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>
@implementation AnalyzeObject

+(instancetype)shareAnalyze{
    static AnalyzeObject* shareObject=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareObject=[[AnalyzeObject alloc]init];
    });
    
    return shareObject;
}

/**  非上传照片类型 */
-(void)LinkServiceWithUrl:(NSString *)url ForIsToken:(BOOL)istoken ForParameters:(NSDictionary *)parameters  Block:(AnalyzeObjectBlock)block{
  
    [self AFNetWorkClickWithUrl:url ForIsToken:istoken ForParameters:parameters Block:block];
}

/** 上传照片类型 */
-(void)LoadServiceWithUrl:(NSString *)url ForIsToken:(BOOL)istoken ForParameters:(NSDictionary *)parameters forpic:(id)object forFielName:(NSString *)fileName Block:(AnalyzeObjectBlock)block{
    
    [self AFNetWorkPicsWithUrl:url ForIsToken:istoken ForParameters:parameters forpic:object forFielName:fileName Block:block];
}

/**
 @param url 接口名称
 @param istoken 是否传入token
 @param parameters 参数
 @param block 回传的数据
 */
-(void)AFNetWorkClickWithUrl:(NSString *)url ForIsToken:(BOOL)istoken ForParameters:(NSDictionary *)parameters  Block:(AnalyzeObjectBlock)block{
    if(url==nil) {
        url = @"";
    }
    
    NSString *string = @"";
    for (NSString *keyStr in [parameters allKeys]) {
        
        string = [string stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",keyStr,parameters[keyStr]]];
    }
    NSLog(@"\n\n%@?%@%@  \n\n",Host,url,string);
    
//    if (istoken)
//    {
//    [[AFAppDotNetAPIClient sharedClient].requestSerializer  setValue:[[NSUserDefaults standardUserDefaults] objectForKey:yongHuID] forHTTPHeaderField:@"token"];
//    }
    [[AFAppDotNetAPIClient sharedClient].requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf8" forHTTPHeaderField:@"Content-Type"];
    
    [[AFAppDotNetAPIClient sharedClient] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *code =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msgcode"]];
        NSString *msg =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        //        id data = [responseObject objectForKey:@"data"];
        
        if ([code isEqualToString:@"1"]) {
            block([responseObject objectForKey:@"data"],code,msg);
        }else if ([code isEqualToString:@"102"]){
            block(nil,code,msg);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenInvalid" object:nil];
        }
        else if ([code isEqualToString:@"105"])
        {
            block(responseObject,code,msg);
        }
        else if ([code isEqualToString:@"101"])
        {
            block(responseObject,code,msg);
        }
        else
        {
            block(nil,code,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        block(nil,@"0",[error errorMessage]);
        
    }];
}


/**
 @param url 接口名
 @param istoken 是否传入token
 @param parameters 参数
 @param object (单张照片为单个UIImage对象/多张照片为NSArray数组)
 @param fileName 图片参数
 @param block 回传的数据
 */
-(void)AFNetWorkPicsWithUrl:(NSString *)url ForIsToken:(BOOL)istoken ForParameters:(NSDictionary *)parameters forpic:(id)object forFielName:(NSString *)fileName Block:(AnalyzeObjectBlock)block{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
//    hud.label.text = NSLocalizedString(@"准备上传...", @"HUD preparing title");
//    hud.labelText = NSLocalizedString(@"准备上传...", @"HUD preparing title");
//    hud.minSize = CGSizeMake(150.f, 100.f);
    
//    if (istoken) {
//        [[AFAppDotNetAPIClient sharedClient].requestSerializer  setValue:[[NSUserDefaults standardUserDefaults] objectForKey:yongHuID] forHTTPHeaderField:@"token"];
//    }
    [[AFAppDotNetAPIClient sharedClient].requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf8" forHTTPHeaderField:@"Content-Type"];
    
    [[AFAppDotNetAPIClient sharedClient] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if ([object isKindOfClass:[UIImage class]]) {
            UIImage *image=(UIImage *)object;
            //单张图片
            NSData *data=[self compressImage:image toMaxFileSize:200];
            [formData appendPartWithFileData:data
                                        name:fileName
                                    fileName:@"image.jpg"
                                    mimeType:@"image/jpg"];
        }else{
            //多张图片
            NSArray *picArr=(NSArray *)object;
            for (int i = 0; i < picArr.count; i++) {
                UIImage *image = [picArr objectAtIndex:i];
                NSData *data=[self compressImage:image toMaxFileSize:200];
                
                [formData appendPartWithFileData:data
                                            name:[NSString stringWithFormat:@"%@[%d]",fileName,i]
                                        fileName:[NSString stringWithFormat:@"image%d.jpg",i]
                                        mimeType:@"image/jpg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            hud.mode = MBProgressHUDModeDeterminate;
//            hud.progress = uploadProgress.fractionCompleted;
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        [hud hide:YES];
//        NSLog(@"responseObject：：：%@",responseObject);
        NSString *code =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msgcode"]];
        NSString *msg =[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"msg"]];
        
        
        if ([code isEqualToString:@"100"]) {
            block(responseObject ,code,msg);
        }else if ([code isEqualToString:@"102"]){
            block(nil,code,msg);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenInvalid" object:nil];
        }else{
            block(nil,code,msg);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [hud hide:YES];
//        block(nil,@"0",[error errorMessage]);
    }];
}

- (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *beginImageData = UIImagePNGRepresentation(image);
    if ([beginImageData length] <= maxFileSize*1024) {
        return beginImageData;
    }else{
        NSData *imageData = UIImageJPEGRepresentation(image, compression);
        while ([imageData length] > maxFileSize*1024 && compression > maxCompression) {
            compression -= 0.1;
            imageData = UIImageJPEGRepresentation(image, compression);
        }
        return imageData;
    }
}

-(UIImage *) scaleImage: (UIImage *)image
{
    float scaleBy;
    if (image.size.width>800) {
        scaleBy = 800/image.size.width;
    }else{
        scaleBy= 1.0;
    }
    CGSize size = CGSizeMake(image.size.width * scaleBy, image.size.height * scaleBy);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformScale(transform, scaleBy, scaleBy);
    CGContextConcatCTM(context, transform);
    [image drawAtPoint:CGPointMake(0.0f, 0.0f)];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}
@end
