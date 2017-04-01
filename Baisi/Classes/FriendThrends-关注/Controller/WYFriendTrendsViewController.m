//
//  WYFriendTrendsViewController.m
//  Baisi
//
//  Created by SW on 2017/3/30.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYFriendTrendsViewController.h"
#import "WYRecommendViewController.h"

@implementation WYFriendTrendsViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = WYGlboalBg;
    
    [self setupNav];
    
}

-(void)setupNav{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
}

-(void)friendsClick{
    
    WYRecommendViewController *recommendVC = [[WYRecommendViewController alloc] init];
    [self.navigationController pushViewController:recommendVC animated:true];
    WYLogFunc;
}
                                             
- (IBAction)loginRegisterClick {
    WYLogFunc;
}

@end
