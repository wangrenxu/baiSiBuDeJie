//
//  WRXVoiceView.h
//  项目配置01
//
//  Created by wang on 16/2/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WRXWordTopic;
@interface WRXVoiceView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
/** 帖子模型*/
@property (nonatomic, strong) WRXWordTopic *topic;
+ (instancetype)voiceView;
@end
