//
//  SystemViewController.m
//  RadarIPad
//
//  Created by Yachen Dai on 13-9-25.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import "SystemViewController.h"

@implementation SystemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.view.backgroundColor = ViewBackgroundColor;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = NO;
    //init title bar.
    self.title = @"系统设置";
    //init view
    systemView = [[SystemView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    [self.view addSubview:systemView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
