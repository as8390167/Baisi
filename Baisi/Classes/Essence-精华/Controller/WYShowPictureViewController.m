//
//  WYShowPictureViewController.m
//  Baisi
//
//  Created by WY on 2017/4/16.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYShowPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "WYTopic.h"

@interface WYShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/** 图片imageView */
@property(nonatomic,weak)UIImageView *imageView;
@end

@implementation WYShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    CGFloat pictureW = WYScreenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH > WYScreenH) {
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = WYScreenH * 0.5;
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    WYLogFunc;
}

@end
