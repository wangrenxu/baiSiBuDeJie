//
//  WRXVoiceView.m
//  项目配置01
//
//  Created by wang on 16/2/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXVoiceView.h"
#import <UIImageView+WebCache.h>
#import "WRXWordTopic.h"
@interface WRXVoiceView ()

@property (weak, nonatomic) IBOutlet UILabel *playCountLable;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLable;

@end

@implementation WRXVoiceView


- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
}

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setTopic:(WRXWordTopic *)topic
{
    _topic = topic;
    [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage]];
    NSInteger minute = topic.voicetime.integerValue/60;
    NSInteger second = topic.voicetime.integerValue%60;
    self.voiceTimeLable.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    self.playCountLable.text = [NSString stringWithFormat:@"%@播放",topic.playcount];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
