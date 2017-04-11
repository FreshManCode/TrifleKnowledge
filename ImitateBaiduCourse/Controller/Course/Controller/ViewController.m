//
//  ViewController.m
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/15.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "ViewController.h"
#import "NetworkManager.h"
#import "LoopBannerView.h"
#import "AlbumListModel.h"
#import "CourseListModel.h"
#import "CourseTableViewCell.h"
#import "SDCycleScrollView.h"
#import <MJRefresh.h>
#import "FPSLabel.h"
#import "CoureTwoViewController.h"
#import "LoopViewController.h"
#import "CustomRefreshHeader.h"
#import "BottomPopViewController.h"
#import "CollectionViewViewController.h"
#import "InsertTableViewCell.h"
#import "InsertCollectionViewCell.h"
#import "NSObject+AlertView.h"
#import "AppDelegate.h"
#import "InsertOneImageTableViewCell.h"
#import "InsertOneImageCell.h"
#import <MWPhotoBrowser.h>
#import "LearnBlockViewController.h"
#import "LearnAnimationVC.h"


@interface ViewController ()
<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate,MWPhotoBrowserDelegate>
@property (nonatomic,strong) NSMutableArray *albumArray;
@property (nonatomic,strong) NSMutableArray *focusArray;
@property (nonatomic,strong) UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *recommendArray;
@property (nonatomic,strong) UIView *tableHeadView;
//@property (nonatomic,strong) ODRefreshControl  *refreshControl;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong) FPSLabel *fpsLabel;
@property (nonatomic,strong) NSMutableArray * testArray;
@property (nonatomic,strong) NSArray *colorArray;
@property (nonatomic,strong) NSArray *photosArray;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"课堂首页";
    self.colorArray = [NSArray arrayWithObjects:[UIColor redColor],[UIColor redColor],[UIColor redColor],[UIColor blueColor],[UIColor blueColor],[UIColor blueColor], nil];
    [self initArrays];
    [self sendRequest];
    
}

- (void)initArrays {
    if (!_albumArray) {
        _albumArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    if (!_focusArray) {
        _focusArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    if (!_recommendArray) {
        _recommendArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    if (!_testArray) {
        _testArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleScrollView.autoScrollTimeInterval = 3.50f;
     [self.view addSubview:_cycleScrollView];
    
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]
                          initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 49 - 64) style:UITableViewStyleGrouped];
        _mainTableView.rowHeight  = 80;
        _mainTableView.delegate   = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView = _cycleScrollView;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self.view addSubview:_mainTableView];
    
    _fpsLabel = [[FPSLabel alloc] initWithFrame:CGRectZero];
    [_fpsLabel sizeToFit];
    _fpsLabel.bottom = SCREENHEIGHT - 62;
    _fpsLabel.left   = 12;
    _fpsLabel.alpha  = 0;
    [self.view addSubview:_fpsLabel];
    [self.view bringSubviewToFront:_fpsLabel];
    _mainTableView.mj_header = [CustomRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshContent)];
    
}

- (void)sendRequest {
//    __weak typeof (self) weakSelf = self;
    NSString *urlString = @"http://pop.client.chuanke.com/?mod=recommend&act=mobile&client=2&limit=20";
    [self.albumArray removeAllObjects];
    [self.recommendArray removeAllObjects];
    [self.albumArray removeAllObjects];
    [NetworkManager getRequest:urlString parameters:nil success:^(id responseObject) {
        [self performSelector:@selector(dealWithJsonResult:) withObject:responseObject afterDelay:1.0f];
    } failure:^(NSError *error) {
        [self endRefresh];
        NSLog(@"错误信息为:%@",error);
    }];
}

