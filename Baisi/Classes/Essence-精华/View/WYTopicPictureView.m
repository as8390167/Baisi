//
//  WYTopicPictureView.m
//  Baisi
//
//  Created by WY on 2017/4/16.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYTopicPictureView.h"
#import "WYTopic.h"
#import <UIImageView+WebCache.h>
#import "WYShowPictureViewController.h"
@interface WYTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;

@end

@implementation WYTopicPictureView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

-(void)setTopic:(WYTopic *)topic
{
    _topic = topic;
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (topic.isBigPicture == NO) return ;
        
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }];
    
    NSString *extension = topic.large_image.pathExtension;
    self.gifImageView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    self.seeBigBtn.hidden = !topic.isBigPicture;
}

-(void)showPicture
{
    WYShowPictureViewController *showPictureVC = [[WYShowPictureViewController alloc] init];
    showPictureVC.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVC animated:YES completion:nil];
}

@end
