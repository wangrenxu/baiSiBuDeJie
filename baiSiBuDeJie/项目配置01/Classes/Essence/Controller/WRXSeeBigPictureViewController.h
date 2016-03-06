//
//  WRXSeeBigPictureViewController.h
//  项目配置01
//
//  Created by wang on 16/2/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WRXWordTopic;
@interface WRXSeeBigPictureViewController : UIViewController

/** 帖子模型*/
@property (nonatomic, strong) WRXWordTopic *topic;
/** 用来显示大图片的控件*/
@property (weak, nonatomic) UIImageView *imageView;

@end
