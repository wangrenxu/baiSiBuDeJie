//
//  WRXCategoryCell.h
//  项目配置01
//
//  Created by wang on 16/1/10.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRXRecommendCategory.h"
@class WRXRecommendCategory;
@interface WRXCategoryCell : UITableViewCell
/** 类别模型*/
@property (nonatomic, strong) WRXRecommendCategory *category;
@end
