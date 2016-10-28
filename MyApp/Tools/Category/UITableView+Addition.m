//
//  UITableView+Addition.m
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "UITableView+Addition.h"

@implementation UITableView (Addition)

/**
 清理底部多余线条
 */
- (void)cleanFooter{
    self.tableFooterView = [[UIView alloc]init];
}

@end
