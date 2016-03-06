//
//  WRXComment.h
//  项目配置01
//
//  Created by wang on 16/2/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WRXUser;
@interface WRXComment : NSObject
/** 评论的内容*/
@property (nonatomic, copy) NSString *content;
/** 评论的用户*/
@property (nonatomic, strong) WRXUser *user;

@end
