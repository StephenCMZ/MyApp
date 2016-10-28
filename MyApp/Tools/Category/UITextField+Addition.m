//
//  UITextField+Addition.m
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "UITextField+Addition.h"

@implementation UITextField (Addition)

/**
 设置提醒文字颜色
 
 @param color 颜色
 */
- (void)setPlaceholderColor:(UIColor *)color{
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

/**
 设置左边距
 
 @param leftWidth 边距大小
 */
- (void)setTextFieldLeftPadding:(CGFloat)leftWidth{
    CGRect frame = self.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}

/**
 设置右边距
 
 @param rightWidth 边距大小
 */
- (void)setTextFieldRightPadding:(CGFloat)rightWidth{
    CGRect frame = self.frame;
    frame.size.width = rightWidth;
    frame.origin.x = self.frame.size.width - frame.size.width;
    UIView *rightview = [[UIView alloc] initWithFrame:frame];
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = rightview;
}

@end
