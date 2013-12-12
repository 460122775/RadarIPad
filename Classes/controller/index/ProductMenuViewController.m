//
//  ProductMenuControllerViewController.m
//  RadarIPad
//
//  Created by Yachen Dai on 12/10/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import "ProductMenuViewController.h"

@implementation ProductMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    productMenuView = [[ProductMenuView alloc] initWithFrame:CGRectMake(0, TitleBarHeight, ViewWidth, ViewHeight)];
    [self.view addSubview:productMenuView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
