//
//  WRXTabBar.m
//  项目配置01
//
//  Created by wang on 16/1/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXTabBar.h"
#import "WRXPublishView.h"
@interface WRXTabBar()

@property (weak, nonatomic) UIButton *button;
@end

@implementation WRXTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button = button;
        [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        button.size = button.currentImage.size;
        [self addSubview:button];
    }
    return self;
}

- (void)publishClick
{
    WRXPublishView *publish = [WRXPublishView publishView];
    publish.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:publish];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.button.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    CGFloat tabBarButtonW = self.width/5;
    CGFloat tabBarButtonH = self.height;
    CGFloat tabBarButtonY = 0;
     NSInteger index = 0;
    for (UIView *tabBarButton in self.subviews) {
        
        if ([tabBarButton isMemberOfClass:NSClassFromString(@"UITabBarButton")]) {
            tabBarButton.frame = CGRectMake(index * tabBarButtonW, tabBarButtonY, tabBarButtonW, tabBarButtonH);
            index++;
            if (index == 2) index++;
        }
    }
    
    
}
@end
