//
//  UIBarButtonItem+WRXExtension.m
//  项目配置01
//
//  Created by wang on 16/1/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIBarButtonItem+WRXExtension.h"

@implementation UIBarButtonItem (WRXExtension)
+ (instancetype)ItemWithNormalImage:(NSString *)normalImage highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    button.size = button.currentImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;

}
@end
