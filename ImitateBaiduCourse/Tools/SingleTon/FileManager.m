//
//  FileManager.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/19.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+ (instancetype)shareManager {
    static FileManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[FileManager alloc]init];
    });
    return _manager;
}

- (void)writeToFileWith:(NSData *)imageData {
    if (![self readImageDataFile]) {
        [imageData writeToFile:[self documentsPath:ImagePath] atomically:YES];
    }
}

//根据文件名返回documents下路径
- (NSString *)documentsPath:(NSString *)fileName {
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    return [documents stringByAppendingString:fileName];
}

- (NSData *)readImageDataFile {
    NSString *filePath = [self documentsPath:ImagePath];
    NSData *imageData  = [[NSData alloc]initWithContentsOfFile:filePath];
    return imageData;
}

- (NSString *)getDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

- (NSString *)getLibraryDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

- (NSString *)getCacheDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

- (NSString *)getTemporaryDirectory{
    return NSTemporaryDirectory();
}

- (NSString *)createDocumentsName:(NSString *)aName {
    NSString *documensPath = [self getDocumentsDirectory];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documensPath stringByAppendingPathComponent:aName];
    //创建目录
    BOOL res = [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"文件夹创建成功");
    } else {
        NSLog(@"文件夹创建失败");
    }
    return (res ? testDirectory :@"");
}
- (NSString *)createFilePath:(NSString *)aPath {
    NSString *testDicectory = [self createDocumentsName:@"测试"];
    NSString *testPath = [testDicectory stringByAppendingPathComponent:aPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res = [fileManager createFileAtPath:testPath contents:nil attributes:nil];
    if (res) {
        NSLog(@"文件创建成功:\n%@",testPath);
    } else {
        NSLog(@"文件创建失败");
    }
    return (res ? testPath :@"" );
}
#warning 说明:写入文件之前,先创立文件路径
- (BOOL)writeToFileWithFileName:(NSString *)aName {
    NSString *filePath = [self createFilePath:aName];
    NSString *content  = @"测试写入内容哈哈哈哈哈哈哈,二狗子别闹";
    BOOL res  = [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"文件写入成功");
        return YES;
    } else {
        NSLog(@"文件写入失败");
        return NO;
    }
}

- (BOOL)readFileWithFileName:(NSString *)aName {
    NSString *filePath = [self createDocumentsName:aName];
    NSString *content  = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if (content && [content length]>0) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)deleteFileWithFileName:(NSString *)aName {
    NSString *filePath = [self createFilePath:aName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res  =[fileManager removeItemAtPath:filePath error:nil];
    NSLog(@"文件是否存在:%@",[fileManager isExecutableFileAtPath:filePath] ? @"YES" :@"No");
    if (res) {
        NSLog(@"文件删除成功%@",aName);
        return YES;
    } else {
        NSLog(@"文件删除失败%@",aName);
        return NO;
    }
    
}




@end
