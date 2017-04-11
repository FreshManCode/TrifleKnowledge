//
//  FileManager.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/19.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "BaseSingleton.h"

@interface FileManager : BaseSingleton
+ (instancetype)shareManager;


- (void)writeToFileWith:(NSData *)imageData;

- (NSData *)readImageDataFile;
//Documents 目录路径
- (NSString *)getDocumentsDirectory;
//Library   目录路径
- (NSString *)getLibraryDirectory;
//Temporary 目录路径
- (NSString *)getTemporaryDirectory;
//Cache     目录路径
- (NSString *)getCacheDirectory;

//根据名字创建文件夹
- (NSString *)createDocumentsName:(NSString *)aName;

//创建文件
- (NSString *)createFilePath:(NSString *)aPath;

- (BOOL)writeToFileWithFileName:(NSString *)aName;

- (BOOL)readFileWithFileName:(NSString *)aName;

- (BOOL)deleteFileWithFileName:(NSString *)aName;

@end
