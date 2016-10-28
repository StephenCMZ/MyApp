//
//  BaseViewController.m
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self config];
}

/**
 配置
 */
- (void)config {
    self.userModel = [UserModel shareInstance];
    [LSNetworkManager setNetworkStatusHandler:self];
}

#pragma mark - network

/**
 网络状态改变时回调
 */
- (void)netWorkStatus:(NetworkType)networkType{
    switch (networkType) {
        case Unavail: {
            NSLog(@"NetworkStatus Unavail");
            break;
        }
        case Mobile: {
            NSLog(@"NetworkStatus Mobile");
            break;
        }
        case Wifi: {
            NSLog(@"NetworkStatus Wifi");
            break;
        }
        default: {
            break;
        }
    }
}


/**
 获取当前网络状态
 */
- (NetworkType)getNetWorkStatus{
    return [LSNetworkManager getNetworkStatus];
}


/**
 请求结果，由子类决定如何处理结果
 */
-(void)reqResult:(BaseModel *)result andTag:(int)tag{}


#pragma mark - loadingView

/**
 提醒悬浮View
 */
- (void)showLoadingView:(NSString *)msg{
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setFont:SIZE_FONT_MID];
    [SVProgressHUD showWithStatus:msg];
}

/**
 成功悬浮View
 */
- (void)showSuccessView:(NSString *)msg{
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setFont:SIZE_FONT_MID];
    [SVProgressHUD showSuccessWithStatus:msg];
}

/**
 失败悬浮View
 */
- (void)showErrorView:(NSString *)msg{
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setFont:SIZE_FONT_MID];
    [SVProgressHUD showErrorWithStatus:msg];
}

/**
 移除悬浮View
 */
- (void)dismissLoadingView{
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(disView) userInfo:nil repeats:NO];
}

/**
 移除悬浮View
 */
- (void)disView{
    [SVProgressHUD dismiss];
}


#pragma mark - go and back

/**
 跳到 ctrl
 */
- (void)goCtrlWithBoardName:(NSString *)name andCtrlID:(NSString*)ctrlID{
    UIStoryboard *board = [UIStoryboard storyboardWithName:name bundle:nil];
    UIViewController *ctrl = [board instantiateViewControllerWithIdentifier:ctrlID];
    [self.navigationController pushViewController:ctrl animated:YES];
}

/**
 跳到 ctrl
 */
- (void)goCtrlWithIdentifier:(NSString *)segueId{
    [self performSegueWithIdentifier:segueId sender:self];
}

/**
 返回上层 ctrl
 */
- (void)backToPreviousCtrl{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 返回根 ctrl
 */
- (void)backToRootCtrl{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - navbar and statusbar

/**
 *  隐藏或显示导航栏
 */
- (void)hideNavBar:(BOOL)isHide animated:(BOOL)animation{
    [self.navigationController setNavigationBarHidden:isHide animated:animation];
}

/**
 *  隐藏或显示状态栏
 */
- (void)hideStatusBar:(BOOL)isHide{
    [[UIApplication sharedApplication] setStatusBarHidden:isHide withAnimation:UIStatusBarAnimationNone];
}

@end
