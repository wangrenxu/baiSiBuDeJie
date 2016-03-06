//
//  WRXPushGuideView.m
//  项目配置01
//
//  Created by wang on 16/1/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXPushGuideView.h"

@implementation WRXPushGuideView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}

+ (instancetype)pushGuideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+ (void)showPushGuideView
{
   NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] valueForKey:@"key"];
    if (![currentVersion isEqualToString:sanboxVersion]) {
        WRXPushGuideView *view = [self pushGuideView];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        view.frame = window.bounds;
        [window addSubview:view];
        [[NSUserDefaults standardUserDefaults] setValue:currentVersion forKey:@"key"];
    }
}
@end
