//
//  ApplicationControllerViewController.m
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-21.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import "ApplicationController.h"

@implementation ApplicationController
static ApplicationController *applicationController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(loginSuccessControl:)
                                                     name: LOGINSUCCESS
                                                   object: nil];
    }
    return self;
}

-(ApplicationController*)getInstance
{
    if(!applicationController)
    {
        applicationController = [[ApplicationController alloc] init];
    }
    return applicationController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //login when application start.
    LoginViewController *loginViewController=[[LoginViewController alloc]init];
    loginViewController.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (void)loginSuccessControl:(NSNotification*) notification
{
    userVo = [notification object];
    mainViewController = [[MainViewController alloc] init];
    mainViewController.navigationItem.hidesBackButton = YES;
    [self.navigationController pushViewController:mainViewController animated:YES];
}

#pragma mark - InterfaceOrientation
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
