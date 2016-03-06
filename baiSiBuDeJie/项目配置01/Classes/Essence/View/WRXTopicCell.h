//
//  WRXTopicCell.h
//  项目配置01
//
//  Created by wang on 16/1/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRXWordTopic.h"
#import "WRXSeeBigPictureViewController.h"//有耦合性

@class WRXWordTopic;
@interface WRXTopicCell : UITableViewCell
/** 帖子模型*/
@property (nonatomic, strong) WRXWordTopic *topic;
/** 看大图控制器*/
@property (nonatomic, strong) WRXSeeBigPictureViewController *seeBigPictureViewController;
+ (instancetype)topicCell;
@end
