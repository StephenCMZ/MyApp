//
//  UIColor+Addition.m
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "UIColor+Addition.h"

@implementation UIColor (Addition)

/**
 根据RGB创建UIColor
 
 @param red   0—255 红色
 @param green 0—255 绿色
 @param blue  0—255 蓝色
 
 @return UIColor
 */
+ (UIColor *)colorByRed:(int)red green:(int)green blue:(int)blue{
    return [UIColor colorByRed:red green:green blue:blue alpha:1.0f];
}

/**
 根据RGB创建UIColor
 
 @param red   0—255 红色
 @param green 0—255 绿色
 @param blue  0—255 蓝色
 @param alpha 0-1   透明度
 
 @return UIColor
 */
+ (UIColor *)colorByRed:(int)red green:(int)green blue:(int)blue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:alpha];
}

/**
 根据十六进制颜色创建UIColor
 
 @param hexColor 十六进制颜色值 eg：0xFFFFFF
 
 @return UIColor
 */
+ (UIColor *)colorByHex:(NSInteger)hexColor{
    return [UIColor colorByHex:hexColor alpha:1.0f];
}

/**
 根据十六进制颜色创建UIColor

 @param hexColor 十六进制颜色值 eg：0xFFFFFF
 @param alpha    透明度 0-1

 @return UIColor
 */
+ (UIColor *)colorByHex:(NSInteger)hexColor alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((float) ((hexColor & 0xFF0000) >> 16)) / 0xFF
                           green:((float) ((hexColor & 0xFF00)   >> 8))  / 0xFF
                            blue:((float)  (hexColor & 0xFF))            / 0xFF
                           alpha:alpha];
}

/**
 根据UIColor返回RGB数组
 
 @param color UIColor
 
 @return RGB数组
 */
+ (NSArray *)colorToRBGA:(UIColor *)color{
    
    CGColorRef colorRef = [color CGColor];
    int numComponents = (int)CGColorGetNumberOfComponents(colorRef);
    NSArray *arr = nil;
    
    if (numComponents == 4) {
        int rValue, gValue, bValue;
        float aValue;
        const CGFloat *components = CGColorGetComponents(colorRef);
        rValue = (int)(components[0] * 255);
        gValue = (int)(components[1] * 255);
        bValue = (int)(components[2] * 255);
        aValue = components[3];
        
        arr = @[[NSNumber numberWithInt:rValue],
                [NSNumber numberWithInt:gValue],
                [NSNumber numberWithInt:bValue],
                [NSNumber numberWithFloat:aValue]];
    }
    
    return arr;
}


@end
