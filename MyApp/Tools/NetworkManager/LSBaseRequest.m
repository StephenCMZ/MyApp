//
//  LSBaseRequest.m
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "LSBaseRequest.h"

@implementation LSBaseRequest

/**
 初始化
 
 @param reqPath 请求路径
 @param reqType 请求类型
 
 @return LSBaseRequest
 */
- (instancetype)init: (NSString*)reqPath method: (RequestType)reqType{
    self = [super init];
    if (self) {
        _params = [[NSMutableDictionary alloc]init];
        _baseUrl = BASE_URL;
        _reqPath = reqPath;
        _reqType = reqType;
    }
    return self;
}

/**
 发送请求
 */
- (void)go{
    [LSNetworkManager send:self];
}

@end
