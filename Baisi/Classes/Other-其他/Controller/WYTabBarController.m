//
//  WYTabBarController.m
//  Baisi
//
//  Created by SW on 2017/3/30.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYTabBarController.h"
#import "WYNullViewController.h"
#import "WYNewViewController.h"
#import "WYEssenceViewController.h"
#import "WYFriendTrendsViewController.h"
#import "WYMeViewController.h"

@interface WYTabBarController()

@property(nonatomic,weak)UIButton *publishBtn;

@end

@implementation WYTabBarController

+(void)initialize{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    
    [self setupChildVC:[[WYEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupChildVC:[[WYNewViewController alloc] init] title:@"关注" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildVC:[[WYNullViewController alloc] init] title:@"" image:@"" selectedImage:@""];
    [self setupChildVC:[[WYFriendTrendsViewController alloc] init] title:@"新帖" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildVC:[[WYMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
   // [self setupPublish];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupPublish];
}

-(void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:vc];
}

-(void)setupPublish{
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    [publishBtn addTarget:self action:@selector(publishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:publishBtn];
    self.publishBtn = publishBtn;
    CGFloat width = WYScreenW / self.viewControllers.count;
    CGFloat height = self.tabBar.bounds.size.height;
    CGRect rect = CGRectMake(0, 0, width, height);
    publishBtn.frame = CGRectOffset(rect, 2 * width, 0);

}

-(void)publishBtnClick{
    
    NSLog(@"123213213");
    WYLogFunc;
}
@end
