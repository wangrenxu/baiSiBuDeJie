//
//  WRXEssenceTagCell.m
//  项目配置01
//
//  Created by wang on 16/1/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXEssenceTagCell.h"
#import <UIImageView+WebCache.h>
#import "WRXEssenceTag.h"

@interface WRXEssenceTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLable;

@end

@implementation WRXEssenceTagCell

- (void)awakeFromNib {
    // Initialization code
//    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEssenceTag:(WRXEssenceTag *)essenceTag
{
    _essenceTag = essenceTag;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:essenceTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLable.text = essenceTag.theme_name;
    
    //数据处理
    NSString *subNumber = nil;
    if (essenceTag.sub_number.integerValue > 10000) {
        subNumber = [NSString stringWithFormat:@"%.1f万人关注",essenceTag.sub_number.integerValue/10000.0];
    }else{
        subNumber = [NSString stringWithFormat:@"%@人关注",essenceTag.sub_number];
    }
    self.subNumberLable.text = subNumber;
}
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    frame.origin.x = 5;
    frame.size.width = frame.size.width - 2 * frame.origin.x;
    [super setFrame:frame];
}
@end
