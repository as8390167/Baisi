//
//  WYTopic.h
//  Baisi
//
//  Created by SW on 2017/4/5.
//  Copyright © 2017年 WY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYTopic : NSObject

/** 帖子ID */
@property(nonatomic,copy)NSString *ID;

/** 帖子类型 */
@property(nonatomic,assign)WYTopicType type;

/** 帖子文字内容 */
@property(nonatomic,copy)NSString *text;

/** 用户ID */
@property(nonatomic,assign)NSInteger user_id;

/** 发帖人名字 */
@property(nonatomic,copy)NSString *name;

/** 头像URL String */
@property(nonatomic,copy)NSString *profile_image;

/** 发帖时间 */
@property(nonatomic,copy)NSString *create_time;

/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;

/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;

/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;

/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;

/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;

/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;

//辅助属性
/** cell的高度 */
@property(nonatomic,assign,readonly)CGFloat cellHeight;
@end
