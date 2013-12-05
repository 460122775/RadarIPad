//
//  AppDelegate.m
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-17.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize window,na,tabBarController,controllerArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.na = [[UINavigationController alloc] initWithRootViewController:[[ApplicationController alloc] init]];
    self.window.rootViewController = self.na;
    self.window.backgroundColor = [UIColor whiteColor];
    self.na.navigationBar.hidden = YES;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)initTabBar
{
    if (self.tabBarController)
    {
        self.window.rootViewController = self.tabBarController;
        self.tabBarController.selectedIndex = 0;
        return;
    }
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.controllerArray = [[NSMutableArray alloc] initWithCapacity:5];
    UIViewController *controller = nil;
    
    controller = [[MainViewController alloc] init];
    self.na = [[UINavigationController alloc] initWithRootViewController:controller];
    self.na.navigationBarHidden = NO;
    self.na.navigationBar.barStyle = UIBarStyleBlack;
    self.na.tabBarItem = [self.na.tabBarItem initWithTitle:@"产品首页" image:[UIImage imageNamed:@"first"] tag:0];
    [self.controllerArray addObject:self.na];
    
    controller = [[HistoryViewController alloc] init];
    self.na = [[UINavigationController alloc] initWithRootViewController:controller];
    self.na.navigationBarHidden = NO;
    self.na.navigationBar.barStyle = UIBarStyleBlack;
    self.na.tabBarItem = [self.na.tabBarItem initWithTitle:@"历史查询" image:[UIImage imageNamed:@"first"] tag:3];
    [self.controllerArray addObject:self.na];
    
    controller = [[ProductViewController alloc] init];
    self.na = [[UINavigationController alloc] initWithRootViewController:controller];
    self.na.navigationBarHidden = NO;
    self.na.navigationBar.barStyle = UIBarStyleBlack;
    self.na.tabBarItem = [self.na.tabBarItem initWithTitle:@"产品申请" image:[UIImage imageNamed:@"first"] tag:1];
    [self.controllerArray addObject:self.na];
    
    controller = [[ControlViewController alloc] init];
    self.na = [[UINavigationController alloc] initWithRootViewController:controller];
    self.na.navigationBarHidden = NO;
    self.na.navigationBar.barStyle = UIBarStyleBlack;
    self.na.tabBarItem = [self.na.tabBarItem initWithTitle:@"雷达控制" image:[UIImage imageNamed:@"first"] tag:2];
    [self.controllerArray addObject:self.na];
    
    controller = [[SystemViewController alloc] init];
    self.na = [[UINavigationController alloc] initWithRootViewController:controller];
    self.na.navigationBarHidden = NO;
    self.na.navigationBar.barStyle = UIBarStyleBlack;
    self.na.tabBarItem = [self.na.tabBarItem initWithTitle:@"系统设置" image:[UIImage imageNamed:@"first"] tag:4];
    [self.controllerArray addObject:self.na];
    
    self.tabBarController.viewControllers = self.controllerArray;
    [self.window addSubview:self.tabBarController.view];
    self.window.rootViewController = self.tabBarController;
    
    self.tabBarController.tabBar.translucent = NO;
    self.tabBarController.tabBar.barTintColor = RGB(248, 248, 248);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
