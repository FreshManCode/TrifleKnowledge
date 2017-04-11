//
//  BottomPopViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 2016/10/9.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "BottomPopViewController.h"
#import "BigAppearView.h"
#import "LrdOutputView.h"
#import "PopSelectedMenuView.h"
#import "PopSelectedMenuViewModel.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIButton+ExpandTouchBound.h"
#import "TestClickModel.h"

@interface BottomPopViewController () <UIWebViewDelegate,LrdOutputViewDelegate,PopSelectedMenuViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) BigAppearView *appearView;
@property (nonatomic,strong) UIWebView * webView;
@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) UIBarButtonItem *rightButton;
@property (nonatomic,strong) UIImageView * iconImage;

@property (nonatomic,strong) UIButton * testButton;

@end

@implementation BottomPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.text = @"弹出动画";
    [self initDataArray];
    _rightButton = [[UIBarButtonItem alloc]initWithTitle:@"弹出View" style:UIBarButtonItemStylePlain target:self action:@selector(popBottomView)];
    self.navigationItem.rightBarButtonItem = _rightButton;
    
    [self.view addSubview:[self bottomView]];
    [self.view addSubview:[self webView]];
    [self loadRequeset];
    [self initFourChoiceDifferentButton];
    [self.view addSubview:[self iconImage]];
    [self.view addSubview:[self testButton]];
    
    [self copyKnowledge];
}
- (void)initDataArray {
    LrdCellModel *modelOne = [[LrdCellModel alloc]initWithTitle:@"店铺" imageName:@"type_brand"];
    LrdCellModel *modelTwo = [[LrdCellModel alloc]initWithTitle:@"商家" imageName:@"type_good"];
    LrdCellModel *modelThree = [[LrdCellModel alloc]initWithTitle:@"贸易" imageName:@"type_trade"];
    _dataArray = [NSArray arrayWithObjects:modelOne,modelTwo,modelThree, nil];
}
#pragma mark ------扩大按钮响应区域的事件
- (UIButton *)testButton {
    if (!_testButton) {
        _testButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 100, 10, 10)];
        [_testButton setBackgroundColor:[UIColor blueColor]];
        [_testButton hitTest:_testButton.center withEvent:nil];
        [_testButton addTarget:self action:@selector(testClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testButton;
}


- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENWIDTH - 100)/2.0, 70, 100, 100)];
        _iconImage.image = [[UIImage alloc]initWithContentsOfFile:[self getImageWithName:@"头像"]];
        _iconImage.backgroundColor = [UIColor redColor];
        _iconImage.layer.cornerRadius = 50;
        _iconImage.clipsToBounds = YES;
    }
    return _iconImage;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, [self getNavHeight], SCREENWIDTH, SCREENHEIGHT )];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
    }
    return _webView;
}

- (void)loadRequeset {
    NSString *url = @"http://192.168.3.13:8080/xpg/Advices/advicesAdd?sid=6531s37322fdb592153a0d98f74309e84fc8dba";
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT *2, SCREENWIDTH, 400)];
        _bottomView.backgroundColor = [UIColor greenColor];
        
        UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 15, 50, 35)];
        [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [closeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeCurrentView:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:closeBtn];
    }
    return _bottomView;
}

- (void)popTableView {
    CGFloat y = 58;
    CGFloat x = SCREENWIDTH - 30;
    __block  LrdOutputView *outPutView = [[LrdOutputView alloc]initWithDataArray:_dataArray origin:CGPointMake(x, y) width:100 height:44 direction:kLrdOutputViewDirectionRight];
    outPutView.delegate = self;
    outPutView.dismissOperation = ^(){
        //防止循环引用,设置成 nil
        outPutView = nil;
    };
    [outPutView pop];
}

- (void)initFourChoiceDifferentButton {
    CGFloat offSetX = 20;
    CGFloat offSetY = 20;
    CGFloat width   = (SCREENWIDTH - 3*offSetX) / 2.0;
    CGFloat height  = 30;
    NSArray *arrays = [NSArray arrayWithObjects:@"正常方式箭头在左",@"正常方式箭头在右",@"倒序方式箭头在左",@"倒序方式箭头在右",@"更换头像", nil];
    for (int i =0;i<arrays.count;i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((i%2)* (offSetX +width) +offSetX, self.view.center.y + (offSetY +height)*(i/2) + offSetY, width, height)];
        [button setTitle:arrays[i] forState:UIControlStateNormal];
        button.titleLabel.font = Font(14.0f);
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor redColor]];
        button.tag = 1+i;
        [button addTarget:self action:@selector(appearTablView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)appearTablView:(UIButton *)sender {
    if (sender.tag <5) {
        CGFloat x = sender.center.x;
        CGFloat y = sender.bottom +5;
        if (sender.tag >2) {
            y = sender.top - 5;
        }
        CGFloat height = 44;
        CGFloat width  = 100;
        PopSelectedMenuView *muenuView = [[PopSelectedMenuView alloc]initWithOrigin:CGPointMake(x, y) rowWidth:width rowHeight:height dataArray:self.dataArray popType:sender.tag delegate:self];
        [muenuView popCurrentView];

    } else {
        UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
        [action showInView:self.view];
//        [self writeFile];
    }
}

- (void)testClick:(UIButton *)sender {
    NSLog(@"测试下响应区域能不能改变的大");
}

- (NSString *)dirDoc {
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths firstObject];
    return  documents;
}

