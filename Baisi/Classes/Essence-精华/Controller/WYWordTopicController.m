//
//  WYWordTopicController.m
//  Baisi
//
//  Created by SW on 2017/4/6.
//  Copyright © 2017年 WY. All rights reserved.
//

#import "WYWordTopicController.h"
#import "NetworkTools.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "WYTopic.h"
#import "WYTopicCell.h"

@interface WYWordTopicController ()

/** 帖子数组 */
@property(nonatomic,strong)NSMutableArray<WYTopic *> *topicArr;

/** 当加载下一页数据时需要这个参数 */
@property (nonatomic, copy) NSString *maxtime;

/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;
@end

static NSString *TopicCell = @"topic";
static NSString *TopicUrlStr = @"http://api.budejie.com/api/api_open.php";

@implementation WYWordTopicController

-(NSMutableArray *)topicArr{
    
    if (!_topicArr) {
        
        _topicArr = [NSMutableArray array];
    }
    return _topicArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];

}

#pragma mark - 设置tableView
-(void)setupTableView{
    self.tableView.contentInset = UIEdgeInsetsMake(WYTitlesViewH + WYTitlesViewY, 0,  WYTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WYTopicCell class]) bundle:nil] forCellReuseIdentifier:TopicCell];

}

#pragma mark - 设置刷新控件
-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];

}

/**
 * 加载帖子最新数据
 */
-(void)loadNewTopic
{
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    [NetworkTools GET:TopicUrlStr parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topicArr = [WYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        self.currentPage = 0;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 * 加载更多帖子数据
 */
-(void)loadMoreTopic
{
    [self.tableView.mj_header endRefreshing];
    
    NSInteger page = self.currentPage + 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [NetworkTools GET:TopicUrlStr parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *moreTopicArr = [WYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topicArr addObjectsFromArray:moreTopicArr];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        self.currentPage = page;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topicArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYTopic *topic = _topicArr[indexPath.row];
    return topic.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    WYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicCell forIndexPath:indexPath];
    WYTopic *topic = _topicArr[indexPath.row];
    cell.topic = topic;
    return cell;
}


@end
