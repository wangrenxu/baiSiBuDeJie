//
//  WRXRecommendCategory.h
//  项目配置01
//
//  Created by wang on 16/1/10.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRXRecommendCategory : NSObject
/** 类别的id*/
@property (nonatomic, copy) NSString *id;
/** 类别对应的应用数*/
@property (nonatomic, copy) NSString *count;
/** 类别名称*/
@property (nonatomic, copy) NSString *name;

/**-------------------- 其他属性---------------------*/
@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, assign) NSInteger currentPage;

@end
