 //
//  WRXVideoView.m
//  项目配置01
//
//  Created by wang on 16/2/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXVideoView.h"
#import "WRXWordTopic.h"
#import <UIImageView+WebCache.h>

@interface WRXVideoView ()

@property (weak, nonatomic) IBOutlet UILabel *videoTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *playCountLable;

@end



@implementation WRXVideoView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
}

+ (instancetype)videoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setTopic:(WRXWordTopic *)topic
{
    _topic = topic;
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage]];
    NSInteger minute = topic.videotime.integerValue/60;
    NSInteger second = topic.videotime.integerValue%60;
    self.videoTimeLable.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
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
