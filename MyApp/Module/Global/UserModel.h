//
//  UserModel.h
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

@property (nonatomic,assign) BOOL isAutoLogin;  //是否自动登录
@property (nonatomic,strong) NSString *token;  //token


/**
 获取单例
 */
+ (instancetype)shareInstance;


/**
 清理数据
 */
- (void)cleanAllData;

@end
