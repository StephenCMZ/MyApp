//
//  LSNetworkManager.m
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "LSNetworkManager.h"

static LSNetworkManager* mNetwork;
static NSObject<LSNetworkStatus> *mStatusHandler;

@interface LSNetworkManager()

@property(nonatomic, strong) AFHTTPSessionManager *httpManager;

@end

@implementation LSNetworkManager

/**
 初始化
 */
+ (BOOL)setUp{
    
    if (!mNetwork) {
        mNetwork = [[LSNetworkManager alloc]init];
        mNetwork.httpManager = [AFHTTPSessionManager manager];
        mNetwork.httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil];
        mNetwork.httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        mNetwork.httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [self reach];
    }
    return YES;
}

/**
 设置网络状态代理
 */
+ (void)setNetworkStatusHandler:(NSObject<LSNetworkStatus>*) statusHandler{
    mStatusHandler = statusHandler;
}

/**
 获取当前网络状态
 */
+ (NetworkType)getNetworkStatus{
    if ([AFNetworkReachabilityManager sharedManager].reachableViaWiFi) {
        return Wifi;
    }else if([AFNetworkReachabilityManager sharedManager].reachableViaWWAN){
        return Mobile;
    }else{
        return Unavail;
    };
}

/**
 发送请求
 */
+ (void)send:(LSBaseRequest *)request{
    if (!mNetwork) {
        return;
    }
    switch (request.reqType) {
        case GET:
            [self Get:request];
            break;
        case POST:
            [self Post:request];
            break;
        case POST_FILE:
            [self PostFile:request];
        default:
            break;
    }
}

/**
 取消请求
 */
+ (void)cancelReq{
    [[mNetwork.httpManager operationQueue] cancelAllOperations];
}


/**
 Get请求
 */
+ (void)Get:(LSBaseRequest*)request{
    
    NSString* path = (request.reqPath == nil)? @"": request.reqPath;
    NSString* url = [NSString stringWithFormat:@"%@%@", request.baseUrl, path];
    
    [mNetwork.httpManager GET:url parameters:request.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (request.responser != nil) {
            NSError *error = nil;
            NSData *responseData = responseObject;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
            [request.responser baseSuccess:responseDic withTag:request.tag];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (request.responser != nil) {
            [request.responser baseFailure:error withTag:request.tag];
        }
        
    }];
    
}

/**
 Post请求
 */
+ (void)Post:(LSBaseRequest*)request{
    
    NSString* path = (request.reqPath == nil)? @"": request.reqPath;
    NSString* url = [NSString stringWithFormat:@"%@%@", request.baseUrl, path];
    
    [mNetwork.httpManager POST:url parameters:request.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (request.responser != nil) {
            NSError *error = nil;
            NSData *responseData = responseObject;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
            [request.responser baseSuccess:responseDic withTag:request.tag];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (request.responser != nil) {
            [request.responser baseFailure:error withTag:request.tag];
        }
        
    }];
}


/**
 post文件
 */
+ (void)PostFile:(LSBaseRequest*)request{
    
    NSString *path = (request.reqPath == nil)? @"": request.reqPath;
    NSString *url = [NSString stringWithFormat:@"%@%@", request.baseUrl, path];
    
    [LSNetworkManager uploadFileWithOption:request.params withInferface:url filePath:request.filePath fileType:request.fileType uploadSuccess:^(id responseObject) {
        
        if (request.responser != nil) {
            NSError *error = nil;
            NSData *responseData = responseObject;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
            [request.responser baseSuccess:responseDic withTag:request.tag];
        }
        
    } uploadFailure:^(NSError *error) {
        
        if (request.responser != nil) {
            [request.responser baseFailure:error withTag:request.tag];
        }
        
    }];
}

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
                       uploadFailure:(void (^)(NSError *error))failure{
    
    if(![filePath length] || ![requestURL length] || ![fileType length]){
        // 直接失败
        NSLog(@"filePath,requestURL and fileType can not be nil");
        return nil;
    }
    
    NSString *fileName = @"fileName";
    
    NSMutableURLRequest *mRequest = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:requestURL parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:KEY_FILE fileName:fileName mimeType:fileType error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFHTTPResponseSerializer *respSerializer = [AFHTTPResponseSerializer serializer];
    respSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", nil];
    manager.responseSerializer = respSerializer;
    
    NSTimer *timer;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:mRequest progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [timer invalidate];
            failure(error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            [timer invalidate];
            NSError *error = nil;
            NSData *responseData = responseObject;
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
            success(responseDic);
        }
    }];
    
    [uploadTask resume];
    
    return [manager uploadProgressForTask:uploadTask];
}


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
                       downloadFailure:(void (^)(NSError *error))failure{
    
    if(![requestURL length] || ![savedPath length]){
        // 直接失败
        NSLog(@"requestURL and savedPath can not be nil");
        return nil;
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    
    NSURLSessionDownloadTask *downLoadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:savedPath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            failure(error);
        }else{
            success(filePath,response);
        }
        
    }];
    
    [downLoadTask resume];
    
    return [manager uploadProgressForTask:downLoadTask];
    
}

#pragma mark - helper

/**
 更新当前网络状态
 */
+ (void)reach{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // wifi
     */
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (mStatusHandler == nil) {
            return;
        }
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            case AFNetworkReachabilityStatusUnknown:
                [mStatusHandler netWorkStatus:Unavail];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [mStatusHandler netWorkStatus:Wifi];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [mStatusHandler netWorkStatus:Mobile];
                break;
            default:
                break;
        }
    }];
}

@end
