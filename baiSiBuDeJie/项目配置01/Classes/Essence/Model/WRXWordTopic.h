//
//  WRXWordTopic.h
//  项目配置01
//
//  Created by wang on 16/1/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRXWordTopic : NSObject
/** 顶的数量*/
@property (nonatomic, copy) NSString *ding;
/** 踩的数量*/
@property (nonatomic, copy) NSString *cai;
/** 转发数*/
@property (nonatomic, copy) NSString *repost;
/** 评论数*/
@property (nonatomic, copy) NSString *comment;
/** 头像的URL*/
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的正文*/
@property (nonatomic, copy) NSString *text;
/** 发帖时间*/
@property (nonatomic, copy) NSString *create_time;
/** 发帖人呢称*/
@property (nonatomic, copy) NSString *name;
/** 是否是新浪的认证用户*/
@property (nonatomic, assign,getter=isSina_v) BOOL sina_v;
/** 帖子的类型*/
@property (nonatomic, assign)  WRXTopicType type;
/** 图片高度*/
@property (nonatomic, assign) CGFloat height;
/** 图片宽度*/
@property (nonatomic, assign) CGFloat width;
/** 是否为动态图*/
@property (nonatomic, assign) BOOL is_gif;
/** 小图片的URL*/
@property (nonatomic, copy) NSString *smallImage;
/** 中图片的URL*/
@property (nonatomic, copy) NSString *middleImage;
/** 大图片的URL*/
@property (nonatomic, copy) NSString *largeImage;
/** 播放次数*/
@property (nonatomic, copy) NSString *playcount;
/** 声音时长*/
@property (nonatomic, copy) NSString *voicetime;
/** 视频时长*/
@property (nonatomic, copy) NSString *videotime;
/** 最热评论数组*/
@property (nonatomic, strong) NSArray *top_cmt;
/** 帖子id*/
@property (nonatomic, copy) NSString *ID;










/**————————————————————————————————————————————额外的属性————————————————————————————————————————————*/
/** cell的高度*/
@property (nonatomic, assign ,readonly) CGFloat cellHeight;
/** 是否为大图*/
@property (nonatomic, assign,getter=isBigImage) BOOL bigImage;
/** 进度值*/
@property (nonatomic, assign) CGFloat progress;
@end
