//
//  Config.h
//  MyApp
//
//  Created by StephenChen on 2016/10/27.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#ifndef Config_h
#define Config_h

// log
#ifdef DEBUG
    #define NSLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
    #define NSLog(...)
#endif

// back button
#define BACK_TITLE  @" " //按钮标题
#define BACK_IMAGE  [UIImage imageNamed:@""] //按钮图片

// colors
#define COLOR_NAV_BAR      [UIColor whiteColor] //导航栏
#define COLOR_NAV_TITLE    [UIColor whiteColor] //导航栏标题
#define COLOR_NAV_BACKBTN  [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000] //导航栏返回按钮

// size
#define SIZE_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width //屏幕宽
#define SIZE_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height //屏幕高

#define SIZE_FONT_BIG      [UIFont systemFontOfSize:16] //字体大
#define SIZE_FONT_MID      [UIFont systemFontOfSize:14] //字体中
#define SIZE_FONT_SMA      [UIFont systemFontOfSize:12] //字体小

// strings
#define VERSION_APP [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] //app版本
#define VERSION_IOS [[[UIDevice currentDevice] systemVersion] floatValue] //系统版本

#define APPKEY_UMENG   @"" //友盟appkey
#define APPKEY_WECHAT  @"" //微信appkey
#define APPKEY_QQ      @"" //qqAppkey
#define APPKEY_WEIBO   @"" //微博Appkey

#endif
