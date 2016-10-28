//
//  UserModel.m
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

static UserModel *userModel = nil;

/**
 获取单例
 */
+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userModel = [[UserModel alloc]init];
    });
    
    return userModel;
    
}

/**
 清理数据
 */
- (void)cleanAllData{
   _token = @"";
}


@end