- (void)dealWithJsonResult:(id)responseObject {
    [self endRefresh];
    //FocusList
    for (NSDictionary *dic in responseObject[@"AlbumList"] ) {
        AlbumListModel *alumModel = [AlbumListModel mj_objectWithKeyValues:dic];
        [self.albumArray addObject:alumModel];
        //下面这种方式,是使用YYModel
        AlbumListModel *yyListModel = [AlbumListModel modelWithDictionary:dic];
        [self.testArray addObject:yyListModel];
    }
    NSLog(@"yymodelArray:%@----第一个URL:%@",self.testArray,((AlbumListModel *)self.testArray.firstObject).PhotoURL);
    
    [self initLoopBannerViewWithImageArray:self.albumArray];
    for (NSInteger i = 0; i< [responseObject[@"CourseList"] count]; i++) {
        CourseListModel *courseList = [CourseListModel mj_objectWithKeyValues:responseObject[@"CourseList"][i]];
        [self.recommendArray addObject:courseList];
    }
    for(NSDictionary *dic in responseObject[@"AlbumList"]) {
        AlbumListModel *albumModel =[AlbumListModel mj_objectWithKeyValues:dic];
        [self.albumArray addObject:albumModel];
    }
    [self.mainTableView reloadData];
}
- (void)dealloc {
    self.mainTableView.delegate   = nil;
    self.mainTableView.dataSource = nil;
    
}


- (void)refreshContent {
    [_mainTableView.mj_header beginRefreshing];
    [self sendRequest];
}

- (void)endRefresh {
    if ([_mainTableView.mj_header respondsToSelector:@selector(endRefreshing)]) {
        [_mainTableView.mj_header endRefreshing];
    }
}

- (void)initLoopBannerViewWithImageArray:(NSMutableArray *)array {
    NSMutableArray *urlArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (AlbumListModel *model in self.albumArray) {
        [urlArray addObject:model.PhotoURL];
    }
    _cycleScrollView.imageURLStringsGroup = urlArray;
}


#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return [self.recommendArray count];
    } else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof (self) weakSelf = self ;
    if (indexPath.section==0) {
        CourseScrollCell *cell = [CourseScrollCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.scrollArray     = self.albumArray;
        cell.courseClick     = ^(NSInteger clickIndex) {
            [weakSelf didClickCategoryCourseIndex:clickIndex];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section==1) {
        CourseTableViewCell *cell = [CourseTableViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.recommendArray.count >0) {
            cell.courseModel = [self.recommendArray objectAtIndex:indexPath.row];
            if (indexPath.row == self.recommendArray.count - 1) {
                [cell.sepratorLineView setHidden:YES];
            }
        }
        return cell;
    } else if (indexPath.section == 2) {
        static NSString *CellIdentifier = @"CellIdentifier";
        InsertTableViewCell *cell = (InsertTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InsertTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        return cell;
    } else {
        static NSString *CellIdentifier = @"OneImageCellIdentifier";
        InsertOneImageTableViewCell *cell = (InsertOneImageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[InsertOneImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2 || section == 3) {
        return 44;
    } else {
        return 44;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 8;
    } else {
        return 0.01;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        UIView *popHeadView = [self headViewTitle:@"课程推荐" bgColor:nil];
        return popHeadView;
    } else if ( section == 3 ) {
        UIView *popHeadView = [self headViewTitle:@"流行趋势" bgColor:nil];
        return popHeadView;
    } else {
        UIView *popHeadView = [self headViewTitle:@"学习功能" bgColor:nil];
        return popHeadView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *popHeadView = [self headViewTitle:nil bgColor:RGB(233, 233, 233)];
        return popHeadView;
    } else {
        return nil;
    }
}

- (UIView *)headViewTitle:(NSString *)title bgColor:(UIColor *)color {
    UIView *popHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    if (color) {
        popHeadView.backgroundColor = color;
    } else {
        popHeadView.backgroundColor = [UIColor whiteColor];
    }
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREENWIDTH - 20, popHeadView.height)];
    titleLabel.text     = title;
    titleLabel.font     = Font(15.0f);
    titleLabel.textColor= [UIColor redColor];
    [popHeadView addSubview:titleLabel];
    return popHeadView;

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        InsertTableViewCell *newCell = (InsertTableViewCell *) cell;
        [newCell setCollectionViewDataSourceAndDelegate:self indexPath:indexPath];
    } else if (indexPath.section == 3) {
        InsertOneImageTableViewCell *newCell = (InsertOneImageTableViewCell *) cell;
        [newCell setCollectionViewDataSourceAndDelegate:self indexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        CGFloat itemHeight = (kScreen_Width - 3 *8) / 2.0 + (10 + 15) *2 + 10 + 8 ;
        return itemHeight * (self.recommendArray.count % 2 == 0 ? self.recommendArray.count / 2 : self.recommendArray.count / 2 + 1 ) + 24;
    } else if (indexPath.section == 3)  {
        return (65 + 8 )  * (self.recommendArray.count % 3 == 0 ? self.recommendArray.count / 3 : self.recommendArray.count / 3 + 1 ) + 16;
    } else {
        return 80;
    }
}

#pragma mark -------UICollectionViewDelegate ------DataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recommendArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        InsertCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.listModel = self.recommendArray[indexPath.row];
        return cell;
    } else {
        InsertOneImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.listModel = self.recommendArray[indexPath.row];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;

    UITableViewCell *cell = (UITableViewCell *)[[collectionView superview] superview];
    if ([cell isKindOfClass:[InsertOneImageTableViewCell class]]) {
        [self AlertTitle:@"接下来干什么" message:nil andOthers:@[@"退出程序",@"跳转到寻皮革",@"调用C方法"] animated:YES action:^(NSInteger index) {
            switch (index) {
                case 0: {
                    [weakSelf exitApplication];
                }
                    break;
                case 1: {
                    [weakSelf jumpToAnotherApp];
                }
                    break;
                case 2: {
                    callCMethod ();
                }
                    break;
                default:
                    break;
            }
        }];
    } else if ([cell isKindOfClass:[InsertTableViewCell class]]) {
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:0];
        [self.recommendArray enumerateObjectsUsingBlock:^(AlbumListModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MWPhoto *photo = [[MWPhoto alloc]initWithURL:[NSURL URLWithString:obj.PhotoURL]];
            [photos addObject:photo];
        }];
        self.photosArray = [NSArray arrayWithArray:photos];
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc]initWithPhotos:photos];
        [browser setCurrentPhotoIndex:indexPath.row];
        [browser showNextPhotoAnimated:YES];
        [browser showPreviousPhotoAnimated:YES];
        browser.displayActionButton     = YES;
        browser.displayNavArrows        = YES;
        //显示可以选中的对号
