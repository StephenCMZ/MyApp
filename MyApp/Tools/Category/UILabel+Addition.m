//
//  UILabel+Addition.m
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

/**
 设置内容
 
 @param text  内容
 @param dText 默认
 */
- (void)setText:(NSString *)text default:(NSString *)dText{
    self.text = [text length] ? text : dText;
}

@end
