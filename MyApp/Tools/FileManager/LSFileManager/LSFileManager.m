//
//  LSFileManager.m
//  LSFileManager
//
//  Created by StephenChen on 14/12/18.
//  Copyright (c) 2014年 Lansion. All rights reserved.
//

#import "LSFileManager.h"

@interface LSFileManager()

@property (nonatomic) NSFileManager* fileManager;

@property (nonatomic) NSString* homeDir;
@property (nonatomic) NSArray* docDir;
@property (nonatomic) NSArray* cacheDir;
@property (nonatomic) NSArray* libDir;
@property (nonatomic) NSString* tmpDir;

@end

static LSFileManager * manager;

@implementation LSFileManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fileManager = [[NSFileManager alloc] init];
    }
    return self;
}

+ (BOOL) setUp {
    
    if (manager == nil) {
        manager = [[LSFileManager alloc] init];
        
        manager.homeDir = NSHomeDirectory();
        manager.docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        manager.cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        manager.libDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        manager.tmpDir = NSTemporaryDirectory();
    }
    
    return YES;
}

+ (NSString*) getDir:(enum LSDirectory) dir {
    switch (dir) {
        case DOC_DIR:
            return [manager.docDir objectAtIndex:0];
        case CACHE_DIR:
            return [manager.cacheDir objectAtIndex:0];
        case LIB_DIR:
            return [manager.libDir objectAtIndex:0];
        case TMP_DIR:
            return manager.tmpDir;
        case HOME_DIR:
            return manager.homeDir;
        default:
            return manager.homeDir;
    }
    return nil;
}

+ (NSArray*) listFolder:(enum LSDirectory) dir path:(NSString*) path {
    NSString *docDir;
    if (path == nil || (path != nil && [path length] == 0)) {
        docDir = [LSFileManager getDir:dir];
    } else {
        docDir = [NSString stringWithFormat:@"%@/%@", [LSFileManager getDir:dir], path];
    }
    NSArray* list = [manager.fileManager subpathsAtPath:docDir];
    return list;
}

+ (BOOL) deleteFile:(NSString *)filePath under:(enum LSDirectory)dir {
    NSString *path = nil;
    if (filePath == nil || (filePath != nil && [filePath length] == 0)) {
        return NO;
    } else {
        path = [NSString stringWithFormat:@"%@/%@", [LSFileManager getDir:dir], filePath];
    }
//    NSLog(@"delete file %@", path);
    BOOL re = [manager.fileManager removeItemAtPath:path error:nil];
    return re;
}

+ (BOOL) isExisted:(NSString *)filePath under:(enum LSDirectory)dir {
    NSString *path = nil;
    if (filePath == nil || (filePath != nil && [filePath length] == 0)) {
        return NO;
    } else {
        NSString *dirPath = [LSFileManager getDir:dir];
        path = [dirPath stringByAppendingPathComponent:filePath];
    }
    return [manager.fileManager fileExistsAtPath:path];
}

+ (BOOL) createFolder:(NSString*) folderName under:(enum LSDirectory)dir {
    NSString *dirPath = [LSFileManager getDir:dir];
    NSString *path = [dirPath stringByAppendingPathComponent:folderName];
    return [manager.fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (NSString*) writeNSData:(NSData*) data toFile:(NSString*)filePath under:(enum LSDirectory)dir {
    NSString *dirPath = [LSFileManager getDir:dir];
    NSString *path = [dirPath stringByAppendingPathComponent:filePath];
    BOOL re = [data writeToFile:path atomically:YES];
    if (re) {
        return path;
    } else {
        return nil;
    }
}

+ (NSData*) readNSDataFile:(NSString*)filePath under:(enum LSDirectory)dir {
    NSString *dirPath = [LSFileManager getDir:dir];
    NSString *path = [dirPath stringByAppendingPathComponent:filePath];
    NSData* data = [NSData dataWithContentsOfFile:path];
    return data;
}

+ (NSString*) writeNSArray:(NSArray*) data toFile:(NSString*)filePath under:(enum LSDirectory)dir {
    NSString *dirPath = [LSFileManager getDir:dir];
    NSString *path = [dirPath stringByAppendingPathComponent:filePath];
    BOOL re = [data writeToFile:path atomically:YES];
    if (re) {
        return path;
    } else {
        return nil;
    }
}

+ (NSArray*) readNSArrayFile:(NSString*)filePath under:(enum LSDirectory)dir {
    NSString *dirPath = [LSFileManager getDir:dir];
    NSString *path = [dirPath stringByAppendingPathComponent:filePath];
    NSArray* data = [NSArray arrayWithContentsOfFile:path];
    return data;
}

+ (NSMutableArray*) readNSMutableArrayFile:(NSString*)filePath under:(enum LSDirectory)dir {
    NSString *dirPath = [LSFileManager getDir:dir];
    NSString *path = [dirPath stringByAppendingPathComponent:filePath];
    NSMutableArray* data = [NSMutableArray arrayWithContentsOfFile:path];
    return data;
}

+ (NSString*) writeNSDictionary:(NSDictionary*) data toFile:(NSString*)filePath under:(enum LSDirectory)dir {
    NSString *dirPath = [LSFileManager getDir:dir];
    NSString *path = [dirPath stringByAppendingPathComponent:filePath];
    BOOL re = [data writeToFile:path atomically:YES];
    if (re) {
        return path;
    } else {
        return nil;
    }
}

+ (NSDictionary*) readNSDictionaryFile:(NSString*)filePath under:(enum LSDirectory)dir {
    NSString *dirPath = [LSFileManager getDir:dir];
    NSString *path = [dirPath stringByAppendingPathComponent:filePath];
    NSDictionary* data = [NSDictionary dictionaryWithContentsOfFile:path];
    return data;
}

+ (NSMutableDictionary*) readNSMutableDictionaryFile:(NSString*)filePath under:(enum LSDirectory)dir {
    NSString *dirPath = [LSFileManager getDir:dir];
    NSString *path = [dirPath stringByAppendingPathComponent:filePath];
    NSMutableDictionary* data = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    return data;
}

+ (BOOL) checkSetUp {
    if (manager == nil) {
//        NSLog(@"LS FileManager hasn't been initialized");
    }
    return manager != nil;
}

@end
