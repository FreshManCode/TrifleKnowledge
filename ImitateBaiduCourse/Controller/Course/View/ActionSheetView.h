//
//  ActionSheetView.h
//  Architecture
//
//  Created by ZM on 2016/11/28.
//  Copyright © 2016年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void  (^ActionSheetViewBlock) (NSInteger indexPath);


@interface ActionSheetView : UIView<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    float rowHeight, tableHeight;
    CGRect topRect, bottomRect;
}
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSArray *titleArray;

@property (nonatomic,copy) ActionSheetViewBlock actionSheetViewBlock;


// 显示 View
- (void)showView;
// 隐藏 View
- (void)dismissView;
// 移除 View
- (void)removeView;



@end
