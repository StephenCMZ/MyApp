//
//  ProFileManager.h
//  StephenSchema
//
//  Created by StephenChen on 16/3/23.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSProfileManager.h"

@interface ProFileManager : NSObject

/**
 *  初始化
 */
+ (BOOL)setUp;

#pragma mark - personal

/**
 *  加载个人文件夹
 */
+ (BOOL)loadProfile:(NSString *)name password:(NSString*)password andHeaderId:(NSString *)headId;

/**
 *  获取上次登录信息
 */
+ (NSDictionary *)getLastLoginInfo;

/**
 *  删除上次登录信息
 */
+ (void)deleteLastLoginInfo;

#pragma mark - tempImg

/**
 *  临时图片
 */
+ (NSString *)saveTempImgWithName:(NSString *)name andImg:(UIImage *)img;

/**
 *  获取图片路径
 */
+ (NSString *)getTempImagPath;

#pragma mark - helper

/**
 *  获取临时文件路径
 */
+ (NSString *)getTempFileByFileName:(NSString *)name;


@end
