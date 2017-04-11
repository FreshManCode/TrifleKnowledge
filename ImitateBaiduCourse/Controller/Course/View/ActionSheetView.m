//
//  ActionSheetView.m
//  Architecture
//
//  Created by ZM on 2016/11/28.
//  Copyright © 2016年 ZM. All rights reserved.
//
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define Font(a)      [UIFont systemFontOfSize:a]


#import "ActionSheetView.h"

@implementation ActionSheetView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
//        //iOS设置父视图透明度而不影响子视图
//        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        topRect    = CGRectMake(0, 0,        SCREENWIDTH, SCREENHEIGHT);
        bottomRect = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT);
        self.frame = bottomRect;
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
        
    }
    return self;
}


// didSelect
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // NSLog(@"---> row = %ld",indexPath.row);
    //取消
    if (indexPath.row == (_titleArray.count-1)) {
        [self dismissView];
    }
    //block 回调 传值
    if (self.actionSheetViewBlock) {
       self.actionSheetViewBlock(indexPath.row);
    }
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    NSLog(@"---> _titleArray = %@",_titleArray);
    rowHeight   = 40;
    tableHeight = rowHeight*_titleArray.count + 15;
    [self settableView:CGRectMake(0, SCREENHEIGHT - tableHeight, SCREENWIDTH, rowHeight*_titleArray.count + 15)];
    
}

#pragma mark -------------布局---------
-(UITableView *)settableView:(CGRect)fame {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:fame style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor grayColor];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        _tableView.scrollEnabled = NO;
        [self addSubview:_tableView];
    }
    return _tableView;
}


#pragma mark ============="  UITableViewDataSource、UITableViewDelegate  "==================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == (_titleArray.count-1)) {
        return rowHeight + 15;
    }else{
        return rowHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor lightGrayColor];
    };
    UILabel *_titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, rowHeight)];
    _titleLab.font = Font(16);
    _titleLab.textColor = [UIColor darkTextColor];
    _titleLab.backgroundColor = [UIColor whiteColor];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.text = _titleArray[indexPath.row];
    [cell addSubview:_titleLab];
    if (indexPath.row == _titleArray.count-1) {
        _titleLab.frame     = CGRectMake(0,15, SCREENWIDTH, rowHeight);
    }
    return cell;
}

#pragma mark 普通动画
- (void)flipView:(UIView *)myView Rect:(CGRect)myRect forView:(UIView *)view timeInterval:(NSTimeInterval)myTime
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:myTime];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:view cache:YES];
    myView.frame = myRect;
    [UIView commitAnimations];
}
// 显示 View
- (void)showView {
    [self flipView:self Rect:topRect forView:self timeInterval:0.3];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    //iOS设置父视图透明度而不影响子视图
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    [UIView commitAnimations];
    
}
// 隐藏 View
- (void)dismissView {
    [self flipView:self Rect:bottomRect forView:self timeInterval:0.3];
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.0];

}
// 移除 View
- (void)removeView {
    //遍历所有子试图subviews
    for (UIView *subViews in self.subviews) {
        [subViews removeFromSuperview];
    }
    [self removeFromSuperview];
    
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}


@end
