//
//  PaintingViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/25.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "PaintingViewController.h"
#import "ColorfulPaintView.h"

@interface PaintingViewController ()
@property (nonatomic,strong) ColorfulPaintView *paintView;
@end

@implementation PaintingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"涂鸦板";
    [self.view addSubview:[self paintView]];
    [self getTimeStamp];
}

- (void)getTimeStamp {

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //现在时间
    NSDate *dateNow = [NSDate date];
    //时间转时间戳
    NSString *timeSp=  [NSString stringWithFormat:@"%ld",(long)[dateNow timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeSp);
    
    //时间戳转时间
    NSDate *transTimesp = [NSDate dateWithTimeIntervalSince1970:[timeSp floatValue]];
    NSString *timeStr = [formatter stringFromDate:transTimesp];
    NSLog(@"timeStr:%@",timeStr);
    
    
    
}



- (ColorfulPaintView *)paintView {
    if (!_paintView) {
        _paintView = [[ColorfulPaintView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64)];
    }
    return _paintView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
