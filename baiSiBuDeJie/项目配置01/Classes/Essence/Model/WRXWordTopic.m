//
//  WRXWordTopic.m
//  项目配置01
//
//  Created by wang on 16/1/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXWordTopic.h"
#import <MJExtension.h>
#import "WRXComment.h"

@implementation WRXWordTopic

{
   CGFloat _cellHeight;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"smallImage":@"image0",
             @"middleImage":@"image2",
             @"largeImage":@"image1",
             @"ID" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt" : @"WRXComment"};//告诉系统，top_cmt数组里放WRXComment模型
}
- (NSString *)create_time
{
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:_create_time];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *com = [calendar components:unit fromDate:date toDate:now options:0];
    
    if ([date isThisYear]) {//今年
        
        if ([date isYesterday]) {//昨天
             formatter.dateFormat = @"HH:mm:ss";
            return [NSString stringWithFormat:@"昨天 %@",[formatter stringFromDate:date]];
            
        }else if ([date isToday]){//今天
            
                if (com.hour >= 1) {//大于1小时
                    return [NSString stringWithFormat:@"%zd小时前",com.hour];
                }else if (com.minute >= 1){
                    return [NSString stringWithFormat:@"%zd分钟前",com.minute];
                }else{
                    return [NSString stringWithFormat:@"刚刚"];
                }
        }else{//不是昨天和今天
            formatter.dateFormat =  @"MM-dd HH:mm:ss";
            return [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
        }
    }else{//不是今年
        return _create_time;
    }
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {//只计算一次cell的高度
        
        CGFloat contentLableY = 40 + 10 + 10;
        //CGFloat contentLableH = [topic.text boundingRectWithSize:CGSizeMake(WRXScreenW - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{@"NSFontAttributeName":[UIFont systemFontOfSize:14]} context:nil].size.height;//用来计算多行文字的高度，option一般传NSStringDrawingUsesLineFragmentOrigin，context传nil.
        CGFloat contentLableH = [self.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WRXScreenW - 40, MAXFLOAT )].height;
        CGFloat bottomViewH = 44;
        CGFloat margin = 10;
        CGFloat cellH = contentLableY + contentLableH + bottomViewH + margin + margin;
        _cellHeight = cellH;
   
    if (self.type == WRXTopicTypePicture) {
        CGFloat pictureViewW = WRXScreenW - 40;
        CGFloat pictureViewH = self.height * pictureViewW/self.width;
      
        if (pictureViewH > WRXScreenH) {
            pictureViewH = 200;
            self.bigImage = YES;
        }
       _cellHeight += pictureViewH + 10 ;
    }else if (self.type == WRXTopicTypeVoice){
    
        CGFloat pictureViewW = WRXScreenW - 40;
        CGFloat pictureViewH = self.height * pictureViewW/self.width;
        _cellHeight += pictureViewH + 10 ;
    }else if (self.type == WRXTopicTypeVideo){
        
        CGFloat pictureViewW = WRXScreenW - 40;
        CGFloat pictureViewH = self.height * pictureViewW/self.width;
         _cellHeight += pictureViewH + 10 ;
    }
        
        if (self.top_cmt.count) {
            NSString *topComment = @"最热评论";
            CGFloat topCommentH = [topComment boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
            WRXComment *comment = (WRXComment *)[self.top_cmt firstObject];
            CGFloat commentH = [comment.content boundingRectWithSize:CGSizeMake(WRXScreenW - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;//注意：此方法用来计算多行文字高度，options一般传NSStringDrawingUsesLineFragmentOrigin
            _cellHeight += commentH + topCommentH + 10;
        }

}
    
    
    return _cellHeight;

}
@end
