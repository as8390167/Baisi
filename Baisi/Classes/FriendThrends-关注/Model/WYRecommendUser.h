//
//  WYRecommendUser.h
//  Baisi
//
//  Created by WY on 2017/4/2.
//  Copyright © 2017年 WY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYRecommendUser : NSObject

/** 头像URLString */
@property(nonatomic,copy)NSString *header;

/** 粉丝数量 */
@property(nonatomic,assign)NSInteger fans_count;

/** 名字 */
@property(nonatomic,copy)NSString *screen_name;
@end
