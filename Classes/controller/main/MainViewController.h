//
//  MainViewController.h
//  RadarIPad
//
//  Created by Yachen Dai on 7/21/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductFactory.h"
#import "ProductDrawDataProtocol.h"
#import "ProductView.h"
#import "MessageView.h"
#import "VoiceView.h"
#import "HistoryView.h"
#import "SettingView.h"

@interface MainViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *btn_scrollView;
@property (strong, nonatomic) ProductModel<ProductDrawDataProtocol>* currentProductModel;

@property (strong, nonatomic) ProductView *productView;
@property (strong, nonatomic) HistoryView *historyView;
@property (strong, nonatomic) MessageView *messageView;
@property (strong, nonatomic) VoiceView *voiceView;
@property (strong, nonatomic) SettingView *settingView;

+ (MainViewController*) instance;

- (IBAction)productBtnClick:(id)sender;
- (IBAction)historyBtnClick:(id)sender;
- (IBAction)voiceBtnClick:(id)sender;
- (IBAction)messageBtnClick:(id)sender;
- (IBAction)settingBtnClick:(id)sender;

@end
