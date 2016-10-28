//
//  LSProfileManager.m
//  LSProfileManager
//
//  Created by StephenChen on 14/12/19.
//  Copyright (c) 2014年 Lansion. All rights reserved.
//


#import "LSProfileManager.h"

static NSString* KEY_PROFILENAME        = @"PROFILENAME";
static NSString* KEY_LASTLOGIN_PROFILE  = @"LASTLOGIN_PROFILE";
static NSString* KEY_LASTLOGIN_PSW      = @"LASTLOGIN_PSW";
static NSString* KEY_LASTLOGIN_HEADERID = @"LASTLOGIN_HEADER";
static NSString* profileHome            = @"profiles";
static NSString* profileList            = @"profiles/profiles.plist";
static NSString* lastLogin              = @"profiles/lastLogin.plist";

static NSString* imageFolder            = @"profiles/%@/images";
static NSString* audioFolder            = @"profiles/%@/audios";

static NSString* profileInfo            = @"profiles/%@/info.plist";

static NSString* extraFolder            = @"profiles/%@/%@";

static NSMutableDictionary *curProfile;

@implementation LSProfileManager

+ (BOOL) setUp {
    
    BOOL re = [LSFileManager setUp];
    
    if (!re)
        return re;
    
    re = [LSFileManager isExisted:profileList under:DOC_DIR];
    
    if (!re) {
        [LSFileManager createFolder:profileHome under:DOC_DIR];//创建程序文件夹
        [LSFileManager writeNSDictionary:[NSDictionary new] toFile:profileList under:DOC_DIR];//创建账户管理列表
        [LSFileManager writeNSDictionary:[NSDictionary new] toFile:lastLogin under:DOC_DIR];//创建上次账户记录文件
    }
    
    return YES;
}

//加载当前账户文件，并记录当前账户
+ (BOOL) loadProfile:(NSString *)name  password:(NSString*)password andHeaderId:(NSString *)headId{
    
    NSMutableDictionary* profiles = [LSProfileManager listProfilesForUpdate];
    
    if ([profiles objectForKey:name] == nil) {//用户不存在
        
        [LSProfileManager deleteHomeFolder:name];
        
        //在用户集列表中添加用户
        [profiles setValue:@"NO_ASSIGNED" forKey:name];
        [LSFileManager writeNSDictionary:profiles toFile:profileList under:DOC_DIR];
        
        //创建用户文件包
        [LSProfileManager createHomeFolder:name];
        
        //用户图片包
        NSString* imageFolderPath = [NSString stringWithFormat:imageFolder, name];
        [LSFileManager createFolder:imageFolderPath under:DOC_DIR];
        
        //用户语音包
        NSString* audioFolderPath = [NSString stringWithFormat:audioFolder, name];
        [LSFileManager createFolder:audioFolderPath under:DOC_DIR];
        
        //用户配置信息列表
        NSString* profileInfoPath = [NSString stringWithFormat:profileInfo, name];
        NSMutableDictionary *infoDict = [NSMutableDictionary new];
        [infoDict setObject:name forKey:KEY_PROFILENAME];
        [LSFileManager writeNSDictionary:infoDict toFile:profileInfoPath under:DOC_DIR];
        
    }
    
    NSString* profileInfoPath = [NSString stringWithFormat:profileInfo, name];
    curProfile = [LSFileManager readNSMutableDictionaryFile:profileInfoPath under:DOC_DIR];
    
    //上次登录信息
    NSMutableDictionary *lastLoginData = [NSMutableDictionary new];
    if ([name length]) [lastLoginData setObject:name forKey:KEY_LASTLOGIN_PROFILE];
    if ([password length]) [lastLoginData setObject:[password base64EnCode] forKeyedSubscript:KEY_LASTLOGIN_PSW];
    if ([headId length]){
        [lastLoginData setObject:headId forKey:KEY_LASTLOGIN_HEADERID];
    }else{
        [lastLoginData setObject:@"null" forKey:KEY_LASTLOGIN_HEADERID];
    }
    [LSFileManager writeNSDictionary:lastLoginData toFile:lastLogin under:DOC_DIR];
    
    return YES;
}

+ (BOOL) deleteProfile:(NSString*)name {
    
    NSMutableDictionary* profiles = [LSProfileManager listProfilesForUpdate];
    
    // delete before create
    [profiles removeObjectForKey:name];
    [LSProfileManager deleteHomeFolder:name];
    
    [LSFileManager writeNSDictionary:profiles toFile:profileList under:DOC_DIR]; // create a plist file store profile and username;
    return YES;
}

