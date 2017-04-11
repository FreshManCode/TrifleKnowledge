//
//  YWBlocksKitViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2017/3/14.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWBlocksKitViewController.h"
#import <BlocksKit.h>
@interface YWBlocksKitViewController ()

@end

@implementation YWBlocksKitViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self testOneBlocksKit];
    [self testMagicNSObject];
}

- (void)testOneBlocksKit {
    NSArray *testArray = [NSArray arrayWithObjects:@1,@2,@3, nil];
    [testArray bk_each:^(id obj) {
        NSLog(@"bk_each %@",obj);
    }];
}

//NSObject 上的魔法
- (void)testMagicNSObject {
    /*在NSObject 上添加的方法几乎会添加到Cocoa Touch 中的所有类上,关于NSObject的讨论和总共分为以下三部分进行
     1.AssociatedObject
     2.BlockExecution
     3.BlockObservation
     */
    //添加AssociatedObject.当我们想要为一个已经存在的类添加属性时,就需要用到AssociatedObject 为类添加属性
    //而BlocksKit 提供了更简单的方法来实现,不需要新建一个分类
    NSObject *test = [[NSObject alloc]init];
    [test bk_associateValue:@"Dream" withKey:@"name"];
    NSLog(@"bk_associateValue:%@",[test bk_associatedValueForKey:@"name"]);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
