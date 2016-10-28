//
//  UIView+Addition.h
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)

/**
 左边距
 */
@property(nonatomic) CGFloat left;

/**
 右边距
 */
@property(nonatomic) CGFloat right;

/**
 上边距
 */
@property(nonatomic) CGFloat top;

/**
 下边距
 */
@property(nonatomic) CGFloat bottom;

/**
 宽度
 */
@property(nonatomic) CGFloat width;

/**
 高度
 */
@property(nonatomic) CGFloat height;

/**
 设置边框及其颜色

 @param width 边框大小
 @param color 边框颜色
 */
- (void)setViewBorderWidth:(CGFloat)width andColor:(UIColor *)color;

/**
 设置边框弧度

 @param radius 弧度大小
 */
- (void)setViewBorderRadius:(CGFloat)radius;


/**
 底部显示一条黑线
 */
- (void)showBottomBlackLine;

@end