//        browser.displaySelectionButtons = YES;
        browser.delegate = self;
        [self.navigationController pushViewController:browser animated:YES];
//        [self showAlertTitle:@"Hello" message:[NSString stringWithFormat:@"我点击是第%ld的标题",(long)indexPath.row + 1] okTitle:@"是的" cancelTitle:nil okAction:^{
//        }cancelAction:nil completion:nil];
    }
}

void actionWithIndex (NSInteger index) {
    
}


void jumpToAnotherApp (void) {
    NSURL *url = [NSURL URLWithString:@"com.nengwu.xunpige://?token=123456"];
    if ([[UIApplication sharedApplication]canOpenURL:url]) {
        [[UIApplication sharedApplication]openURL:url];
    }
    //注意:C语言函数中不能使用self 调用实例方法
//    [self jumpToAnotherApp];
    //c语言函数的调用
    testCLanguageMethod();
    testCLanguageWithParmeters(@"大爷我", @"年龄\"28\"");
}

- (void)jumpToAnotherApp {
    NSURL *url = [NSURL URLWithString:@"com.nengwu.xunpige://?token=123456"];
    if ([[UIApplication sharedApplication]canOpenURL:url]) {
        [[UIApplication sharedApplication]openURL:url];
    }
    //c语言函数的调用
    testCLanguageMethod();
    testCLanguageWithParmeters(@"大爷我", @"年龄\"28\"");
}


#pragma mark -------C 语言函数------Begin
/* 说明: void testCLanguageMethod (void)
   告诉编译器 testCLanguageMethod 是一个函数,它不返回任何值,关键字void,并且不带任何参数
 */
