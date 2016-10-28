//
//  UIButton+Addition.h
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Addition)

/**
 设置边框及其颜色
 
 @param width 边框大小
 @param color 边框颜色
 */
- (void)setButtonBorderWidth:(CGFloat)width andColor:(UIColor *)color;

/**
 设置边框弧度
 
 @param radius 弧度大小
 */
- (void)setButtonBorderRadius:(CGFloat)radius;


/**
 设置标题在图片正下方
 */
- (void)setButtonTitleAndImageShowInCenter;

@end
