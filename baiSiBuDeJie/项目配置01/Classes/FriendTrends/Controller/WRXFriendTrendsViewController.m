//
//  WRXFriendTrendsViewController.m
//  项目配置01
//
//  Created by wang on 16/1/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXFriendTrendsViewController.h"
#import "WRXCategoryViewController.h"
#import "WRXLoginOrRegisterViewController.h"


@interface WRXFriendTrendsViewController ()

@end

@implementation WRXFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithNormalImage:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    self.navigationItem.title = @"我的关注";
    
    //背景色
    self.view.backgroundColor = WRXGlobalBackcolour;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginOrRegister:(id)sender {
    
    WRXLoginOrRegisterViewController *loginOrRegister = [[WRXLoginOrRegisterViewController alloc] init];
    [self presentViewController:loginOrRegister animated:YES completion:nil];
}

- (void)friendsClick
{
    WRXCategoryViewController *recommend = [[WRXCategoryViewController alloc] init];
    recommend.navigationItem.title = @"推荐关注";
    recommend.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recommend animated:YES];
}
@end
