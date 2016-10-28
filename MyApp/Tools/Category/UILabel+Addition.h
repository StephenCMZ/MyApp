//
//  UILabel+Addition.h
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Addition)

/**
 设置内容

 @param text  内容
 @param dText 默认
 */
- (void)setText:(NSString *)text default:(NSString *)dText;

@end