+ (BOOL) createFolder:(NSString*)folderName {
    
    NSString* extraFolderPath = [LSProfileManager getFolderPath:folderName];
    if (extraFolderPath == nil) {
        return NO;
    }
    
    if ([LSFileManager isExisted:extraFolderPath under:DOC_DIR]) {
        return YES;
    }
    
    return [LSFileManager createFolder:extraFolderPath under:DOC_DIR];
}

+ (BOOL) deleteFolder:(NSString*)folderName {
    
    NSString* extraFolderPath = [LSProfileManager getFolderPath:folderName];
    if (extraFolderPath == nil) {
        return NO;
    }
    return [LSFileManager deleteFile:extraFolderPath under:DOC_DIR];
}

+ (BOOL) resetLastLoginPsw{
    
    NSMutableDictionary *dic = [[self lastLogin]mutableCopy];
    [dic setObject:@"" forKey:KEY_LASTLOGIN_PSW];
    [LSFileManager writeNSDictionary:[dic copy] toFile:lastLogin under:DOC_DIR];
    
    return YES;
}

+ (NSString*) getFolderPath:(NSString*)folderName {
    if (curProfile == nil) {
        return nil;
    }
    
    NSString *profile = [curProfile valueForKey:KEY_PROFILENAME];
    if (profile == nil) {
        return nil;
    }
    return [NSString stringWithFormat:extraFolder,profile,folderName];
}

+ (NSString*) saveImage:(UIImage*)image{
    
    if (curProfile == nil) {
        return nil;
    }
    
    NSString *profile = [curProfile valueForKey:KEY_PROFILENAME];
    if (profile == nil) {
        return nil;
    }
    
    if (image == nil) {
        return nil;
    }
    
    NSData *imageData = nil;
    
    // get png format nsdata
    imageData = UIImagePNGRepresentation(image);
    
    if (imageData == nil || [imageData length] <= 0) {
        return nil;
    }
    
    NSString* imageName;
    NSDate* currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMddhhmmssSSS"];
    NSString* tempName = [[dateFormatter stringFromDate:currentDate] base64EnCode];
    imageName = [tempName stringByAppendingPathExtension:@"png"];
    
    //将图片写入指定路径
    NSString* imagePath = [NSString stringWithFormat: imageFolder,profile];
    NSString* filePath = [imagePath stringByAppendingPathComponent:imageName];
    NSString* path = [LSFileManager writeNSData:imageData toFile:filePath under:DOC_DIR];
    
    if (path == nil) {
        return nil;
    }
    return imageName;
}

+ (UIImage*) getImage:(NSString *)imageName{
    
    if (curProfile == nil) {
        return nil;
    }
    
    NSString *profile = [curProfile valueForKey:KEY_PROFILENAME];
    if (profile == nil) {
        return nil;
    }
    
    if (imageName == nil) {
        return nil;
    }
    
    NSString* imagePath = [NSString stringWithFormat: imageFolder,profile];
    NSString* filePath = [imagePath stringByAppendingPathComponent:imageName];
    
    BOOL isExist = [LSFileManager isExisted:filePath under:DOC_DIR];
    
    if (!isExist) {
//        NSLog(@"can not find image of %@.", imageName);
        return nil;
    }
    
    NSData* imageData = [LSFileManager readNSDataFile:filePath under:DOC_DIR];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    if (image == nil) {
//        NSLog(@"Error when read the image");
        return nil;
    }
    return image;
}

+ (NSString*) saveAudio:(NSData*)audioDate{
    if (curProfile == nil) {
        return nil;
    }
    
    NSString *profile = [curProfile valueForKey:KEY_PROFILENAME];
    if (profile == nil) {
        return nil;
    }
    
    if (audioDate == nil||[audioDate length]<=0) {
//        NSLog(@"Can not create audio file.");
        return nil;
    }
    
    NSString* audioName;
    NSDate* currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMddhhmmssSSS"];
    NSString* tempName = [[dateFormatter stringFromDate:currentDate] base64EnCode];
    audioName = [tempName stringByAppendingPathExtension:@"caf"];
    
    //将图片写入指定路径
    NSString* audioPath = [NSString stringWithFormat: audioFolder,profile];
    NSString* filePath = [audioPath stringByAppendingPathComponent:audioName];
    NSString* path = [LSFileManager writeNSData:audioDate toFile:filePath under:DOC_DIR];
    
    if (path == nil) {
        return nil;
    }
    
    return audioName;
}

+ (NSData*) getAudio:(NSString*)audioName{
    
    if (curProfile == nil) {
        return nil;
    }
    
    NSString *profile = [curProfile valueForKey:KEY_PROFILENAME];
    if (profile == nil) {
        return nil;
    }
    
    if (audioName == nil) {
        return nil;
    }
    
    NSString* audioPath = [NSString stringWithFormat: audioFolder,profile];
    NSString* filePath = [audioPath stringByAppendingPathComponent:audioName];
    
    BOOL isExist = [LSFileManager isExisted:filePath under:DOC_DIR];
    
    if (!isExist) {
//        NSLog(@"can not find audio of %@.", audioName);
        return nil;
    }
    
    NSData* audioData = [LSFileManager readNSDataFile:filePath under:DOC_DIR];
    
    if (audioData == nil) {
//        NSLog(@"Error when read the audio");
        return nil;
    }
    
    return audioData;
}

