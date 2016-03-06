//
//  WRXProgressView.m
//  项目配置01
//
//  Created by wang on 16/2/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXProgressView.h"

@implementation WRXProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    self.userInteractionEnabled = NO;//为了使点击事件传递给后面的控件
}
@end
