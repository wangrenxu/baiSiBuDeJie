//
//  UIBarButtonItem+WRXExtension.h
//  项目配置01
//
//  Created by wang on 16/1/9.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WRXExtension)

+ (instancetype)ItemWithNormalImage:(NSString *)normalImage highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;

@end