// basic information management for profiles
+ (BOOL) setKey:(NSString*)key withValue:(NSObject*)value{
    
    if (curProfile == nil) {
        return NO;
    }
    
    NSString *profile = [curProfile valueForKey:KEY_PROFILENAME];
    if (profile == nil) {
        return NO;
    }
    
    if (key == nil||key.length<=0) {
        return NO;
    }
   
    if (key == nil||value==nil||key.length<=0) {
        return NO;
    }
    
    
    NSString* profileInfoPath = [NSString stringWithFormat:profileInfo, profile];
    
    NSMutableDictionary* infoDictionary = [LSProfileManager listInfoFileForUpdate:profileInfoPath];
    
    if (infoDictionary == nil) {
//        NSLog(@"Can not fine info file of profileInfo");
        return NO;
    }
    
    [infoDictionary setObject:value forKey:key];
    [LSFileManager writeNSDictionary:infoDictionary toFile:profileInfoPath under:DOC_DIR];
    return YES;
}

+ (NSObject*) getValueOfKey:(NSString*)key {
    
    if (curProfile == nil) {
        return nil;
    }
    
    NSString *profile = [curProfile valueForKey:KEY_PROFILENAME];
    if (profile == nil) {
        return nil;
    }
    
    if (key == nil||key.length<=0) {
        return nil;
    }

    NSString* profileInfoPath = [NSString stringWithFormat:profileInfo, profile];
    
    NSDictionary* infoDictionary = [LSProfileManager listInfoFile:profileInfoPath];
    
    if (infoDictionary != nil) {
        return [infoDictionary objectForKey:key];
    }
    return nil;
}

// private
+ (BOOL) checkInfoFile:(NSString*) infoFile {
    return [LSFileManager isExisted:infoFile under:DOC_DIR];
}

+ (NSDictionary*) listInfoFile:(NSString*)infoFile {
    if ([LSProfileManager checkInfoFile:infoFile]) {
        return [LSFileManager readNSDictionaryFile:infoFile under:DOC_DIR];
    }
    return nil;
}

+ (NSMutableDictionary*) listInfoFileForUpdate:(NSString*)infoFile {
    if ([LSProfileManager checkInfoFile:infoFile]) {
        return [LSFileManager readNSMutableDictionaryFile:infoFile under:DOC_DIR];
    }
    return nil;
}


+ (NSDictionary*) listProfiles {
    NSDictionary* profiles = [LSFileManager readNSDictionaryFile:profileList under:DOC_DIR];
    return profiles;
}

+ (NSDictionary*) lastLogin{
    
    NSDictionary *dic = [LSFileManager readNSMutableDictionaryFile:lastLogin under:DOC_DIR];
    
    if (!dic) {
        return  nil;
    }
    
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
    [tempDic setObject:[tempDic[KEY_LASTLOGIN_PSW] base64DeCode] forKey:KEY_LASTLOGIN_PSW];
    
    return tempDic;
    
    
}

+ (NSMutableDictionary*) listProfilesForUpdate {
    NSMutableDictionary* profiles = [LSFileManager readNSMutableDictionaryFile:profileList under:DOC_DIR];
    return profiles;
}

+ (BOOL) checkPlist:(NSString*)name {
    NSDictionary *profiles = [LSProfileManager listProfiles];
    return [[profiles allKeys] containsObject:name];
}

+ (BOOL) checkHomeFolder:(NSString*)name {
    NSString *homeFolder = [profileHome stringByAppendingPathComponent:name];
    return [LSFileManager isExisted:homeFolder under:DOC_DIR];
}

+ (BOOL) createHomeFolder:(NSString*) name {
    NSString *homeFolder = [profileHome stringByAppendingPathComponent:name];
    if ([LSFileManager createFolder:homeFolder under:DOC_DIR]) {
        NSString* infoFile = [NSString stringWithFormat:profileInfo, name];
        infoFile = [LSFileManager writeNSDictionary:[NSDictionary new] toFile:infoFile under:DOC_DIR]; // create a plist file store profile and username;
        return infoFile == nil;
    };
    
    return NO;
}

+ (BOOL) deleteHomeFolder:(NSString*) name {
    NSString *homeFolder = [profileHome stringByAppendingPathComponent:name];
    return [LSFileManager deleteFile:homeFolder under:DOC_DIR];
}
@end
