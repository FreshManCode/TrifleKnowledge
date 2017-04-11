//
//  SquareBaseModel.h
//
//  Created by  宇智波 on 16/8/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Server, Paging;

@interface SquareBaseModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *stid;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) Server *server;
@property (nonatomic, strong) Paging *paging;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
