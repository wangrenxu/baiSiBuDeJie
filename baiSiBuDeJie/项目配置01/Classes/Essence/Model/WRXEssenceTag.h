//
//  WRXEssenceTag.h
//  项目配置01
//
//  Created by wang on 16/1/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRXEssenceTag : NSObject
/** 标签的名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 头像的URL */
@property (nonatomic, copy) NSString *image_list;
/** 订阅的数量 */
@property (nonatomic, copy) NSString *sub_number;

@end
