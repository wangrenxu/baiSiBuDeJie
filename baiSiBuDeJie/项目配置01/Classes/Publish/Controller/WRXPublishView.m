//
//  WRXPublishView.m
//  项目配置01
//
//  Created by wang on 16/2/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXPublishView.h"
#import "WRXVerticalButton.h"
#import <POP.h>

@interface WRXPublishView ()

@property (weak, nonatomic) UIImageView *slogan;
@end

@implementation WRXPublishView

+ (instancetype)publishView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];

}
- (void)awakeFromNib {
    

    [UIApplication sharedApplication].keyWindow.rootViewController.view.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    NSInteger cols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat leftMargin = 20;
    CGFloat middleMargin = (WRXScreenW - (2 * leftMargin + cols * buttonW))/(cols - 1);
    CGFloat firstButtonH = (WRXScreenH - 2 * buttonH)/2;
    
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    //添加按钮
    for (int i = 0; i < 6; i++) {
       WRXVerticalButton *button = [WRXVerticalButton buttonWithType:UIButtonTypeCustom];
        button.tag = i + 1;
        CGFloat buttonX = (i % 3) * (buttonW + middleMargin) + leftMargin;
        CGFloat buttonY = firstButtonH + i/3 * buttonH;
//        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);//pop动画会改变控件的frame，所以不用设置
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //动画
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.springSpeed = 10;
        animation.springBounciness = 10;
        animation.beginTime = CACurrentMediaTime() + 0.05 * i;
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY - WRXScreenH, buttonW, buttonH)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [button pop_addAnimation:animation forKey:nil];
    }
    
    //添加标语
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    self.slogan = imageView;
    CGFloat endX = (WRXScreenW - imageView.width)/2;
    imageView.x = endX;
    imageView.y = WRXScreenH * 0.2 - WRXScreenH;
    
    POPSpringAnimation *sloganAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    sloganAnimation.springBounciness = 10;
    sloganAnimation.springSpeed = 10;
    sloganAnimation.beginTime = CACurrentMediaTime() + 0.05 * self.subviews.count;//此处需要保证时间比最后一个按钮执行动画的时间要晚
//    sloganAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(endX, WRXScreenH * 0.2 - WRXScreenH, imageView.image.size.width, imageView.image.size.height)];pop动画不设置fromValue时，默认是所在的位置
    sloganAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(endX, WRXScreenH * 0.2, imageView.image.size.width, imageView.image.size.height)];
    [sloganAnimation setCompletionBlock:^(POPAnimation *animation , BOOL finished) {
        
        self.userInteractionEnabled = YES;
    }];
    [imageView pop_addAnimation:sloganAnimation forKey:nil];
   
    [self addSubview:imageView];
    
    
}

- (void)buttonClick:(WRXVerticalButton *)button
{
    self.userInteractionEnabled = NO;
    [UIApplication sharedApplication].keyWindow.rootViewController.view.userInteractionEnabled = NO;
    for (int i = 2; i < self.subviews.count - 1; i++) {
        UIView *view = self.subviews[i];
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.springSpeed = 10;
        animation.springBounciness = 10;
        animation.beginTime = CACurrentMediaTime() + 0.05 * i;
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(view.x, view.y, view.width, view.height)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(view.x, view.y + WRXScreenH, view.width, view.height)];
        [view pop_addAnimation:animation forKey:nil];
    }
    POPBasicAnimation *sloganAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    sloganAnimation.duration = 0.25;
    sloganAnimation.beginTime = CACurrentMediaTime() + 0.05 * self.subviews.count ;
    sloganAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(self.slogan.x,  WRXScreenH, self.slogan.width, self.slogan.height)];
    [sloganAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        
        [self removeFromSuperview];
        [UIApplication sharedApplication].keyWindow.rootViewController.view.userInteractionEnabled = YES;
            switch (button.tag) {
                case 1:
                    WRXLog(@"发视频");
                    break;
                case 2:
                    WRXLog(@"发图片");
                    break;
                case 3:
                    WRXLog(@"发段子");
                    break;
                case 4:
                    WRXLog(@"发声音");
                    break;
                case 5:
                    WRXLog(@"审帖");
                    break;
                default:
                    WRXLog(@"离线下载");
                    break;
            }

        
    }];
    [self.slogan pop_addAnimation:sloganAnimation forKey:nil];

    
    
}


- (IBAction)cancel:(UIButton *)sender {
    self.userInteractionEnabled = NO;
    for (int i = 2; i < self.subviews.count - 1; i++) {
        UIView *view = self.subviews[i];
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.springSpeed = 10;
        animation.springBounciness = 10;
        animation.beginTime = CACurrentMediaTime() + 0.05 * i;
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(view.x, view.y, view.width, view.height)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(view.x, view.y + WRXScreenH, view.width, view.height)];
        [view pop_addAnimation:animation forKey:nil];
    }
        POPBasicAnimation *sloganAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
        sloganAnimation.duration = 0.25;
        sloganAnimation.beginTime = CACurrentMediaTime() + 0.05 * self.subviews.count ;
        sloganAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(self.slogan.x,  WRXScreenH, self.slogan.width, self.slogan.height)];
        [sloganAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
            [self removeFromSuperview];
            
            [UIApplication sharedApplication].keyWindow.rootViewController.view.userInteractionEnabled = YES;
            
        }];
        [self.slogan pop_addAnimation:sloganAnimation forKey:nil];
        
      

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
