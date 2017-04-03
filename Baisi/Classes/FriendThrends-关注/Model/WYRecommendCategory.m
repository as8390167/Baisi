//
//  WYRecommendCategory.m
//  Baisi
//
//  Created by SW on 2017/4/1.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYRecommendCategory.h"

@implementation WYRecommendCategory

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID" : @"id"};
}

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
