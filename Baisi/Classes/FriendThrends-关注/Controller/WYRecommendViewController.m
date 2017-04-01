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

#define WYSelectedCategory self.categories[self.categoryTabelview.indexPathForSelectedRow.row]

@interface WYRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 左边类别数据 */
@property(nonatomic,strong)NSArray *categories;

@property (weak, nonatomic) IBOutlet UITableView *categoryTabelview;

@property (weak, nonatomic) IBOutlet UITableView *userTableview;

/** 当前页码 */
@property(nonatomic,assign)NSInteger page;
@end

static NSString *cellID = @"cellID";
@implementation WYRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐关注";
    
    [self setupRefresh];
    
    [self loadCategory];
}

-(void)setupRefresh{
    
    self.userTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

-(void)loadNewUsers{
    
    WYRecommendCategory *selectedRC = WYSelectedCategory;
    
    NSInteger page = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(selectedRC.ID);
    params[@"page"] = @(page);
    
    [NetworkTools GET:@"" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.page = page;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

-(void)loadMoreUsers{
    
}

-(void)loadCategory{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [NetworkTools GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        WYLog(@"%@",responseObject);
        self.categories = [WYRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTabelview reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        WYLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categories.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    WYRecommendCategory *category = self.categories[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd-%@",indexPath.row,category.name];
    return cell;
}

@end
