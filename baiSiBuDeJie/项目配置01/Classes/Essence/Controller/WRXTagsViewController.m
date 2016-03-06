//
//  WRXTagsViewController.m
//  项目配置01
//
//  Created by wang on 16/1/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXTagsViewController.h"
#import <AFNetworking.h>
#import "WRXEssenceTag.h"
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "WRXEssenceTagCell.h"
#import "WRXEssenceTag.h"

@interface WRXTagsViewController ()

@property (weak, nonatomic)  AFHTTPSessionManager*manager;
@property (nonatomic, strong) NSArray *essenceTags;
@end

@implementation WRXTagsViewController

 NSString * const tagId = @"essenceTag";
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
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
    
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WRXGlobalBackcolour;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WRXEssenceTagCell class]) bundle:nil] forCellReuseIdentifier:tagId];
    
    //发送请求
    NSString *URLString = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    
    [self.manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        self.essenceTags = [WRXEssenceTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
                [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络繁忙"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.essenceTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WRXEssenceTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagId];
    cell.essenceTag = self.essenceTags[indexPath.row];
    return cell;
}

@end
