//
//  WRXPictureView.h
//  项目配置01
//
//  Created by wang on 16/1/28.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WRXWordTopic;

@interface WRXPictureView : UIView
/** 模型数据*/
@property (nonatomic, strong) WRXWordTopic *topic;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
+ (instancetype)pictureView;
@end
