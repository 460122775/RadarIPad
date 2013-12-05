//
//  MainViewController.m
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-22.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.productDic = [[NSMutableDictionary alloc] init];
        self.view.backgroundColor = ViewBackgroundColor;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.navigationItem.hidesBackButton = NO;
    //init title bar.
    self.title = @"首页";
    //init the title bar button.
    leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(leftBtnClick)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightBtnClick)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    // test code ....
    for (int i = 0; i < 6; i++)
    {
        [self.productDic setValue:[[ProductSmallView alloc] init] forKey:[NSString stringWithFormat:@"Test%i", i]];
    }
    mainView = [[MainView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    mainView.productDic = self.productDic;
    [self.view addSubview:mainView];
}

- (void)leftBtnClick
{
    if (!productDataTableView)
    {
        productDataTableView = [[ProductDataTableView alloc] initWithFrame:CGRectMake(0, 0, 300, self.view.frame.size.height - 100)];
    }
    // Animation of push out from left.
    
}

- (void)rightBtnClick
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
