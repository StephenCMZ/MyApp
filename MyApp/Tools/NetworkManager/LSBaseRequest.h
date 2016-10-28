//
//  LSBaseRequest.h
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    GET,        //get请求
    POST,       //post请求
    POST_FILE,  //post文件
} RequestType;

@protocol LSNetworkResponser <NSObject>

-(void) baseSuccess:(id)responseObject withTag:(int)tag;
-(void) baseFailure:(NSError*)error withTag:(int)tag;

@end

@interface LSBaseRequest : NSObject

@property (nonatomic,strong) id<LSNetworkResponser> responser; //请求代理
@property (nonatomic,assign) int tag;                          //请求标识
@property (nonatomic,assign) RequestType reqType;              //请求类型

@property (nonatomic,strong) NSString *baseUrl;                //请求URL
@property (nonatomic,strong) NSString *reqPath;                //请求路径
@property (nonatomic,strong) NSMutableDictionary *params;      //请求参数

@property (nonatomic,copy) NSString *filePath;                 //文件路径
@property (nonatomic,copy) NSString *fileType;                 //文件类型


/**
 初始化

 @param reqPath 请求路径
 @param reqType 请求类型
 
 @return LSBaseRequest
 */
- (instancetype)init: (NSString*)reqPath method: (RequestType)reqType;

/**
 发送请求
 */
- (void)go;

@end
