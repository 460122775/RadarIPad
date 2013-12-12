//
//  MainViewController.m
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-22.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

const float MoveAnimationDuration = 0.3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        productViewDic = [[NSMutableDictionary alloc] init];
        self.view.backgroundColor = ViewBackgroundColor;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //init title bar.
    self.title = @"首页";
    self.navigationItem.hidesBackButton = NO;
    
    leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(leftBtnClick)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(rightBtnClick)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    productMenuViewController = [[ProductMenuViewController alloc] init];
    [self addChildViewController:productMenuViewController];
    productMenuViewController.view.frame = self.view.bounds;
    [self.view addSubview:productMenuViewController.view];
    
    mainView = [[MainView alloc] initWithFrame:CGRectMake(0, TitleBarHeight, ViewWidth, ViewHeight)];
    mainView.backgroundColor = ViewBackgroundColor;
    [self.view addSubview:mainView];
    mainView.layer.shadowOffset = CGSizeMake(0, 0);
    mainView.layer.shadowColor = [UIColor blackColor].CGColor;
    mainView.layer.shadowOpacity = 1;
    
    [self initProductView];
}

- (void)viewWillAppear:(BOOL)animated
{
    // init
    sideBarShowing = NO;
    mainView.transform  = CGAffineTransformMakeTranslation(0, 0);
}

-(void)initProductView
{
    // First, get product dictionary.
    productDic = [ProductModel getInstance].productDic;
    // Second, create product small view by product dictionary.
    int no = 0;
    int width = (mainView.frame.size.width - Padding * 4) / 3;
    ProductSmallView *productSmallView = nil;
    for (id key in productDic)
    {
        productSmallView = [[ProductSmallView init]
                            initWithFrame:CGRectMake(Padding + (no % 3) * (width + Padding),
                                                     Padding + (no / 3) * (width + Padding),
                                                     width, width)];
        [mainView.productsScrollView addSubview:productSmallView];
        [productSmallView setImageView:[productDic objectForKey:key]];
        DLog(@"%f, %f",productSmallView.frame.origin.x, productSmallView.frame.origin.y);
        no++;
    }
    if((no + 1) / 3 * (width + Padding) < mainView.frame.size.height - 100){
        [mainView.productsScrollView setContentSize:CGSizeMake(mainView.frame.size.width, mainView.frame.size.height + 100)];
    }else{
        [mainView.productsScrollView setContentSize:CGSizeMake(mainView.frame.size.width, (no + 1) / 3 * (width + Padding) + 100)];
    }
}

#pragma -mark animation
- (void)leftBtnClick
{
    if (!sideBarShowing)
    {
        [self moveAnimationWithDirection:SideBarShowDirectionLeft duration:MoveAnimationDuration];
    }else{
        [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
    }
}

- (void)rightBtnClick
{
    if (!sideBarShowing)
    {
        [self moveAnimationWithDirection:SideBarShowDirectionRight duration:MoveAnimationDuration];
    }else{
        [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
    }
}

- (void)moveAnimationWithDirection:(SideBarShowDirection)direction duration:(float)duration
{
    void (^animations)(void) =^{
		switch (direction)
        {
            case SideBarShowDirectionNone:
                mainView.transform  = CGAffineTransformMakeTranslation(0, 0); break;
            case SideBarShowDirectionLeft:
                mainView.transform  = CGAffineTransformMakeTranslation(800, 0); break;
            case SideBarShowDirectionRight:
                mainView.transform  = CGAffineTransformMakeTranslation(-200, 0); break;
            default:break;
        }
	};
    void (^complete)(BOOL) = ^(BOOL finished)
    {
        mainView.userInteractionEnabled = YES;
        if (_tapGestureRecognizer)
        {
            [mainView removeGestureRecognizer:_tapGestureRecognizer];
            _tapGestureRecognizer = nil;
        }
        if (direction == SideBarShowDirectionNone)
        {
            sideBarShowing = NO;
        }else{
            _tapGestureRecognizer = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(tapOnContentView:)];
            [mainView addGestureRecognizer:_tapGestureRecognizer];
            sideBarShowing = YES;
        }
	};
    mainView.userInteractionEnabled = NO;
    [UIView animateWithDuration:duration animations:animations completion:complete];
}

- (void)tapOnContentView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [self moveAnimationWithDirection:SideBarShowDirectionNone duration:MoveAnimationDuration];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
