//
//  WYTopicCell.m
//  Baisi
//
//  Created by SW on 2017/4/6.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYTopicCell.h"
#import "WYTopic.h"

@interface WYTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *topicContentLabel;


@end

@implementation WYTopicCell

-(void)setTopic:(WYTopic *)topic
{
    _topic = topic;
    
    [self.headerImageView setHeader:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    self.topicContentLabel.text = topic.text;
    NSLog(@"帖子内容:%@",topic.text);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
