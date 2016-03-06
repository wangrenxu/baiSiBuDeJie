//
//  WRXNavigationController.m
//  项目配置01
//
//  Created by wang on 16/1/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXNavigationController.h"

@implementation WRXNavigationController
/**
 *  拦截所有的push操作
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    if (self.childViewControllers.count > 1) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    self.hidesBarsOnSwipe = YES;
}
@end