void callCMethod (void) {
    testCLanguageMethod();
    testCLanguageWithParmeters(@"李小璐", @"性别女");
    NSString *tempString = testReturnString();
    NSString *secondStr  = inputReturnString(@"成为大神之路崛起");
    NSLog(@"%@-----%@",tempString,secondStr);
    
}

//无参无返回
void testCLanguageMethod (void) {
    NSLog(@"这个是C语言不带的参数的函数,尝试着调用");
}

//有参无返回
void testCLanguageWithParmeters (NSString * a ,NSString* b ) {
    NSLog(@"这是带参数的参数\na为:%@----\n参数b为:%@",a,b);
}

//无参有返回
NSString * testReturnString (void) {
    return @"This a return parameters";
}

//有参有返回
NSString * inputReturnString (NSString * paras) {
    return paras;
}

#pragma mark -------C 语言函数------End


- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.recommendArray.count;
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (self.photosArray.count >0) {
        return self.photosArray[index];
    }
    return nil;
}


- (void)exitApplication {
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    [self slowDisappearWithWindow:window];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5f;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:0];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0f)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.05, 0.05, 0.05)]];
    animation.values = values;
    [window.layer addAnimation:animation forKey:nil];
}

- (void)slowDisappearWithWindow:(UIWindow *)window {
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    AlbumListModel *model;
    if (self.albumArray.count >0) {
        model =  self.albumArray[index];
    }
    if (index == 0) {
        CoureTwoViewController *twoVC = [[CoureTwoViewController alloc]init];
        twoVC.titleString      = model.Title;
        twoVC.hidesBottomBarWhenPushed = YES;
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:twoVC];
//        [self.navigationController presentViewController:nav animated:YES completion:nil];
        [self.navigationController pushViewController:twoVC animated:YES];
    } else if (index ==1) {
        LoopViewController *loadVC = [[LoopViewController alloc]init];
        loadVC.hidesBottomBarWhenPushed = YES;
        loadVC.title = @"动画旋转";
        [self.navigationController pushViewController:loadVC animated:YES];
    } else if (index == 2) {
        CollectionViewViewController *collectionVC = [[CollectionViewViewController alloc]init];
        collectionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:collectionVC animated:YES];
    }
    NSLog(@"我点击的图片是:%d",(int)index);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CourseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section ==0) {
        BottomPopViewController *bottomVC = [[BottomPopViewController alloc]init];
        [self.navigationController pushViewController:bottomVC animated:YES];
        NSLog(@"点击的是第几个%d----类型为:%d",(int)indexPath.row,(int)cell.cellType);
    } else {
        CourseListModel *model = [self.recommendArray objectAtIndex:indexPath.row ];
        LearnBlockViewController *learnVC = [[LearnBlockViewController alloc]init];
        learnVC.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:learnVC animated:YES];
        NSLog(@"点击的是第几个%d---%@---类型为:%d",(int)indexPath.row,model.CourseName,(int)cell.cellType);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha ==0) {
        [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            _fpsLabel.alpha = 1;
        } completion:NULL];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (_fpsLabel.alpha != 0) {
            [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                _fpsLabel.alpha = 0;
            } completion:NULL];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha != 0) {
        [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 0;
        } completion:NULL];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark ------ 学习功能模块一
- (void)didClickCategoryCourseIndex:(NSInteger)courseIndex {
    __weak typeof(self) weakSelf = self;
    switch (courseIndex) {
        case 0: {
            [[AlertViewManager manager]showTitle:@"知识点学习" message:@"去学习" cancanTitle:@"不去学习" okAction:^{
                LearnAnimationVC *anmationVC = [[LearnAnimationVC alloc]init];
                anmationVC.hidesBottomBarWhenPushed = YES; 
                [weakSelf.navigationController pushViewController:anmationVC animated:YES];
            } cancelClick:nil];
        }
            break;
        default: {
            BottomPopViewController *bottomVC = [[BottomPopViewController alloc]init];
            bottomVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:bottomVC animated:YES];
            NSLog(@"我点击的滑动小图是第%d张",(int)courseIndex);

        }
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
