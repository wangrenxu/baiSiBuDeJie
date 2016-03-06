//
//  WRXCategoryViewController.m
//  项目配置01
//
//  Created by wang on 16/1/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXCategoryViewController.h"
#import "WRXCategoryCell.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import "WRXRecommendCategory.h"
#import <MJExtension.h>
#import "WRXUserCell.h"
#import "WRXRecommendUser.h"
#import <MJRefresh.h>


@interface WRXCategoryViewController () <UITableViewDataSource,UITableViewDelegate>
/** 类别tabelView*/
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 类别模型数组*/
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic, strong) NSArray *categorys;
@property (nonatomic, strong) NSMutableDictionary *parameters;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSURLSessionDataTask *task;


@end

@implementation WRXCategoryViewController

static  NSString * const cateGoryID =@"cateGory";
static  NSString * const userID =@"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [SVProgressHUD show];
    [self loadNewCategory];
    
    [self setupRefresh];
    //进入刷新状态
    [self.userTableView.mj_header beginRefreshing];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
//    [self.manager invalidateSessionCancelingTasks:YES];
    [super viewWillDisappear:animated];
    
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    [self.task cancel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupRefresh
{
    __weak __typeof__(self) weakSelf = self;
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [weakSelf loadNewUsers];//此处用self会导致循环引用
    }];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [weakSelf loadMoreUsers];//此处用self会导致循环引用
    }];
}

- (void)setup
{
    
    //禁止系统调节内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    //背景色
    self.view.backgroundColor = WRXGlobalBackcolour;
    self.categoryTableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    self.userTableView.rowHeight = 80;
    self.userTableView.backgroundColor = [UIColor clearColor];
    //注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WRXCategoryCell class]) bundle:nil] forCellReuseIdentifier:cateGoryID];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([WRXUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
}

- (void)loadNewCategory
{
    //发送请求
    NSString *URLString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
   
    [self.manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.categorys = [WRXRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        
        //默认选中第0行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [SVProgressHUD showErrorWithStatus:@"网络繁忙"];
    }];
}

- (void)loadNewUsers
{
    
    
        NSIndexPath *indexPath = [self.categoryTableView indexPathForSelectedRow];
        //获取选中的类别模型
        WRXRecommendCategory *category = self.categorys[indexPath.row];
        
        //发送请求
    
        NSString *URLString = @"http://api.budejie.com/api/api_open.php";
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"a"] = @"list";
        parameters[@"c"] = @"subscribe";
        parameters[@"category_id"] = category.id;
        category.currentPage = 1;
        parameters[@"page"] = @(category.currentPage);
        self.parameters = parameters;
    
    __weak typeof(self) weakSelf = self;
        self.task = [self.manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
          
            NSIndexPath *categoryIndexPath = [weakSelf.categoryTableView indexPathForSelectedRow];
            WRXRecommendCategory *category = weakSelf.categorys[categoryIndexPath.row];
            category.users = [WRXRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            if (weakSelf.parameters !=parameters) return ;//连续发送多次请求时，只是刷新最后一次
                 
            [weakSelf.userTableView reloadData];
            
            [weakSelf.userTableView.mj_header endRefreshing];
            if ([responseObject[@"total"] integerValue] == category.users.count) {
                [weakSelf.userTableView.mj_footer endRefreshingWithNoMoreData];
            }else {
                [weakSelf.userTableView.mj_footer endRefreshing];
            }
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [weakSelf.userTableView.mj_header endRefreshing];
            if (weakSelf.parameters !=parameters) return ;
            [SVProgressHUD showErrorWithStatus:@"网络繁忙"];
        }];
   
    
    
        
    
    
}

- (void)loadMoreUsers
{
    NSIndexPath *indexPath = [self.categoryTableView indexPathForSelectedRow];
    //获取选中的类别模型
    WRXRecommendCategory *category = self.categorys[indexPath.row];
    
    //发送请求
    NSString *URLString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = category.id;
    parameters[@"page"] = @(category.currentPage += 1);
    __weak typeof(self) weakSelf = self;
    [self.manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSIndexPath *categoryIndexPath = [ weakSelf.categoryTableView indexPathForSelectedRow];
        WRXRecommendCategory *category =  weakSelf.categorys[categoryIndexPath.row];
        NSArray *moreUsers = [WRXRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.users addObjectsFromArray:moreUsers];
        
        
        [ weakSelf.userTableView reloadData];
        
        [ weakSelf.userTableView.mj_footer endRefreshing];
        if ([responseObject[@"total"] integerValue] == category.users.count) {
            [ weakSelf.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [ weakSelf.userTableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [ weakSelf.userTableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"网络繁忙"];
        category.currentPage -= 1;//加载失败时，恢复页码
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categorys.count;

    }else {
        
        NSIndexPath *categoryIndexPath = [self.categoryTableView indexPathForSelectedRow];
        WRXRecommendCategory *category = self.categorys[categoryIndexPath.row];
        self.userTableView.mj_footer.hidden = category.users.count? NO:YES;
        return category.users.count;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.categoryTableView) {
        WRXCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cateGoryID];
        cell.category = self.categorys[indexPath.row];
        
        return cell;
    } else {
        WRXUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
        NSIndexPath *categoryIndexPath = [self.categoryTableView indexPathForSelectedRow];
        WRXRecommendCategory *category = self.categorys[categoryIndexPath.row];
        cell.recommendUser = category.users[indexPath.row];
        return cell;
    }
    
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    

    if (self.categoryTableView == tableView) {
        
        NSIndexPath *categoryIndexPath = [self.categoryTableView indexPathForSelectedRow];
        WRXRecommendCategory *category = self.categorys[categoryIndexPath.row];

        if (category.users.count) {
            [self.userTableView.mj_header endRefreshing];//每次发送请求前，先结束刷新
            [self.userTableView reloadData];
        } else{
            [self.userTableView.mj_header endRefreshing];//每次发送请求前，先结束刷新
            [self.userTableView reloadData];
          
                
            [self.userTableView.mj_header beginRefreshing];
        
        }
        
        
}
    
    

}
#pragma mark 
//控制器销毁时，取消所有的请求
- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];
   
   
}
@end
