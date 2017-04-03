//
//  WYRecommendCategory.h
//  Baisi
//
//  Created by SW on 2017/4/1.
//  Copyright © 2017年 WY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WYRecommendUser;

@interface WYRecommendCategory : NSObject

/** id */
@property(nonatomic,assign)NSInteger ID;

/** 名字 */
@property(nonatomic,copy)NSString *name;

/* 辅助属性 */

/** 当前类别对应的用户数据 */
@property(nonatomic,strong)NSMutableArray<WYRecommendUser *> *users;

/** 用户数据总数 */
@property(nonatomic,assign)NSInteger total;

/** 当前页码 */
@property(nonatomic,assign)NSInteger currentPage;

@end
