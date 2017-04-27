//
//  AppDelegate.m
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/15.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MovieViewController.h"
#import "SquareViewController.h"
#import "MusicStockViewController.h"
#import "UncaughtExceptionHandler.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    InstallUncaughtExceptionHandler();
    [NSThread sleepForTimeInterval:2.0f];

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self setUpMainViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setUpMainViewController {
    UINavigationController *courseNav = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    courseNav.tabBarItem.title = @"百度课堂";
    
    UINavigationController *movieNav  = [[UINavigationController alloc]initWithRootViewController:[MovieViewController new]];
    movieNav.tabBarItem.title  = @"电影专辑";
    
    UINavigationController *squareNav = [[UINavigationController alloc]initWithRootViewController:[SquareViewController new]];
    squareNav.tabBarItem.title = @"美丽广场";
    
    UINavigationController *musciNav = [[UINavigationController alloc]initWithRootViewController:[MusicStockViewController new]];
    musciNav.tabBarItem.title = @"音乐天地";

    
    UITabBarController *tabbar = [[UITabBarController alloc]init];
    [tabbar setViewControllers:@[courseNav,movieNav,squareNav,musciNav]];
    self.window.rootViewController = tabbar;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
