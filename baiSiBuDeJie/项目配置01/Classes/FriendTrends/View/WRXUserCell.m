//
//  WRXUserCell.m
//  项目配置01
//
//  Created by wang on 16/1/10.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXUserCell.h"
#import "WRXRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface WRXUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLable;

@end
@implementation WRXUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRecommendUser:(WRXRecommendUser *)recommendUser
{
    _recommendUser = recommendUser;
    self.nameLable.text = recommendUser.screen_name;
    
    //数据处理
    NSString *fansCount = nil;
    if (recommendUser.fans_count.integerValue > 10000) {
        fansCount = [NSString stringWithFormat:@"%.1f万人关注",recommendUser.fans_count.integerValue/10000.0];
    }else{
        fansCount = [NSString stringWithFormat:@"%@人关注",recommendUser.fans_count];
    }
    self.fansCountLable.text = fansCount;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:recommendUser.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
@end
