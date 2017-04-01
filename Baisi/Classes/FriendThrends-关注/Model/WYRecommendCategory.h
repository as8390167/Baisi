//
//  WYRecommendCategory.h
//  Baisi
//
//  Created by SW on 2017/4/1.
//  Copyright © 2017年 WY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYRecommendCategory : NSObject

/** id */
@property(nonatomic,assign)NSInteger ID;

/** 总数 */
@property(nonatomic,assign)NSInteger count;

/** 名字 */
@property(nonatomic,copy)NSString *name;

@end
