//
//  WRXCommentViewController.m
//  项目配置01
//
//  Created by wang on 16/2/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXCommentViewController.h"
#import "WRXTopicCell.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "WRXComment.h"
#import <MJExtension.h>


@interface WRXCommentViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolViewToSuperViewMargin;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

/** 评论数组*/
@property (nonatomic, strong) NSMutableArray *comments;
/** 最热评论*/
@property (nonatomic, strong) NSArray *hotComments;
@end

@implementation WRXCommentViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setup];
    [self setupTableHeaderView];
    [self setupRefresh];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewComment
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
     parameters[@"c"] = @"comment";
     parameters[@"data_id"] = self.topic.ID;
    parameters[@"hot"] = @"1";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.comments = [WRXComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.hotComments = [WRXComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];

}
- (void)setupTableHeaderView
{
    WRXTopicCell *cell = [WRXTopicCell topicCell];
    cell.topic = self.topic;
    UIView *view = [[UIView alloc] init];
    view.height = self.topic.cellHeight;
    cell.height = view.height;
    [view addSubview:cell];
    self.tableView.tableHeaderView = view;//注意：当tableHeaderView是一个cell时，需要用一个view来包装一下
    
}
- (void)setup
{
    self.navigationItem.title = @"评论";
    self.tableView.backgroundColor = WRXGlobalBackcolour;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification//当发出通知时，调用方法时，会传入(NSNotification *)notification，一切信息都在notification中
{
    self.toolViewToSuperViewMargin.constant = WRXScreenH - [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue].origin.y;
    [UIView animateWithDuration:[notification.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue]animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
}

- (void)dealloc
{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComments.count) {
        return 2;
    }else if (self.comments.count){
        return 1;
    }else{
        return 0;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.hotComments.count) {
            return self.hotComments.count;
        }else if (self.comments.count){
            return self.comments.count;
        }else{
            return 0;
        }
    }else{
        return self.comments.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd------%zd",indexPath.section,indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.hotComments.count){
            return @"最热评论";
            
        }else if (self.comments.count){
            return @"最新评论";
        }else{
            return nil;
        }
    }else{
        return @"最新评论";
    }
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
