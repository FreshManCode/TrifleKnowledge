//
//  EightButtonCollectionViewCell.h
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/12/1.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EightButtonCollectionViewCell : UICollectionViewCell
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) void (^(DidSelectedItem)) (NSInteger itemTag);
@end
