//
//  NetworkTools.h
//  Baisi
//
//  Created by SW on 2017/4/1.
//  Copyright © 2017年 WY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkTools : NSObject

/*
 -(NSURLSessionDataTask *)GET:(NSString *)URLString
 parameters:(id)parameters
 progress:(void (^)(NSProgress * _Nonnull))downloadProgress
 success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
 failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
 */
+(NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^ )(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task , NSError *error))failure;
@end
