//
//  WRXMeViewController.m
//  项目配置01
//
//  Created by wang on 16/1/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXMeViewController.h"

@interface WRXMeViewController ()

@end

@implementation WRXMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *moon = [UIBarButtonItem ItemWithNormalImage:@"mine-moon-icon" highlightImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    UIBarButtonItem *setting = [UIBarButtonItem ItemWithNormalImage:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    self.navigationItem.rightBarButtonItems = @[setting,moon];
    self.navigationItem.title = @"我的";
    
    //背景色
    self.view.backgroundColor = WRXGlobalBackcolour;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moonClick
{
    WRXLogFunc;
}

- (void)settingClick
{
    WRXLogFunc;
}
@end
