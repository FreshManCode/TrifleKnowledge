//
//  Data.h
//
//  Created by  宇智波 on 16/8/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Share;

@interface Data : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *tplurl;
@property (nonatomic, assign) double dataIdentifier;
@property (nonatomic, strong) NSString *impUrl;
@property (nonatomic, strong) NSString *monitorClickUrl;
@property (nonatomic, assign) double position;
@property (nonatomic, strong) NSString *deputyTypefaceColor;
@property (nonatomic, strong) NSString *monitorImpUrl;
@property (nonatomic, assign) double type;
@property (nonatomic, strong) NSString *imageurl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL module;
@property (nonatomic, strong) NSString *typefaceColor;
@property (nonatomic, strong) NSString *maintitle;
@property (nonatomic, assign) double solds;
@property (nonatomic, strong) Share *share;
@property (nonatomic, strong) NSString *clickUrl;
@property (nonatomic, strong) NSString *deputytitle;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
