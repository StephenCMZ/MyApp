//
//  UIScrollView+Addition.h
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface UIScrollView (Addition)

/**
 显示顶部刷新
 */
- (void)showHeaderWithTarget:(id)target andAction:(SEL)action;

/**
 显示或隐藏顶部刷新
 */
- (void)showHeader:(BOOL)show;

/**
 显示底部加载
 */
- (void)showFooterWithTarget:(id)target andAction:(SEL)action;

/**
 显示或隐藏底部加载
 */
- (void)showFooter:(BOOL)show;

@end
