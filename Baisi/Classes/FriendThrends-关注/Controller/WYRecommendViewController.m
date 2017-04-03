//
//  WYRecommendViewController.m
//  Baisi
//
//  Created by SW on 2017/4/1.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYRecommendViewController.h"
#import <AFNetworking.h>
#import "WYRecommendCategory.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "WYRecommendUser.h"
#import <SVProgressHUD.h>
#import "WYRecommendCategoryCell.h"
#import "WYRecommendUserCell.h"

#define WYSelectedCategory self.categories[self.categoryTabelview.indexPathForSelectedRow.row]

@interface WYRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 左边类别数据 */
@property(nonatomic,strong)NSArray<WYRecommendCategory *> *categories;

@property (weak, nonatomic) IBOutlet UITableView *categoryTabelview;

@property (weak, nonatomic) IBOutlet UITableView *userTableview;

/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *params;
@end

static NSString *WYCategoryID = @"category";
static NSString *WYUsersID = @"user";

@implementation WYRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupTableView];
    
    [self setupRefresh];
    
    [self loadCategory];
}


#pragma mark - view的初始化设置
/**
 * 控件的初始化
 */
- (void)setupTableView
{
    [self.categoryTabelview registerNib:[UINib nibWithNibName:NSStringFromClass([WYRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:WYCategoryID];
    [self.userTableview registerNib:[UINib nibWithNibName:NSStringFromClass([WYRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:WYUsersID];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    self.categoryTabelview.tableFooterView = [[UIView alloc] init];
    self.categoryTabelview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableview.contentInset = self.categoryTabelview.contentInset;
    self.userTableview.rowHeight = 70;
    
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = WYGlboalBg;
    
}

-(void)setupRefresh{
    
    self.userTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

#pragma mark - 加载用户数据
/**
 下拉刷新
*/
-(void)loadNewUsers{
    
    WYRecommendCategory *selectedRC = WYSelectedCategory;
    
    NSInteger page = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(selectedRC.ID);
    params[@"page"] = @(page);
    self.params = params;
    
    [NetworkTools GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //WYLog(@"%@",responseObject);
        // 字典数组 -> 模型数组
        NSArray *users = [WYRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 清除所有旧数据
        [selectedRC.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [selectedRC.users addObjectsFromArray:users];
        
        // 保存总数
        selectedRC.total = [responseObject[@"total"] integerValue];
        
        //保存页码
        selectedRC.currentPage = page;
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        [self.userTableview reloadData];
        [self.userTableview.mj_header endRefreshing];
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //WYLog(@"users请求失败--------%@",error);
        if (self.params != params) return;
        
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        [self.userTableview.mj_footer endRefreshing];
    }];
    
}

/**
 上拉加载更多数据
 */
-(void)loadMoreUsers{
    
    NSInteger page = WYSelectedCategory.currentPage + 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(WYSelectedCategory.ID);
    params[@"page"] = @(page);
    self.params = params;
    
    [NetworkTools GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //WYLog(@"%@",responseObject);
        NSArray *us = [WYRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [WYSelectedCategory.users addObjectsFromArray:us];
        WYSelectedCategory.currentPage = page;
        if (self.params != params) return;
        [self.userTableview reloadData];
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       // //WYLog(@"users请求失败--------%@",error);
        if (self.params != params) return;
        
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        [self.userTableview.mj_footer endRefreshing];
    }];
}

/**
 加载类别数据
 */
-(void)loadCategory{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [NetworkTools GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        //////WYLog(@"%@",responseObject);
        self.categories = [WYRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTabelview reloadData];
        
        [self.categoryTabelview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:false scrollPosition:UITableViewScrollPositionTop];
        [self.userTableview.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //WYLog(@"category请求失败--------%@",error);
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        
        [self.categoryTabelview.mj_header endRefreshing];
    }];
}

-(void)checkFooterState{
    
    self.userTableview.mj_footer.hidden = (WYSelectedCategory.users.count == 0);
    if (WYSelectedCategory.users.count >= WYSelectedCategory.total) {
        [self.userTableview.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.userTableview.mj_footer endRefreshing];
    }
}

#pragma mark - <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTabelview) {
        return self.categories.count;
    }
    [self checkFooterState];
    return WYSelectedCategory.users.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTabelview) {
        WYRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:WYCategoryID];
        cell.categories = self.categories[indexPath.row];
        return cell;
        
    }else{
        
        WYRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:WYUsersID];
        cell.user = WYSelectedCategory.users[indexPath.row];
        return cell;
    }
}


#pragma mark - <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTabelview) {
        [self.userTableview.mj_header endRefreshing];
        [self.userTableview.mj_footer endRefreshing];
        
        WYRecommendCategory *selectedRC = self.categories[indexPath.row];
        if (selectedRC.users.count) {
            [self.userTableview reloadData];
        }else{
            [self.userTableview reloadData];
            [self.userTableview.mj_header beginRefreshing];
        }
    }

}

#pragma mark - 控制器销毁
-(void)dealloc{
    
}
@end
