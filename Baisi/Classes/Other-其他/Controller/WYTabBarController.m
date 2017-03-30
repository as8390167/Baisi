//
//  WYTabBarController.m
//  Baisi
//
//  Created by SW on 2017/3/30.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYTabBarController.h"
#import "WYNewViewController.h"
#import "WYEssenceViewController.h"
#import "WYFriendTrendsViewController.h"
#import "WYMeViewController.h"

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
    
    WYEssenceViewController *essenceVC = [[WYEssenceViewController alloc] init];
    essenceVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    essenceVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    
    WYNewViewController *newVC = [[WYNewViewController alloc] init];
    newVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    newVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    
    WYFriendTrendsViewController *friendTrendVC = [[WYFriendTrendsViewController alloc] init];
    friendTrendVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    friendTrendVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    
    WYMeViewController *meVC = [[WYMeViewController alloc] init];
    meVC.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    meVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    
    [self addChildViewController:essenceVC];
    [self addChildViewController:newVC];
    [self addChildViewController:friendTrendVC];
    [self addChildViewController:meVC];
}

-(void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    vc.navigationItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:vc];
}

@end
