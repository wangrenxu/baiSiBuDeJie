//
//  WRXLoginOrRegisterTextField.m
//  项目配置01
//
//  Created by wang on 16/1/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXLoginOrRegisterTextField.h"

@implementation WRXLoginOrRegisterTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setup
{
    self.tintColor = self.textColor;
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:[UIColor grayColor] forKey:NSForegroundColorAttributeName];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dictionary];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:@"placeholderLabel.color"];
   
   return  [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:@"placeholderLabel.color"];
   return  [super resignFirstResponder];
}
@end
