//
//  BaseViewModel.m
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "BaseViewModel.h"

static LSBaseRequest* lastRequest; //记录上次请求
static int requestTimes;           //记录请求次数

@implementation BaseViewModel{
    NSDictionary *reqInfoDic; //请求信息
    BOOL isReLogin;           //重新登录标识
}

/**
 初始化
 */
- (instancetype)init{
    
    if (self = [super init]) {
        reqInfoDic = @{
                       @"PAR0000":@"参数错误",
                       @"NET0000":@"请检查网络连接状态",
                       @"UN00000":@"请求失败",
                       @"RC00000":@"请求成功",
                       @"RC20004":@"token错误",};
    }
    
    return self;
}

#pragma mark - requset

/**
 发送请求
 */
- (void)goReq:(LSBaseRequest*)request{
    
    request.responser = self;
    requestTimes = 0;
    lastRequest = request;
    [self reGoReq:request];
}


/**
 重新发送请求
 */
- (void)reGoReq:(LSBaseRequest*)request{
    
    if ([LSNetworkManager getNetworkStatus] != Unavail) {
        [request go];
    }else if (_responser){//网络故障
        if (!_reqModel) _reqModel = [[BaseModel alloc]init];
        _reqModel.code = @"NET0000";
        _reqModel.result = REQ_UNAVAIL;
        _reqModel.reqInfo = reqInfoDic[_reqModel.code];
        [_responser reqResult:_reqModel andTag:request.tag];
    };
}


/**
 取消请求
 */
- (void)cancelReq{
    [LSNetworkManager cancelReq];
}

#pragma mark - requset result

/**
 请求失败
 */
- (void)failureReq{
    
    if (!_reqModel) _reqModel = [[BaseModel alloc]init];
    _reqModel.code = @"PAR0000";
    _reqModel.result = REQ_FAIL;
    _reqModel.reqInfo = reqInfoDic[_reqModel.code];
    if(_responser) [_responser reqResult:_reqModel andTag:lastRequest.tag];
}


/**
 请求成功回调
 */
- (void)baseSuccess:(id)responseObject withTag:(int)tag{
    [self success:responseObject withTag:tag];
}


/**
 请求失败回调
 */
- (void)baseFailure:(NSError *)error withTag:(int)tag{
    [self failure:error withTag:tag];
}


/**
 请求成功处理
 */
- (void)success:(id)responseObject withTag:(int)tag{
    NSLog(@"success >>> %@",responseObject);
    
    if (!responseObject) {
        _reqModel = [[BaseModel alloc]init];
        _reqModel.result = REQ_SUCC;
        _reqModel.reqInfo = [reqInfoDic[_reqModel.code] length] ? reqInfoDic[_reqModel.code] : @"未知错误";
    }else if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = responseObject;
        if (!_reqModel) _reqModel = [[BaseModel alloc]init];
        _reqModel = [_reqModel mj_setKeyValues:dic];
        _reqModel.result = REQ_SUCC;
        _reqModel.reqInfo = [reqInfoDic[_reqModel.code] length] ? reqInfoDic[_reqModel.code] : @"未知错误";
    }
    
    if (_responser){
        if (isReLogin) {
            [self setReLoginResultWith:responseObject andTag:tag];
        }else if ([_reqModel.code isEqualToString:@"RC20004"]) {
            [self setReLoginWithTag:tag];
            
        }else{
            [_responser reqResult:_reqModel andTag:tag];
        }
    }
    
}


/**
 请求失败处理
 */
- (void)failure:(NSError *)error withTag:(int)tag{
    NSLog(@"error >>> %@",error);
    
    if (requestTimes < 2 && lastRequest) {
        requestTimes++;
        [self reGoReq:lastRequest];
    }else{
        
        isReLogin = NO;
        
        if (!_reqModel) _reqModel = [[BaseModel alloc]init];
        _reqModel.code = @"UN00000";
        _reqModel.result = REQ_FAIL;
        _reqModel.reqInfo = reqInfoDic[_reqModel.code];
        if (_responser) [_responser reqResult:_reqModel andTag:tag];
    }
    
}

#pragma mark - relogin


/**
 登录请求
 */
- (void)loginWithPhoneNo:(NSString *)phoneNo andPsw:(NSString *)psw{
    
    NSLog(@"重新登录");
    
    isReLogin = YES;
    
    LSBaseRequest *req = [[LSBaseRequest alloc]init:URL_LOGIN method:POST];
    [req.params setObject:phoneNo forKey:KEY_PHONENO];
    [req.params setObject:[psw base64EnCode] forKey:KEY_PASSWORD];
    [req.params setObject:@"aibaby_read" forKey:KEY_CLIENT];
    
    requestTimes = 2;
    req.responser = self;
    [self reGoReq:req];
}


/**
 设置和处理重新登录请求
 */
- (void)setReLoginWithTag:(int)tag{
    
    NSLog(@"token错误");
    NSString *psw, *account;
    NSDictionary *lastLoginDic = [ProFileManager getLastLoginInfo];
    if (lastLoginDic) {
        account = lastLoginDic[@"LASTLOGIN_PROFILE"];
        psw = lastLoginDic[@"LASTLOGIN_PSW"];
    }
    
    if ([account length] && [psw length]) {
        [self loginWithPhoneNo:account andPsw:psw];
    }else{
        _reqModel.reqInfo = @"账号异常，请注销后重新登录";
        if(_responser) [_responser reqResult:_reqModel andTag:tag];
    }
}


/**
 处理重启登录后结果
 */
- (void)setReLoginResultWith:(id)responseObject andTag:(int)tag{
    
    isReLogin = NO;
    
    if ([_reqModel.code isEqualToString:@"RC00000"]) {
        NSLog(@"重新登录成功");
        NSString *newToken = ((NSDictionary *)responseObject)[@"Params"][@"token"];
        if ([newToken length]) {
            [UserModel shareInstance].token =  newToken;
            [lastRequest.params setObject:newToken forKey:KEY_TOKEN];
            [self goReq:lastRequest];
        }else{
            _reqModel.reqInfo = @"账号异常，请注销后重新登录";
            if(_responser) [_responser reqResult:_reqModel andTag:tag];
        }
        
    }else{
        NSLog(@"重新登录失败");
        _reqModel.reqInfo = @"账号异常，请注销后重新登录";
        if(_responser) [_responser reqResult:_reqModel andTag:tag];
    }
}



@end
