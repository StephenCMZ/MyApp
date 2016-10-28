//
//  LSFileManager.h
//  LSFileManager
//
//  Created by StephenChen on 14/12/18.
//  Copyright (c) 2014年 Lansion. All rights reserved.
//

#import <Foundation/Foundation.h>

enum LSDirectory {
    HOME_DIR,
    DOC_DIR,
    CACHE_DIR,
    LIB_DIR,
    TMP_DIR
};

@interface LSFileManager : NSObject

+ (BOOL) setUp;

+ (NSString*) getDir:(enum LSDirectory) dir;

+ (NSArray*) listFolder:(enum LSDirectory) dir path:(NSString*) path;

+ (BOOL) deleteFile:(NSString *)filePath under:(enum LSDirectory)dir;

+ (BOOL) isExisted:(NSString *)filePath under:(enum LSDirectory)dir;

+ (BOOL) createFolder:(NSString*)folderName under:(enum LSDirectory)dir;

+ (NSString*) writeNSData:(NSData*) data toFile:(NSString*)filePath under:(enum LSDirectory)dir;
+ (NSData*) readNSDataFile:(NSString*)filePath under:(enum LSDirectory)dir;

+ (NSString*) writeNSArray:(NSArray*) data toFile:(NSString*)filePath under:(enum LSDirectory)dir;
+ (NSArray*) readNSArrayFile:(NSString*)filePath under:(enum LSDirectory)dir;
+ (NSMutableArray*) readNSMutableArrayFile:(NSString*)filePath under:(enum LSDirectory)dir;

+ (NSString*) writeNSDictionary:(NSDictionary*) data toFile:(NSString*)filePath under:(enum LSDirectory)dir;
+ (NSDictionary*) readNSDictionaryFile:(NSString*)filePath under:(enum LSDirectory)dir;
+ (NSMutableDictionary*) readNSMutableDictionaryFile:(NSString*)filePath under:(enum LSDirectory)dir;

@end
