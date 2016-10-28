//
//  UITextField+Addition.h
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Addition)

/**
 设置提醒文字颜色

 @param color 颜色
 */
- (void)setPlaceholderColor:(UIColor *)color;

/**
 设置左边距

 @param leftWidth 边距大小
 */
- (void)setTextFieldLeftPadding:(CGFloat)leftWidth;

/**
 设置右边距

 @param rightWidth 边距大小
 */
- (void)setTextFieldRightPadding:(CGFloat)rightWidth;


@end
