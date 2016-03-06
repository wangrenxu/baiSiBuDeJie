//
//  WRXTopicCell.m
//  项目配置01
//
//  Created by wang on 16/1/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXTopicCell.h"
#import <UIImageView+WebCache.h>
#import "WRXPictureView.h"
#import "WRXSeeBigPictureViewController.h"
#import "WRXVoiceView.h"
#import "WRXVideoView.h"
#import "WRXComment.h"
#import "WRXUser.h"

@interface WRXTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *VIPImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) WRXPictureView *pictureView;
@property (weak, nonatomic) WRXVoiceView *voiceView;
@property (weak, nonatomic) WRXVideoView *videoView;
@property (weak, nonatomic) IBOutlet UIView *topCommentView;
@property (weak, nonatomic) IBOutlet UILabel *topContentLable;
@end

@implementation WRXTopicCell

+ (instancetype)topicCell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTopic:(WRXWordTopic *)topic
{
    _topic = topic;
    
    self.VIPImageView.hidden = !topic.isSina_v;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLable.text = topic.name;
    self.timeLable.text = topic.create_time;
    self.contentLable.text = topic.text;
    [self.dingButton setTitle:[self count:topic.ding title:@"顶"] forState:UIControlStateNormal];
    [self.caiButton setTitle:[self count:topic.cai title:@"踩"] forState:UIControlStateNormal];
    [self.repostButton setTitle:[self count:topic.repost title:@"转发"] forState:UIControlStateNormal];
    [self.commentButton setTitle:[self count:topic.comment title:@"评论"] forState:UIControlStateNormal];
    
    //添加图片，视频，声音控件到cell的中间
    if (topic.type == WRXTopicTypePicture ) {
        if (!self.pictureView) {
            WRXPictureView *pictureView = [WRXPictureView pictureView];
            pictureView.contentImageView.userInteractionEnabled = YES;
            
            //给中间图片添加手势
            [pictureView.contentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)] ];
           
            self.pictureView = pictureView;
            [self.contentView addSubview:pictureView ];
            
        }
        if (topic.width && topic.height) {//高度和宽度有值，才需要设置
           
            CGFloat pictureViewW = WRXScreenW - 40;
            CGFloat tempHeight = topic.height * pictureViewW/topic.width;
            if (tempHeight > WRXScreenH) {//大图片
                tempHeight = 200;
                
                self.pictureView.contentImageView.contentMode = UIViewContentModeScaleAspectFill;
            }else{
                
                self.pictureView.contentImageView.contentMode = UIViewContentModeScaleToFill;
            }
            CGFloat pictureViewX = 10;
            [self layoutIfNeeded];
            CGFloat pictureViewY = CGRectGetMaxY(self.contentLable.frame) + 10;
            CGFloat pictureViewH= tempHeight;
            self.pictureView.frame = CGRectMake(pictureViewX, pictureViewY, pictureViewW, pictureViewH);

        }
        
        //传递模型，设置数据
        self.pictureView.topic = topic;
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (topic.type == WRXTopicTypeVoice){//声音
    
        if (!self.voiceView) {
           WRXVoiceView *voiceView = [WRXVoiceView voiceView];
            voiceView.voiceImageView.userInteractionEnabled = YES;
            
            //给中间图片添加手势
            [voiceView.voiceImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)] ];
            
            self.voiceView = voiceView;
            [self.contentView addSubview:voiceView ];
        }
        
        if (topic.width && topic.height) {
            
            CGFloat pictureViewW = WRXScreenW - 40;
            CGFloat tempHeight = topic.height * pictureViewW/topic.width;
            
            CGFloat pictureViewX = 10;
            [self layoutIfNeeded];
            CGFloat pictureViewY = CGRectGetMaxY(self.contentLable.frame) + 10;
            CGFloat pictureViewH= tempHeight;
            self.voiceView.frame = CGRectMake(pictureViewX, pictureViewY, pictureViewW, pictureViewH);
            

        }
                //传递模型，设置数据
        self.voiceView.topic = topic;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
    }else if (topic.type == WRXTopicTypeVideo){//视频
        
        if (!self.videoView) {
            WRXVideoView *videoView = [WRXVideoView videoView];
            videoView.videoImageView.userInteractionEnabled = YES;
            
            //给中间图片添加手势
            [videoView.videoImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)] ];
            
            self.videoView = videoView;
            [self.contentView addSubview:videoView ];
        }
        
        if (topic.width && topic.height) {
            
            CGFloat pictureViewW = WRXScreenW - 40;
            CGFloat tempHeight = topic.height * pictureViewW/topic.width;
            
            CGFloat pictureViewX = 10;
            [self layoutIfNeeded];
            CGFloat pictureViewY = CGRectGetMaxY(self.contentLable.frame) + 10;
            CGFloat pictureViewH= tempHeight;
            self.videoView.frame = CGRectMake(pictureViewX, pictureViewY, pictureViewW, pictureViewH);

        }
        
        //传递模型，设置数据
        self.videoView.topic = topic;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
    }else if (topic.type == WRXTopicTypeWord){
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;

    }
    
    if (topic.top_cmt.count) {
        self.topCommentView.hidden = NO;
        WRXComment *comment = [topic.top_cmt firstObject];
        self.topContentLable.text = [NSString stringWithFormat:@"%@ : %@",comment.user.username,comment.content];
    }else{
        self.topCommentView.hidden = YES;
    }
}

#pragma mark - 看大图
- (void)seeBigPicture
{
    WRXSeeBigPictureViewController *seeBigPicture = [[WRXSeeBigPictureViewController alloc] init];
    seeBigPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigPicture animated:YES completion:nil];
}



//数据处理
- (NSString *)count:(NSString *)count title:(NSString *)title
{
    NSString *string = nil;
    if (count.integerValue > 10000) {
        string = [NSString stringWithFormat:@"%.1f万",count.integerValue/10000.0];
    }else if (count.integerValue < 10000 && count.integerValue > 0){
        string = count;
    }else{
        string = title;
    }
    return string;
}


- (void)setFrame:(CGRect)frame
{
    CGFloat margin = 10;
    frame.origin.x = margin;
//    frame.size.width -= 2 * margin;
    frame.size.width = WRXScreenW - 2 * margin;
//    frame.size.height -= margin;
    frame.size.height = self.topic.cellHeight - margin;
    frame.origin.y += margin;
    [super setFrame:frame];
}


@end
