//
//  BaseViewController.h
//  MyApp
//
//  Created by StephenChen on 2016/10/28.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewModel.h"

@interface BaseViewController : UIViewController<LSNetworkStatus,ReqResult>

@property (nonatomic, strong) UserModel *userModel;

#pragma mark - 网络

/**
 *  获取网络当前状态
 */
- (NetworkType)getNetWorkStatus;

#pragma mark - 状态栏和导航栏

/**
 *  隐藏或显示导航栏
 */
- (void)hideNavBar:(BOOL)isHide animated:(BOOL)animation;

/**
 *  隐藏或显示状态栏
 */
- (void)hideStatusBar:(BOOL)isHide;

#pragma mark - 悬浮view

/**
 *  提醒悬浮View
 */
- (void)showLoadingView:(NSString *)msg;

/**
 *  成功悬浮View
 */
- (void)showSuccessView:(NSString *)msg;

/**
 *  失败悬浮View
 */
- (void)showErrorView:(NSString *)msg;

/**
 *  移除悬浮View
 */
- (void)dismissLoadingView;

#pragma mark - 跳转

/**
 *  跳转到Ctrl
 */
- (void)goCtrlWithBoardName:(NSString *)name andCtrlID:(NSString*)ctrlID;

/**
 *  跳转到Ctrl
 */
- (void)goCtrlWithIdentifier:(NSString *)segueId;

/**
 *  返回上层Ctrl
 */
- (void)backToPreviousCtrl;

/**
 *  返回根Ctrl
 */
- (void)backToRootCtrl;

@end