//创建文件夹
- (void)createDir {
    NSString *documents = [self dirDoc];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSString *testDirectory = [documents stringByAppendingPathComponent:@"test"];
    //创建目录
    BOOL res = [fileManger createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"文件夹创立成功");
    } else {
        NSLog(@"文件夹创立失败");
    }
}


//创建文件
- (void)createFile {
    NSString *documentPath = [self dirDoc];
    NSString *testDirectory = [documentPath stringByAppendingPathComponent:@"test"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [testDirectory stringByAppendingPathComponent:@"test.txt"];
    BOOL res = [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    if (res) {
        NSLog(@"文件创建成功: %@" ,filePath);
    }else
        NSLog(@"文件创建失败");
}

//写数据到文件
- (void)writeFile {
    NSString *documentsPath = [self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *testPath      = [testDirectory stringByAppendingPathComponent:@"test.txt"];
    [fileManager createFileAtPath:testPath contents:nil attributes:nil];
    NSString *content       = @"测试写入内容";
    BOOL res = [content writeToFile:testPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"文件写入成功");
    }else
        NSLog(@"文件写入失败");
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"---%ld",(long)buttonIndex);
    if (buttonIndex == 2) {
        return;
    }
    UIImagePickerController *pickVC = [[UIImagePickerController alloc]init];
    pickVC.delegate      = (id) self;
    pickVC.allowsEditing = YES;
    if (buttonIndex==0) {
        if ([self checkHavePhotoLibraryAccess]) {
            pickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
    } else if (buttonIndex ==1) {
        if ([self checkCameraAuthorizationStatus]) {
            pickVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
    }
    [self presentViewController:pickVC animated:YES completion:nil];
}

- (BOOL)checkHavePhotoLibraryAccess {
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    if (ALAuthorizationStatusDenied == authStatus || ALAuthorizationStatusRestricted == authStatus) {
        [self showAlertMessage:@"请在iPhone的“设置->隐私->照片”中打开本应用的访问权限"];
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)checkCameraAuthorizationStatus {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self showAlertMessage:@"该设备不支持拍照"];
        return NO;
    }
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (AVAuthorizationStatusDenied == authStatus || AVAuthorizationStatusRestricted == authStatus) {
            [self showAlertMessage:@"请在iPhone的“设置->隐私->相机”中打开本应用的访问权限"];
            return NO;
        }
    }
    
    return YES;
}


- (void)showAlertMessage:(NSString *)message {
    [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",message] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
        [self saveData:imageData imageWithName:@"头像"];
        NSLog(@"****%@",[[UIImage alloc]initWithContentsOfFile:[self getImageWithName:@"头像"]]);
        self.iconImage.image = [[UIImage alloc]initWithContentsOfFile:[self getImageWithName:@"头像"]];

    }];
}

