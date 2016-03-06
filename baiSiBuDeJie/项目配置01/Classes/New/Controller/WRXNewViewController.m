//
//  WRXNewViewController.m
//  项目配置01
//
//  Created by wang on 16/1/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXNewViewController.h"

@interface WRXNewViewController ()

@end

@implementation WRXNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithNormalImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    //中间的标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //背景色
    self.view.backgroundColor = WRXGlobalBackcolour;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tagClick
{
    WRXLogFunc;
}

@end
