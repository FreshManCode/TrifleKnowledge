//
//  YWCompressImageViewController.m
//  ImitateBaiduCourse
//
//  Created by SnailJob on 17/4/26.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "YWCompressImageViewController.h"
#import "UIImage+Image.h"

@interface YWCompressImageViewController () <UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *clickButton;
@property (nonatomic, strong) UIImageView *imageViewT;

@end

@implementation YWCompressImageViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _clickButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - 110, 70, 100, 40)];
    [_clickButton setBackgroundColor:[UIColor redColor]];
    [_clickButton setTitle:@"ClickMe" forState:UIControlStateNormal];
    [_clickButton addTarget:self action:@selector(clickCrashEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_clickButton];

    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, _clickButton.bottom + 20,SCREENWIDTH - 60, SCREENHEIGHT * 0.35)];
    [self.view addSubview:_imageView];
    
    _imageViewT = [[UIImageView alloc]initWithFrame:CGRectMake(30, _imageView.bottom+10, SCREENWIDTH - 60, SCREENHEIGHT * 0.35)];
    [self.view addSubview:_imageViewT];
}

- (void)clickCrashEvent:(UIButton *)sender {
    if ([HRCheckPicturePermission checkPhotoLibraryAuthorizationStatus]) {
        UIImagePickerController *pickVC = [[UIImagePickerController alloc]init];
        pickVC.delegate =  (id) self;
        pickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickVC animated:YES completion:nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSData  *oriData = UIImageJPEGRepresentation(image, 1.0);
//    if (oriData.length > 1000 * 500) {
        double  sizeOM  = oriData.length / (1000 * 1000.0);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *imageTwo = [UIImage scaleImage:image toScale:0.4];
            NSData  *comData  =  [imageTwo compressImage];
            double  sizeCM    = comData.length/ (1000 * 1000.0);
            dispatch_async(dispatch_get_main_queue(), ^{
                _imageView.image  = [UIImage imageWithData:comData];
                _imageViewT.image = image;
                NSLog(@"%f-----%f",sizeOM,sizeCM);
            });
        });
//    } else {
//        
//    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
