//
//  UITabBar+Addition.h
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Addition)

/**
 显示小红点

 @param index 位置
 */
- (void)showBadgeOnItemIndex:(int)index;


/**
 隐藏小红点

 @param index 位置
 */
- (void)hideBadgeOnItemIndex:(int)index;

@end
