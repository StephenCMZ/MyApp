//
//  ProFileManager.m
//  StephenSchema
//
//  Created by StephenChen on 16/3/23.
//  Copyright © 2016年 Lansion. All rights reserved.
//

#import "ProFileManager.h"
#import "ProFolderName.h"

@implementation ProFileManager

/**
 *  初始化
 */
+ (BOOL)setUp{
    [LSProfileManager setUp];
    return YES;
}

#pragma mark - personal

/**
 *  加载个人文件夹
 */
+ (BOOL)loadProfile:(NSString *)name password:(NSString*)password andHeaderId:(NSString *)headId{
    
    [LSProfileManager loadProfile:name password:password andHeaderId:headId];
    
    NSArray *folderArr = @[FOLDER_TEMP];
    for (NSString *folderName in folderArr) {
        [LSProfileManager createFolder:folderName];
    }
    
    return YES;
}

/**
 *  获取上次登录信息
 */
+ (NSDictionary *)getLastLoginInfo{
    return [LSProfileManager lastLogin];
}

/**
 *  删除上次登录信息
 */
+ (void)deleteLastLoginInfo{
    [LSProfileManager resetLastLoginPsw];
}

#pragma mark - tempImg

/**
 *  临时图片
 */
+ (NSString *)saveTempImgWithName:(NSString *)name andImg:(UIImage *)img{
    NSData *imageData = UIImagePNGRepresentation(img);
    NSString *file = [ProFileManager getTempFileByFileName:name];
    return [LSFileManager writeNSData:imageData toFile:file under:DOC_DIR];
}

/**
 *  获取图片路径
 */
+ (NSString *)getTempImagPath{
    return [NSString stringWithFormat:@"%@/%@/tempImage",[LSFileManager getDir:DOC_DIR],[LSProfileManager getFolderPath:FOLDER_TEMP]];
}


#pragma mark - helper

/**
 *  获取临时文件路径
 */
+ (NSString *)getTempFileByFileName:(NSString *)name{
    return [NSString stringWithFormat:@"%@/%@",[LSProfileManager getFolderPath:FOLDER_TEMP],name];
}

@end
