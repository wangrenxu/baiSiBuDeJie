//
//  WRXTabBarController.m
//  项目配置
//
//  Created by wang on 16/1/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXTabBarController.h"
#import "WRXEssenceViewController.h"
#import "WRXNewViewController.h"
#import "WRXFriendTrendsViewController.h"
#import "WRXMeViewController.h"
#import "WRXTabBar.h"
#import "WRXNavigationController.h"

@interface WRXTabBarController ()

@end

@implementation WRXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加四个子控制器
    [self setupChildVc:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon" vc:[[WRXEssenceViewController alloc] init]];
    [self setupChildVc:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" vc:[[WRXNewViewController alloc] init]];
    [self setupChildVc:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon" vc:[[WRXFriendTrendsViewController alloc] init]];
    [self setupChildVc:@"我" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" vc:[[WRXMeViewController alloc] init]];
    
    //设置所有UITabBarButton的文字颜色
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    NSMutableDictionary *normalDictionary = [NSMutableDictionary dictionary];
    normalDictionary[NSForegroundColorAttributeName] = [UIColor grayColor];
    [tabBarItem setTitleTextAttributes:normalDictionary forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedDictionary = [NSMutableDictionary dictionary];
    selectedDictionary[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [tabBarItem setTitleTextAttributes:selectedDictionary forState:UIControlStateSelected];
    
    //自定义tabBar
    [self setValue:[[WRXTabBar alloc] init] forKey:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage vc:(UIViewController *)vc
{
    WRXNavigationController *nav = [[WRXNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    [nav.tabBarItem setImage:[UIImage imageNamed:image]];
    [nav.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImage]];
    [self addChildViewController:nav];


}

@end
