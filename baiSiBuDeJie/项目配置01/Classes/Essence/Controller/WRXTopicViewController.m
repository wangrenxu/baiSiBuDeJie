//
//  WRXTopicViewController.m
//  项目配置01
//
//  Created by wang on 16/1/22.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXTopicViewController.h"
#import "WRXTopicCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "WRXWordTopic.h"
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import "WRXCommentViewController.h"


@interface WRXTopicViewController ()
@property (weak, nonatomic) AFHTTPSessionManager *manager;
/** 模型数组*/
@property (nonatomic, strong) NSMutableArray *topics;
/** 加载下一页时，需要的maxtime*/
@property (nonatomic, copy) NSString *maxtime;
/** 当前请求的参数*/
@property (nonatomic, strong) NSMutableDictionary *parameters;



@end

@implementation WRXTopicViewController
static  NSString *ID = @"topic";


- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //初始化tableView
    [self setupTableView];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WRXTopicCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    //初始化刷新控件
    [self setupRefresh];
    
    //进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    
    
    
    
}

//初始化tableView
- (void)setupTableView
{
    self.tableView.contentInset = UIEdgeInsetsMake(104, 0, 49, 0);
    self.tableView.scrollIndicatorInsets =  UIEdgeInsetsMake(104, 0, 49, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
}

//初始化刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
}

//加载新的帖子
- (void)loadNewTopic
{
    //先结束上拉刷新
    [self.tableView.mj_footer endRefreshing];
    
    //发送请求
    NSString *URLString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    self.parameters = parameters;
    
    [self.manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/apple/Desktop/picture.plist" atomically:YES];
        if (self.parameters!= parameters) return ;//同时下拉刷新和上拉刷新时，只处理最后一次请求
        self.topics = [WRXWordTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"网络繁忙"];
        
    }];
}

//加载更多帖子
- (void)loadMoreTopic
{
    //先结束下拉刷新
    [self.tableView.mj_header endRefreshing];
    
    //发送请求
    NSString *URLString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    self.parameters = parameters;
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"maxtime"] = self.maxtime;
    [self.manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.parameters!= parameters) return ;//同时下拉刷新和上拉刷新时，只处理最后一次请求
        NSArray *array = [WRXWordTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:array];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = (self.topics.count == 0);//没有数据时，隐藏上拉刷新控件
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WRXTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    WRXWordTopic *topic = self.topics[indexPath.row];
     
    return topic.cellHeight;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WRXCommentViewController *commentVc = [[WRXCommentViewController alloc] init];
    commentVc.topic = self.topics[indexPath.row];
    commentVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:commentVc animated:YES];
}

@end