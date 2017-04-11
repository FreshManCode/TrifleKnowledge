//
//  SGFocusImageItem.m
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import "SGFocusImageItem.h"

@implementation SGFocusImageItem

- (id)initWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag
{
    self = [super init];
    if (self) {
        self.url = title;
        self.image = image;
        self.tag = tag;
    }
    
    return self;
}

- (id)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag
{
    self = [super init];
    if (self)
    {
        if ([dict isKindOfClass:[NSDictionary class]])
        {
            self.url = [dict objectForKey:@"url"];
            self.image = [dict objectForKey:@"image"];
            self.dataIndex = [[dict objectForKey:@"dataIndex"] integerValue];
        }
    }
    return self;
}
@end
