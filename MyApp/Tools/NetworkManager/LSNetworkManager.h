//
//  LSNetworkManager.h
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSBaseRequest.h"

typedef enum : NSUInteger {
    Unavail, //未知
    Mobile,  //移动
    Wifi,    //wifi
} NetworkType;

@protocol LSNetworkStatus <NSObject>

- (void)netWorkStatus: (NetworkType)networkType;

@end

@interface LSNetworkManager : NSObject

/**
 初始化
 */
+ (BOOL)setUp;

/**
 设置网络状态代理
 */
+ (void)setNetworkStatusHandler:(NSObject<LSNetworkStatus>*) statusHandler;

/**
 获取当前网络状态
 */
+ (NetworkType)getNetworkStatus;

/**
 发送请求
 */
+ (void)send:(LSBaseRequest *)request;

/**
 取消请求
 */
+ (void)cancelReq;


/**
 上传文件

 @param paramDic   参数
 @param requestURL 请求URL
 @param filePath   文件路径
 @param fileType   文件类型
 @param success    成功block
 @param failure    失败block

 @return 上传进度
 */
+ (NSProgress *)uploadFileWithOption:(NSDictionary *)paramDic
                       withInferface:(NSString*)requestURL
                            filePath:(NSString *)filePath
                            fileType:(NSString *)fileType
                       uploadSuccess:(void (^)(id responseObject))success
                       uploadFailure:(void (^)(NSError *error))failure;


/**
 下载文件

 @param paramDic   参数
 @param requestURL 请求URL
 @param savedPath  文件保存路径
 @param success    成功block
 @param failure    失败block

 @return 下载进度
 */
+ (NSProgress *)downloadFileWithOption:(NSDictionary *)paramDic
                         withInferface:(NSString*)requestURL
                             savedPath:(NSString*)savedPath
                       downloadSuccess:(void (^)(NSURL *filePath, id responseObject))success
                       downloadFailure:(void (^)(NSError *error))failure;

@end
