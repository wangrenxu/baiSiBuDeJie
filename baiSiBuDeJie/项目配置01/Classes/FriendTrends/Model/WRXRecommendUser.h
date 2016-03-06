//
//  WRXRecommendUser.h
//  项目配置01
//
//  Created by wang on 16/1/10.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRXRecommendUser : NSObject
/** 用户的呢称 */
@property (nonatomic, copy) NSString *screen_name;
/** 关注数 */
@property (nonatomic, copy) NSString *fans_count;
/** 头像的URL */
@property (nonatomic, copy) NSString *header;


@end
