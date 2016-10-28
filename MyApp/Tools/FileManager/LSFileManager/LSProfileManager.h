//
//  LSProfileManager.h
//  LSProfileManager
//
//  Created by StephenChen on 14/12/19.
//  Copyright (c) 2014年 Lansion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LSFileManager.h"

@interface LSProfileManager : NSObject

+ (BOOL) setUp;

// profile operations
+ (NSDictionary*) listProfiles;
+ (NSDictionary*) lastLogin;
+ (BOOL) loadProfile:(NSString *)name password:(NSString*)password andHeaderId:(NSString *)headId;
+ (BOOL) deleteProfile:(NSString*)name;
+ (BOOL) resetLastLoginPsw;

+ (BOOL) createFolder:(NSString*)folderName;
+ (BOOL) deleteFolder:(NSString*)folderName;
+ (NSString*) getFolderPath:(NSString*)folderName;

// image, save and read
+ (NSString*) saveImage:(UIImage*)image;
+ (UIImage*) getImage:(NSString*)imageName;

// audio, save and read
+ (NSString*) saveAudio:(NSData*)audioDate;
+ (NSData*) getAudio:(NSString*)audioName;

// basic information management for profiles
+ (BOOL) setKey:(NSString*)key withValue:(NSObject*)value;
+ (NSObject*) getValueOfKey:(NSString*)key;

@end
