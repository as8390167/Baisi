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

/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;

/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;

/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;

//辅助属性
/** cell的高度 */
@property(nonatomic,assign,readonly)CGFloat cellHeight;

/** 图片控件的frame */
@property(nonatomic,assign)CGRect pictureF;

/** 图片是否太大 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
@end
