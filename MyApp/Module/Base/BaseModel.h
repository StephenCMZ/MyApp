//
//  BaseModel.h
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    REQ_SUCC,
    REQ_FAIL,
    REQ_UNAVAIL,
} ResultType;

@interface BaseModel : NSObject

/**
 *  成功或失败
 */
@property (nonatomic ,assign) ResultType result;

/**
 *  请求返回码
 */
@property (nonatomic ,strong) NSString *code;

/**
 *  请求结果消息
 */
@property (nonatomic ,strong) NSString *reqInfo;

@end
