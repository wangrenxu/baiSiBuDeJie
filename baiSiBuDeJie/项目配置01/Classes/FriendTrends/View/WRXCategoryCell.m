//
//  WRXCategoryCell.m
//  项目配置01
//
//  Created by wang on 16/1/10.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXCategoryCell.h"

@interface WRXCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UIView *separatorView;

@end

@implementation WRXCategoryCell

- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor clearColor];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.indicatorView.hidden = !selected;
    self.textLabel.textColor = selected? [UIColor redColor]:[UIColor blackColor];

    
}

- (void)setCategory:(WRXRecommendCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.height = self.textLabel.height - 2;
}
@end
