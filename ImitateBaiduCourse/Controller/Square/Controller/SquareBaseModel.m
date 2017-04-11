//
//  SquareBaseModel.m
//
//  Created by  宇智波 on 16/8/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SquareBaseModel.h"
#import "Data.h"
#import "Server.h"
#import "Paging.h"


NSString *const kSquareBaseModelStid = @"stid";
NSString *const kSquareBaseModelData = @"data";
NSString *const kSquareBaseModelServer = @"server";
NSString *const kSquareBaseModelPaging = @"paging";


@interface SquareBaseModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SquareBaseModel

@synthesize stid = _stid;
@synthesize data = _data;
@synthesize server = _server;
@synthesize paging = _paging;


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
            self.stid = [self objectOrNilForKey:kSquareBaseModelStid fromDictionary:dict];
    NSObject *receivedData = [dict objectForKey:kSquareBaseModelData];
    NSMutableArray *parsedData = [NSMutableArray array];
    if ([receivedData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedData addObject:[Data modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedData isKindOfClass:[NSDictionary class]]) {
       [parsedData addObject:[Data modelObjectWithDictionary:(NSDictionary *)receivedData]];
    }

    self.data = [NSArray arrayWithArray:parsedData];
            self.server = [Server modelObjectWithDictionary:[dict objectForKey:kSquareBaseModelServer]];
            self.paging = [Paging modelObjectWithDictionary:[dict objectForKey:kSquareBaseModelPaging]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.stid forKey:kSquareBaseModelStid];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kSquareBaseModelData];
    [mutableDict setValue:[self.server dictionaryRepresentation] forKey:kSquareBaseModelServer];
    [mutableDict setValue:[self.paging dictionaryRepresentation] forKey:kSquareBaseModelPaging];

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

    self.stid = [aDecoder decodeObjectForKey:kSquareBaseModelStid];
    self.data = [aDecoder decodeObjectForKey:kSquareBaseModelData];
    self.server = [aDecoder decodeObjectForKey:kSquareBaseModelServer];
    self.paging = [aDecoder decodeObjectForKey:kSquareBaseModelPaging];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_stid forKey:kSquareBaseModelStid];
    [aCoder encodeObject:_data forKey:kSquareBaseModelData];
    [aCoder encodeObject:_server forKey:kSquareBaseModelServer];
    [aCoder encodeObject:_paging forKey:kSquareBaseModelPaging];
}

- (id)copyWithZone:(NSZone *)zone
{
    SquareBaseModel *copy = [[SquareBaseModel alloc] init];
    
    if (copy) {

        copy.stid = [self.stid copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.server = [self.server copyWithZone:zone];
        copy.paging = [self.paging copyWithZone:zone];
    }
    
    return copy;
}


@end
