//
//  Data.m
//
//  Created by  宇智波 on 16/8/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Data.h"
#import "Share.h"


NSString *const kDataTplurl = @"tplurl";
NSString *const kDataId = @"id";
NSString *const kDataImpUrl = @"impUrl";
NSString *const kDataMonitorClickUrl = @"monitorClickUrl";
NSString *const kDataPosition = @"position";
NSString *const kDataDeputyTypefaceColor = @"deputy_typeface_color";
NSString *const kDataMonitorImpUrl = @"monitorImpUrl";
NSString *const kDataType = @"type";
NSString *const kDataImageurl = @"imageurl";
NSString *const kDataTitle = @"title";
NSString *const kDataModule = @"module";
NSString *const kDataTypefaceColor = @"typeface_color";
NSString *const kDataMaintitle = @"maintitle";
NSString *const kDataSolds = @"solds";
NSString *const kDataShare = @"share";
NSString *const kDataClickUrl = @"clickUrl";
NSString *const kDataDeputytitle = @"deputytitle";


@interface Data ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Data

@synthesize tplurl = _tplurl;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize impUrl = _impUrl;
@synthesize monitorClickUrl = _monitorClickUrl;
@synthesize position = _position;
@synthesize deputyTypefaceColor = _deputyTypefaceColor;
@synthesize monitorImpUrl = _monitorImpUrl;
@synthesize type = _type;
@synthesize imageurl = _imageurl;
@synthesize title = _title;
@synthesize module = _module;
@synthesize typefaceColor = _typefaceColor;
@synthesize maintitle = _maintitle;
@synthesize solds = _solds;
@synthesize share = _share;
@synthesize clickUrl = _clickUrl;
@synthesize deputytitle = _deputytitle;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.tplurl = [self objectOrNilForKey:kDataTplurl fromDictionary:dict];
            self.dataIdentifier = [[self objectOrNilForKey:kDataId fromDictionary:dict] doubleValue];
            self.impUrl = [self objectOrNilForKey:kDataImpUrl fromDictionary:dict];
            self.monitorClickUrl = [self objectOrNilForKey:kDataMonitorClickUrl fromDictionary:dict];
            self.position = [[self objectOrNilForKey:kDataPosition fromDictionary:dict] doubleValue];
            self.deputyTypefaceColor = [self objectOrNilForKey:kDataDeputyTypefaceColor fromDictionary:dict];
            self.monitorImpUrl = [self objectOrNilForKey:kDataMonitorImpUrl fromDictionary:dict];
            self.type = [[self objectOrNilForKey:kDataType fromDictionary:dict] doubleValue];
            self.imageurl = [self objectOrNilForKey:kDataImageurl fromDictionary:dict];
            self.title = [self objectOrNilForKey:kDataTitle fromDictionary:dict];
            self.module = [[self objectOrNilForKey:kDataModule fromDictionary:dict] boolValue];
            self.typefaceColor = [self objectOrNilForKey:kDataTypefaceColor fromDictionary:dict];
            self.maintitle = [self objectOrNilForKey:kDataMaintitle fromDictionary:dict];
            self.solds = [[self objectOrNilForKey:kDataSolds fromDictionary:dict] doubleValue];
            self.share = [Share modelObjectWithDictionary:[dict objectForKey:kDataShare]];
            self.clickUrl = [self objectOrNilForKey:kDataClickUrl fromDictionary:dict];
            self.deputytitle = [self objectOrNilForKey:kDataDeputytitle fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tplurl forKey:kDataTplurl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kDataId];
    [mutableDict setValue:self.impUrl forKey:kDataImpUrl];
    [mutableDict setValue:self.monitorClickUrl forKey:kDataMonitorClickUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.position] forKey:kDataPosition];
    [mutableDict setValue:self.deputyTypefaceColor forKey:kDataDeputyTypefaceColor];
    [mutableDict setValue:self.monitorImpUrl forKey:kDataMonitorImpUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kDataType];
    [mutableDict setValue:self.imageurl forKey:kDataImageurl];
    [mutableDict setValue:self.title forKey:kDataTitle];
    [mutableDict setValue:[NSNumber numberWithBool:self.module] forKey:kDataModule];
    [mutableDict setValue:self.typefaceColor forKey:kDataTypefaceColor];
    [mutableDict setValue:self.maintitle forKey:kDataMaintitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.solds] forKey:kDataSolds];
    [mutableDict setValue:[self.share dictionaryRepresentation] forKey:kDataShare];
    [mutableDict setValue:self.clickUrl forKey:kDataClickUrl];
    [mutableDict setValue:self.deputytitle forKey:kDataDeputytitle];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.tplurl = [aDecoder decodeObjectForKey:kDataTplurl];
    self.dataIdentifier = [aDecoder decodeDoubleForKey:kDataId];
    self.impUrl = [aDecoder decodeObjectForKey:kDataImpUrl];
    self.monitorClickUrl = [aDecoder decodeObjectForKey:kDataMonitorClickUrl];
    self.position = [aDecoder decodeDoubleForKey:kDataPosition];
    self.deputyTypefaceColor = [aDecoder decodeObjectForKey:kDataDeputyTypefaceColor];
    self.monitorImpUrl = [aDecoder decodeObjectForKey:kDataMonitorImpUrl];
    self.type = [aDecoder decodeDoubleForKey:kDataType];
    self.imageurl = [aDecoder decodeObjectForKey:kDataImageurl];
    self.title = [aDecoder decodeObjectForKey:kDataTitle];
    self.module = [aDecoder decodeBoolForKey:kDataModule];
    self.typefaceColor = [aDecoder decodeObjectForKey:kDataTypefaceColor];
    self.maintitle = [aDecoder decodeObjectForKey:kDataMaintitle];
    self.solds = [aDecoder decodeDoubleForKey:kDataSolds];
    self.share = [aDecoder decodeObjectForKey:kDataShare];
    self.clickUrl = [aDecoder decodeObjectForKey:kDataClickUrl];
    self.deputytitle = [aDecoder decodeObjectForKey:kDataDeputytitle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_tplurl forKey:kDataTplurl];
    [aCoder encodeDouble:_dataIdentifier forKey:kDataId];
    [aCoder encodeObject:_impUrl forKey:kDataImpUrl];
    [aCoder encodeObject:_monitorClickUrl forKey:kDataMonitorClickUrl];
    [aCoder encodeDouble:_position forKey:kDataPosition];
    [aCoder encodeObject:_deputyTypefaceColor forKey:kDataDeputyTypefaceColor];
    [aCoder encodeObject:_monitorImpUrl forKey:kDataMonitorImpUrl];
    [aCoder encodeDouble:_type forKey:kDataType];
    [aCoder encodeObject:_imageurl forKey:kDataImageurl];
    [aCoder encodeObject:_title forKey:kDataTitle];
    [aCoder encodeBool:_module forKey:kDataModule];
    [aCoder encodeObject:_typefaceColor forKey:kDataTypefaceColor];
    [aCoder encodeObject:_maintitle forKey:kDataMaintitle];
    [aCoder encodeDouble:_solds forKey:kDataSolds];
    [aCoder encodeObject:_share forKey:kDataShare];
    [aCoder encodeObject:_clickUrl forKey:kDataClickUrl];
    [aCoder encodeObject:_deputytitle forKey:kDataDeputytitle];
}

- (id)copyWithZone:(NSZone *)zone
{
    Data *copy = [[Data alloc] init];
    
    if (copy) {

        copy.tplurl = [self.tplurl copyWithZone:zone];
        copy.dataIdentifier = self.dataIdentifier;
        copy.impUrl = [self.impUrl copyWithZone:zone];
        copy.monitorClickUrl = [self.monitorClickUrl copyWithZone:zone];
        copy.position = self.position;
        copy.deputyTypefaceColor = [self.deputyTypefaceColor copyWithZone:zone];
        copy.monitorImpUrl = [self.monitorImpUrl copyWithZone:zone];
        copy.type = self.type;
        copy.imageurl = [self.imageurl copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.module = self.module;
        copy.typefaceColor = [self.typefaceColor copyWithZone:zone];
        copy.maintitle = [self.maintitle copyWithZone:zone];
        copy.solds = self.solds;
        copy.share = [self.share copyWithZone:zone];
        copy.clickUrl = [self.clickUrl copyWithZone:zone];
        copy.deputytitle = [self.deputytitle copyWithZone:zone];
    }
    
    return copy;
}


@end
