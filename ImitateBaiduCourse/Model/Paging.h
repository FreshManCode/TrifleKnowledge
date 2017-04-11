//
//  Paging.h
//
//  Created by  宇智波 on 16/8/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Paging : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double count;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
