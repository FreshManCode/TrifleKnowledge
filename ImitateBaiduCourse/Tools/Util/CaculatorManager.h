//
//  CaculatorManager.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/1/17.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CaculatorManager;

typedef CaculatorManager * (^AddBlock)(int);
typedef CaculatorManager * (^SubBlock)(int);
typedef CaculatorManager * (^MutiplyBlock)(int);
typedef CaculatorManager * (^DevideBlock)(int);

@interface CaculatorManager : NSObject

@property (nonatomic,assign) NSInteger result;

- (AddBlock)addBlock;
- (SubBlock)subBlock;
- (MutiplyBlock)mutiBlock;
- (DevideBlock)devideBlock;

@end
