//
//  UIScrollView+Addition.m
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "UIScrollView+Addition.h"

@implementation UIScrollView (Addition)

/**
 显示顶部刷新
 */
- (void)showHeaderWithTarget:(id)target andAction:(SEL)action{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target
                                                                     refreshingAction:action];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}

/**
 显示或隐藏顶部刷新
 */
- (void)showHeader:(BOOL)show{
    if (self.mj_header){
        self.mj_header.hidden = !show;
    }
}

/**
 显示底部加载
 */
- (void)showFooterWithTarget:(id)target andAction:(SEL)action{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target
                                                                              refreshingAction:action];
    self.mj_footer = footer;
}

/**
 显示或隐藏底部加载
 */
- (void)showFooter:(BOOL)show{
    if (self.mj_footer) {
        self.mj_footer.hidden = !show;
    }
}

@end
