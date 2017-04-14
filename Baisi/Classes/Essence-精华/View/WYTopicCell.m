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

@property (weak, nonatomic) IBOutlet UIButton *dingBtn;

@property (weak, nonatomic) IBOutlet UIButton *caiBtn;

@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@end

@implementation WYTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    self.topicContentLabel.font = WYTopicCellFont;
}

-(void)setTopic:(WYTopic *)topic
{
    _topic = topic;
    
    [self.headerImageView setHeader:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    self.topicContentLabel.text = topic.text;
    //WYLog(@"帖子内容:%@",topic.text);
    [self setupButtonTitle:self.dingBtn count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiBtn count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareBtn count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentBtn count:topic.comment placeholder:@"评论"];
}



- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame{
    
    frame.size.height = _topic.cellHeight - WYTopicCellMargin;
    frame.origin.y += WYTopicCellMargin;
    [super setFrame:frame];
}




@end
