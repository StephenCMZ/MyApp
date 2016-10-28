//
//  BaseModel.m
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"code":@"Code",
             @"reqInfo":@"Info",};
}

@end