- (void)saveData:(NSData *)imageData imageWithName:(NSString *)name {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *directoryPath = [path stringByAppendingPathComponent:name];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    BOOL res = [fileManger createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    if (res ) {
        NSLog(@"文件夹创建成功:%@",directoryPath);
    } else {
        NSLog(@"文件夹创建失败");
    }
    NSString *filePath = [directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",name]] ;
//    BOOL resFile = [fileManger createFileAtPath:filePath contents:imageData attributes:nil];
//    if (resFile) {
//        NSLog(@"文件创建成功");
//    } else {
//        NSLog(@"文件创建失败");
//    }
    BOOL saveData = [imageData writeToFile:filePath atomically:YES];
    if (saveData) {
        NSLog(@"文件写入成功");
    } else {
        NSLog(@"文件写入失败");
    }
}

- (NSString *)getImageWithName:(NSString *)name {
    NSString *path     = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dirPath  = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",name]];
    NSString *filePath = [dirPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",name]];
    return filePath;
}


- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    LrdCellModel *selectedModel = _dataArray[indexPath.row];
    NSLog(@"选择的商品标题是:%@",selectedModel.title);
}

- (void)didSelectedAccordingItem:(NSIndexPath *)indexPath {
    PopSelectedMenuViewModel *selectedModel = _dataArray[indexPath.row];
    NSLog(@"选择的商品标题是:%@",selectedModel.title);
}


- (void)popBottomView {
//    static NSInteger clickTimes = 0;
//    if (clickTimes %2==0) {
        __weak typeof (self) weakSelf = self;
        if (!_appearView) {
            _appearView = [[BigAppearView alloc]initWithFrame:CGRectMake(10, 64 + 10, SCREENWIDTH- 20, SCREENHEIGHT - 100) title:@"我只是个小开发仔" cancelTitle:@"'" sureTitle:@"分享给好友吧"];
        }
        [self.view addSubview:_appearView];
        _appearView.CancelEvent = ^ (UIView * view) {
            [weakSelf closeCurrentViewWithView:view];
        };
        
        _appearView.SureEvent = ^ (UIView *view) {
            [weakSelf closeCurrentViewWithView:view];
            NSLog(@"这应该去干一些其他的事情哦");
        };
 
//    } else {
//        [self popTableView];
//    }
//    clickTimes ++;
//    
    
//    [UIView animateWithDuration:0.1 delay:0.0 options:0 animations:^{
//        [weakSelf.bottomView setFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 400)];
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//            [weakSelf.bottomView setFrame:CGRectMake(0, SCREENHEIGHT - 400, SCREENWIDTH, 400)];
//        } completion:^(BOOL finished) {
//            
//        }];
//    }];
}

- (void)closeCurrentViewWithView:(UIView *)view {
    NSMutableArray *values = [NSMutableArray array];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.001, 0.001, 0.001)]];
    animation.values = values;
    //动画结束后不恢复初始状态
    animation.fillMode            = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [view.layer addAnimation:animation forKey:nil];
    [self performSelector:@selector(subViewRemove) withObject:nil afterDelay:0.4f];
}


- (void)subViewRemove {
    [self.appearView removeFromSuperview];
    self.appearView = nil;
}


- (void)closeCurrentView:(UIButton *)sender {
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:0.1 delay:0.0 options:0 animations:^{
        [weakSelf.bottomView setFrame:CGRectMake(0, SCREENHEIGHT *2, SCREENWIDTH, 400)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [weakSelf.bottomView setFrame:CGRectMake(0, SCREENHEIGHT , SCREENWIDTH, 400)];
        } completion:^(BOOL finished) {
            
        }];
    }];
}

#pragma mark -----深拷贝----浅拷贝-----
- (void)copyKnowledge {
    NSMutableArray *data2 = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    NSMutableArray *data  = [NSMutableArray arrayWithCapacity:0];
    //简单赋值
    data = data2;
    [data removeObjectAtIndex:0];
    NSLog(@"%@-----%@",data,data2);
    /*
     将一个变量赋值非另一个对象仅仅创建另一个对这个对象的引用.所以,如果data和data2都是NSMutableArray的对象,那么上述的删除语句将会从这两个变量引用的同一个数组中删除第一个元素
     */
    
    NSMutableArray *data3 = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    NSMutableArray *data4 = [NSMutableArray arrayWithCapacity:0];
    //赋值一份,然后删除副本的第一个元素
    data4 = [data3 mutableCopy];
    [data4 removeObjectAtIndex:0];
    NSLog(@"%@-----%@",data3,data4);
    /*
     copy 和 mutableCopy方法,可以使用这些方法创建对象的副本.通过实现一个符合<NSCopying>协议(用于制作副本)的方法来按成此项任务.如果必须区分要产生的对象是可变副本还是不可变副本,还要根据<NSMutableCopying>协议实现一个方法.
     上述在内存中创建了一个新的data4副本,并复制了它的所有元素,随后执行删除操作,将不影响data3数组
     
     注意:产生一个对象的可变副本 并不是要求被复制的对象本身是可变的.这种情况同样适用于不可变副本:可以创建可变对象的不可变副本.
     */
    
    TestClickModel *modeOne = [[TestClickModel alloc]init];
    modeOne.title = @"你大爷的a";
    
    //自己的类使用copy或者mutableCopy方法时,如果不手动实现两个协议就直接闪退
    TestClickModel *modelTwo = [modeOne copy];
    
    NSLog(@"%@-----%@",[modeOne description],[modelTwo description]);
    
    
    // 实现<NSCopying>协议
    /*
     如果尝试使用自己的类中的copy方法,语句如下:ClaaA *a = [b mutableCopy];
     将会闪退:[ClassA copyWithZone:]: unrecognized selector
     注意:要实现使用自己的类进行复制,必须根据<NSCopying>协议实现其中一两个方法
     */
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
