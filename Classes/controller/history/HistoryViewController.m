//
//  HistoryViewController.m
//  RadarIPad
//
//  Created by Yachen Dai on 13-9-25.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import "HistoryViewController.h"

@implementation HistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self.view setBackgroundColor:ViewBackgroundColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = NO;
    //init title bar.
    self.title = @"历史查询";
    //init view
    historyView = [[HistoryView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    [self.view addSubview:historyView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
