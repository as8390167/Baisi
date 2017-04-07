//
//  WYTopicCell.h
//  Baisi
//
//  Created by SW on 2017/4/6.
//  Copyright © 2017年 WY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WYTopic;
@interface WYTopicCell : UITableViewCell

/** 帖子模型 */
@property(nonatomic,strong)WYTopic *topic;

@end
