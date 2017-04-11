//
//  AddressCard.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/12/28.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "AddressCard.h"

@interface AddressCard () <NSCoding>

@end

@implementation AddressCard
//编码
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name  forKey:@"AddressCardName"];
    [aCoder encodeObject:_email forKey:@"AddressCardEmail"];
}

//解码
- (id)initWithCoder:(NSCoder *)aDecoder {
    _name  = [aDecoder decodeObjectForKey:@"AddressCardName"];
    _email = [aDecoder decodeObjectForKey:@"AddressCardEmail"];
    return self;
}
- (void)setName:(NSString *)name andEmail:(NSString *)theEmail {
    if (_name != name) {
        _name  = name;
    }
    if (_email != theEmail) {
        _email  = theEmail;
    }
    
}


@end

@implementation Foo

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_strVal  forKey:@"FooStrVal"];
    [aCoder encodeInt:_intVal     forKey:@"FooIntVal"];
    [aCoder encodeFloat:_floatVal forKey:@"FooFloatVal"];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    _strVal   = [aDecoder decodeObjectForKey:@"FooStrVal"];
    _intVal   = [aDecoder decodeIntForKey:@"FooIntVal"];
    _floatVal = [aDecoder decodeFloatForKey:@"FooFloatVal"];
    return self;
}

@end
