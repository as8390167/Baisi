//
//  NetworkTools.m
//  Baisi
//
//  Created by SW on 2017/4/1.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "NetworkTools.h"
#import <AFNetworking.h>

@implementation NetworkTools

//+(NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
//    
//    return nil;
//}
+(NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))succes failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    return [[AFHTTPSessionManager manager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        succes(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
    
}
@end
