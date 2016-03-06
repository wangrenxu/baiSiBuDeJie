//
//  WRXPictureView.m
//  项目配置01
//
//  Created by wang on 16/1/28.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXPictureView.h"
#import <UIImageView+WebCache.h>
#import "WRXWordTopic.h"
#import "WRXProgressView.h"
@interface WRXPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@property (weak, nonatomic) IBOutlet WRXProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIImageView *placeHolderImageView;

@end

@implementation WRXPictureView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
}
+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject ];
}

- (void)setTopic:(WRXWordTopic *)topic
{
    _topic = topic;
    self.progressView.progress = _topic.progress;
    self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",100 * _topic.progress];
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        self.placeHolderImageView.hidden = NO;
       CGFloat progress = 1.0 * receivedSize/expectedSize;
        _topic.progress = progress;
        self.progressView.progress =  progress;
        self.progressView.roundedCorners = 5;
        self.progressView.progressLabel.text = [[NSString stringWithFormat:@"%.0f%%",100 * progress] stringByReplacingOccurrencesOfString:@"-" withString:@""];//用空代替“-”
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        self.placeHolderImageView.hidden = YES;
    }];
    self.gifImageView.hidden = !topic.is_gif;
    self.seeBigButton.hidden = !topic.isBigImage;
}
@end
