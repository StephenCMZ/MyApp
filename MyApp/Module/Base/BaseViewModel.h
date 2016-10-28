//
//  BaseViewModel.h
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@protocol ReqResult<NSObject>
- (void)reqResult:(BaseModel *) result andTag:(int)tag;
@end

@interface BaseViewModel : NSObject<LSNetworkResponser>

@property (nonatomic,strong) id<ReqResult> responser;
@property (nonatomic,strong) BaseModel *reqModel;

/**
 *  发送请求
 */
- (void)goReq:(LSBaseRequest*)request;

/**
 *  取消请求
 */
- (void)cancelReq;

/**
 *  请求出错
 */
- (void)failureReq;

@end
