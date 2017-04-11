//
//  DisplayJSAndOCViewController.m
//  ImitateBaiduCourse
//
//  Created by 巴巴罗萨 on 16/8/17.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "DisplayJSAndOCViewController.h"
#import <WebViewJavascriptBridge.h>
#import "FileManager.h"
@interface DisplayJSAndOCViewController ()<UIWebViewDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong) WebViewJavascriptBridge *bridge;
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation DisplayJSAndOCViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"JSCommunicateWithOC";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpSubviews];
}

- (void)setUpSubviews {
    NSArray *titles = [NSArray arrayWithObjects:@"获取用户信息",@"弹窗输出",@"界面跳转",@"刷新界面",@"插入图片" ,nil];
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 300)];
        _webView.delegate = self;
    }
    [self.view addSubview:_webView];
    
    //2. 加载网页
    NSString *indexPath = [[NSBundle mainBundle]pathForResource:@"index.html" ofType:nil];
    NSString *appHtml   = [NSString stringWithContentsOfFile:indexPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL URLWithString:indexPath];
    [self.webView loadHTMLString:appHtml baseURL:baseURL];
    
    //3.开启日志
    [WebViewJavascriptBridge enableLogging];
    
    //4.给webView建立JS 和 OC 的沟通桥梁
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    
    //JS 调用oc的API:访问相册
    [self.bridge registerHandler:@"openCamera" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"需要%@图片",data[@"count"]);
        UIImagePickerController *imageVC = [[UIImagePickerController alloc]init];
        imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imageVC.delegate   = (id)self;
        [self presentViewController:imageVC animated:YES completion:nil];
    }];
    
    //JS 调用OC的api:访问底部弹窗
    [self.bridge registerHandler:@"showSheet" handler:^(id data, WVJBResponseCallback responseCallback) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"能调出来吗" message:@"这是第一次啊" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"I have clicked cancel button \n meessage:");
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"I have clicked OK button \n message:");
        }];
        
        [alertVC addAction:cancelAction];
        [alertVC addAction:okAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL];
//    [self.webView loadRequest:request];
    
    
    
    CGFloat offSetx    = (SCREENWIDTH -120*2)/3.0;
    CGFloat btnHeight  = 40;
    CGFloat btnWidth   = 120;
    CGFloat offSetY    = 15;
    for (int i=0;i<5;i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((offSetx +btnWidth)*(i%2)+offSetx, (btnHeight+15) *(i/2) +_webView.bottom +offSetY , btnWidth, btnHeight)];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.tag = 10 +i;
        [btn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-100, SCREENWIDTH, 100)];
    }
    NSData  *imageData = [[FileManager shareManager]readImageDataFile];
    UIImage *image = [[UIImage alloc]initWithData:imageData];
    if (image) {
        _imageView.image = image;
    }
    [self.view addSubview:_imageView];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData  *imageData = UIImagePNGRepresentation(image);
    [[FileManager shareManager]writeToFileWith:imageData];
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@",image);
}


// OC  call JS method
- (void)clickEvent:(UIButton *)sender {
    switch (sender.tag-10) {
        case 0:
        {
            [self getUserInfoMethod];
        }
            break;
        case 1:
        {
            [self showAlert];
        }
            break;
        case 2:
        {
            [self pushToSpecialWebsite];
        }
            break;
        case 3:
        {
            [self reloadWebPage];
        }
            break;
        case 4:
        {
            [self inertImageToWebPagr];
        }
            break;
        default:
            break;
    }
}

/**
 *  Get user's information.
 */
- (void)getUserInfoMethod {
    // OC call JS
    [self.bridge callHandler:@"getUserInfo" data:@{@"userId":@"DX001"} responseCallback:^(id responseData) {
        NSString *userInfo = [NSString stringWithFormat:@"%@,姓名:%@,年龄:%@",responseData[@"userID"],responseData[@"userName"],responseData[@"age"]];
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"网页端的用户信息" message:userInfo preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [vc addAction:cancelAction];
        [vc addAction:okAction];
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

/**
 *  Call the JS method to show alert view
 */
- (void)showAlert {
    //OC Call JS
    [self.bridge callHandler:@"alertMessage" data:@"调用了js中的Alert弹窗" responseCallback:^(id responseData) {
        NSLog(@"responseData:%@",responseData);
    }];
}

/**
 *  Call the JS method to load webview
 */
- (void)pushToSpecialWebsite {
    //OC call JS
    [self.bridge callHandler:@"pushToNewWebSite" data:@{@"url":@"http://m.jd.com"} responseCallback:^(id responseData) {
        NSLog(@"websiteInfo:%@",responseData);
    }];
}

/**
 *  Refresh webView
 */
- (void)reloadWebPage {
    [self.webView reload];
}

/**
 *  Insert a image on webview
 */
- (void)inertImageToWebPagr {
    
    NSDictionary *dict = @{
                           @"url" : @"http://upload-images.jianshu.io/upload_images/1268909-0e394c67e1ce6666.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                           };
    //OC call JS
    [self.bridge callHandler:@"insertImgToWebPage" data:dict responseCallback:^(id responseData) {
        NSLog(@"insertPageInfo:%@",responseData);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
