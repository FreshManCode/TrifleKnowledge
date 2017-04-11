//
//  CaculatorManager.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/1/17.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "CaculatorManager.h"

@implementation CaculatorManager
- (AddBlock)addBlock {
    return  ^CaculatorManager * (int value) {
        _result += value;
        return self;
    };
}

- (SubBlock)subBlock {
    return ^CaculatorManager *(int value){
        _result -= value;
        return self;
    };
}

- (MutiplyBlock)mutiBlock {
    return ^(int value){
        _result *= value;
        return self;
    };
}
- (DevideBlock)devideBlock {
    return ^(int value) {
        _result /= value;
        return self;
    };
}



@end
