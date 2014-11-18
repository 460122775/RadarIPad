//
//  AppDelegate.m
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-17.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize window,rootViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.rootViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    self.window.rootViewController = self.rootViewController;
    [self.window makeKeyAndVisible];
    // Init data...
    [self initControl];
    return YES;
}

- (void)initControl
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
//    DLog(@">>>>>>DBPath:%@", DBPath);
//    DLog(@">>>>>>DataPath:%@", DataPath);
//    DLog(@">>>>>>defaultDataPath:%@", defaultDataPath);
//    DLog(@">>>>>>defaultDBPath:%@", defaultDBPath);
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    NSDirectoryEnumerator *direnum = [fileManager enumeratorAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@""]];//枚举目录
    NSString *filename = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:DataPath withIntermediateDirectories:YES attributes:nil error:nil];
    while (filename = [direnum nextObject])
    {
        if([[filename pathExtension] isEqualToString:@"zdb"])
        {
            success = [fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@", DataPath, filename]];
            if (success == NO)
            {
                success = [fileManager copyItemAtPath:[NSString stringWithFormat:@"%@/%@", defaultDataPath, filename] toPath:[NSString stringWithFormat:@"%@/%@", DataPath, filename] error:&error];
//                if (!success)
//                {
//                    NSAssert1(0, @"Failed to create writable database file with message '%@'.", @"/predata/db/db0_0.db" );
//                }
            }
        }
    }
    [DBModel initDB];
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
