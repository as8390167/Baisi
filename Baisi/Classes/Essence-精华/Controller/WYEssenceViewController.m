//
//  WYEssenceViewController.m
//  Baisi
//
//  Created by SW on 2017/3/30.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYEssenceViewController.h"
#import "WYPageTitleView.h"
#import "WYPageContentView.h"
#import "WYWordTopicController.h"

@interface WYEssenceViewController()<WYPageTitleViewDelegate,WYPageContentViewDelegate>

/** 顶部标题栏view */
@property(nonatomic,weak)WYPageTitleView *pageTitleView;

/** 底部内容view */
@property(nonatomic,weak)WYPageContentView *pageContentView;

@end

@implementation WYEssenceViewController

-(WYPageTitleView *)pageTitleView
{
    if (!_pageTitleView) {
        WYPageTitleView *pageTitleView = [[WYPageTitleView alloc] init];
        pageTitleView.titleFont = [UIFont systemFontOfSize:14.0];
        pageTitleView.delegate = self;
        pageTitleView.backgroundColor = [UIColor whiteColor];
        pageTitleView.frame = CGRectMake(0, WYTitlesViewY, WYScreenW, WYTitlesViewH);
        [self.view addSubview:pageTitleView];
        _pageTitleView = pageTitleView;
    }
    return _pageTitleView;
}

-(WYPageContentView *)pageContentView
{
    if (!_pageContentView) {
        WYPageContentView *pageContentView = [[WYPageContentView alloc] init];
        CGFloat contentH = WYScreenH - WYTitlesViewY - WYTabBarH - WYTitlesViewH;
        CGRect contentFrame = CGRectMake(0, WYTitlesViewY + WYTitlesViewH, WYScreenW, contentH);
        pageContentView.frame = contentFrame;
        pageContentView.delegate = self;
        pageContentView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:pageContentView];
        self.pageContentView = pageContentView;
    }
    return _pageContentView;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = WYGlboalBg;
    [self setupUI];
}


-(void)setupUI
{
    self.pageTitleView.titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    NSMutableArray *childVCs = [NSMutableArray array];
    WYWordTopicController *word = [[WYWordTopicController alloc] init];
    [childVCs addObject:word];
    for (int i = 1; i < self.pageTitleView.titles.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = WYRandomColor;
        [childVCs addObject:vc];
    }
    [self.pageContentView parentVC:self childVCs:childVCs];
    
}
-(void)pageTitleView:(WYPageTitleView *)pageTitleView selectIndex:(int)index
{
    [self.pageContentView setCurrentIndex:index];
}

-(void)pageContentView:(WYPageContentView *)contentView progress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex
{
    [self.pageTitleView setTitleWithProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}
@end
