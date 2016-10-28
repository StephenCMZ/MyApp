//
//  UIColor+Addition.h
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Addition)

/**
 根据RGB创建UIColor
 
 @param red   0—255 红色
 @param green 0—255 绿色
 @param blue  0—255 蓝色
 
 @return UIColor
 */
+ (UIColor *)colorByRed:(int)red green:(int)green blue:(int)blue;

/**
 根据RGB创建UIColor
 
 @param red   0—255 红色
 @param green 0—255 绿色
 @param blue  0—255 蓝色
 @param alpha 0-1   透明度

 @return UIColor
 */
+ (UIColor *)colorByRed:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha;


/**
 根据十六进制颜色创建UIColor

 @param hexColor 十六进制颜色值 eg：0xFFFFFF

 @return UIColor
 */
+ (UIColor *)colorByHex:(NSInteger)hexColor;


/**
 根据十六进制颜色创建UIColor
 
 @param hexColor 十六进制颜色值 eg：0xFFFFFF
 @param alpha    透明度 0-1
 
 @return UIColor
 */
+ (UIColor *)colorByHex:(NSInteger)hexColor alpha:(CGFloat)alpha;


/**
 根据UIColor返回RGB数组

 @param color UIColor

 @return RGBA数组
 */
+ (NSArray *)colorToRBGA:(UIColor *)color;

@end
