//
//  SGFocusImageItem.h
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGFocusImageItem : NSObject

@property (nonatomic, strong)  NSString      *url;
@property (nonatomic, strong)  NSString      *image;
@property (nonatomic, assign)  NSInteger     tag;
@property (nonatomic, assign)  NSInteger     dataIndex;

- (id)initWithTitle:(NSString *)title image:(NSString *)image tag:(NSInteger)tag;
- (id)initWithDict:(NSDictionary *)dict tag:(NSInteger)tag;

@end
