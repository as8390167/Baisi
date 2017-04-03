//
//  WYRecommendUserCell.m
//  Baisi
//
//  Created by WY on 2017/4/2.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYRecommendUserCell.h"
#import "WYRecommendUser.h"

@interface WYRecommendUserCell()


@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *followNumLabel;
@end

@implementation WYRecommendUserCell

-(void)setUser:(WYRecommendUser *)user
{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    [self.headerImageView setHeader:user.header];
    NSString *fansCount = @"";
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    }else{
        fansCount = [NSString stringWithFormat:@"%.1f万人关注",user.fans_count / 10000.0];
    }
    self.followNumLabel.text = fansCount;
}

@end
