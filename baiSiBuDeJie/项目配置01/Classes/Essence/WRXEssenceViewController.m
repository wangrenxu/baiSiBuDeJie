//
//  WRXEssenceViewController.m
//  项目配置01
//
//  Created by wang on 16/1/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXEssenceViewController.h"
#import "WRXTagsViewController.h"
#import "WRXTopicViewController.h"


@interface WRXEssenceViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) UIButton *selectedButton;
@property (weak, nonatomic) UIView *indicatorView;
@property (weak, nonatomic) UIScrollView *contentScrollView;
@property (weak, nonatomic) UIView *titleView;
@end

@implementation WRXEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化道航控制器
    [self setupNav];
    
    //初始化子控制器
    [self setupChildViewController];
    
    //初始化titleView
    [self setupTitleView];
    
    //初始化contentScrollView
    [self setupContentScrollView];
    
}
//初始化道航控制器
- (void)setupNav
{
    //左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ItemWithNormalImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    //中间的标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //背景色
    self.view.backgroundColor = WRXGlobalBackcolour;
    
}
//初始化子控制器
- (void)setupChildViewController
{
    //初始化子控制器
    WRXTopicViewController *all = [[WRXTopicViewController alloc] init];
    all.type = WRXTopicTypeAll;
    all.title = @"所有";
    [self addChildViewController:all];
    WRXTopicViewController *video = [[WRXTopicViewController alloc] init];
    video.type = WRXTopicTypeVideo;
    video.title = @"视频";
    [self addChildViewController:video];
    WRXTopicViewController *voice = [[WRXTopicViewController alloc] init];
    voice.type = WRXTopicTypeVoice;
    voice.title = @"声音";
    [self addChildViewController:voice];
    WRXTopicViewController *picture = [[WRXTopicViewController alloc] init];
    picture.type = WRXTopicTypePicture;
    picture.title = @"图片";
    [self addChildViewController:picture];
    WRXTopicViewController *word = [[WRXTopicViewController alloc] init];
    word.type = WRXTopicTypeWord;
    word.title = @"段子";
    [self addChildViewController:word];

}
//初始化titleView
- (void)setupTitleView
{
    UIView *titleView = [[UIView alloc] init];
    self.titleView = titleView;
    CGFloat titleViewX = 0;
    CGFloat titleViewY = 64;
    CGFloat titleViewW = WRXScreenW;
    CGFloat titleViewH = 40;
    titleView.frame = CGRectMake(titleViewX, titleViewY, titleViewW, titleViewH);
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];//这句代码和下面的两句代码等价
    /*
     titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
     titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
     */
    [self.view addSubview:titleView];
    
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    //添加按钮
    for (int i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        CGFloat buttonW = titleViewW/titles.count;
        CGFloat buttonX = i * buttonW;
        CGFloat buttonY = 0;
        CGFloat buttonH = titleViewH;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
    }
    
    //添加指示器
    UIView *indicatorView = [[UIView alloc] init];
    self.indicatorView = indicatorView;
    indicatorView.height = 2;
    UIButton *firstButton = [titleView.subviews firstObject];
    [firstButton.titleLabel sizeToFit];
    indicatorView.y= titleViewH - indicatorView.height;
    indicatorView.backgroundColor = [UIColor redColor];
    [titleView addSubview:indicatorView];
    
    //开始默认选中第一个按钮
    [self buttonClick:firstButton];
    
    //    WRXLog(@"%@",NSStringFromCGPoint(firstButton.center));
    //    WRXLog(@"%@",NSStringFromCGPoint(firstButton.titleLabel.center));
    
}
 //初始化contentScrollView
- (void)setupContentScrollView
{
    
    UIScrollView *ContentScrollView = [[UIScrollView alloc] init];
    ContentScrollView.delegate = self;
    ContentScrollView.pagingEnabled = YES;
    self.contentScrollView = ContentScrollView;
    ContentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * WRXScreenW, 0);
    CGFloat ContentScrollViewX = 0;
    CGFloat ContentScrollViewY = 0;
    CGFloat ContentScrollViewW = WRXScreenW;
    CGFloat ContentScrollViewH = WRXScreenH;
    ContentScrollView.frame = CGRectMake(ContentScrollViewX, ContentScrollViewY, ContentScrollViewW, ContentScrollViewH);
   
    [self.view insertSubview:ContentScrollView atIndex:0];
    
    //默认显示all的view
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}
/**
 * 监听按钮的点击
 */
- (void)buttonClick:(UIButton *)button
{
    //改变按钮的状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    //改变指示器的位置和尺寸
   self.indicatorView.width = button.titleLabel.width;
    self.indicatorView.centerX = button.centerX;
    
    
    //让contentScrollView滚到相应的位置
    CGPoint offSet = self.contentScrollView.contentOffset;
    offSet.x = WRXScreenW * button.tag;
    [self.contentScrollView setContentOffset:offSet animated:YES];

}

#pragma mark - <UIScrollViewDelegate>

//执行方法：[self.contentScrollView setContentOffset:offSet animated:YES]，有动画时，调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //添加对应控制器的view
    NSInteger index = scrollView.contentOffset.x/WRXScreenW;
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(WRXScreenW * index, 0, WRXScreenW, WRXScreenH);
    [self.contentScrollView addSubview:vc.view];
}

//用手拖动scrollView，停止减速时，调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/WRXScreenW;
    [self buttonClick:self.titleView.subviews[index]];
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tagClick
{
    WRXTagsViewController *tagsVc = [[WRXTagsViewController alloc] init];
    tagsVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tagsVc animated:YES];
}

@end
