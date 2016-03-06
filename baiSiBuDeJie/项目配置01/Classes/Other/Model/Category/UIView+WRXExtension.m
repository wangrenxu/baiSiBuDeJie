//
//  UIView+WRXExtension.m
//  项目配置01
//
//  Created by wang on 16/1/8.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIView+WRXExtension.h"

@implementation UIView (WRXExtension)

- (void)setX:(CGFloat)x
{
    CGRect temp = self.frame;
    temp.origin.x = x;
    self.frame = temp;
}

- (void)setY:(CGFloat)y
{
    CGRect temp = self.frame;
    temp.origin.y = y;
    self.frame = temp;
}

- (void)setWidth:(CGFloat)width
{
    CGRect temp = self.frame;
    temp.size.width = width;
    self.frame = temp;
}

- (void)setHeight:(CGFloat)height
{
    CGRect temp = self.frame;
    temp.size.height = height;
    self.frame = temp;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint temp = self.center;
    temp.x = centerX;
    self.center = temp;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint temp = self.center;
    temp.y = centerY;
    self.center = temp;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect temp = self.frame;
    temp.size = size;
    self.frame = temp;
    
}

- (CGSize)size
{
    return self.frame.size;
}
@end
