//
//  MainViewController.h
//  RadarIPad
//
//  Created by Yachen Dai on 7/21/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductView.h"
#import "MessageView.h"
#import "VoiceView.h"
#import "SettingView.h"

@interface MainViewController : UIViewController<ProductViewProtocol, HistoryViewProtocol>

@property (strong, nonatomic) IBOutlet UIView *btn_scrollViewBg;
@property (strong, nonatomic) IBOutlet UIScrollView *btn_scrollView;
@property (strong, nonatomic) IBOutlet UIButton *historyBtn;
@property (strong, nonatomic) IBOutlet UIButton *messageBtn;
@property (strong, nonatomic) IBOutlet UIButton *voiceBtn;
@property (strong, nonatomic) IBOutlet UIButton *settingBtn;

@property (strong, nonatomic) ProductView *productView;
@property (strong, nonatomic) HistoryView *historyView;
@property (strong, nonatomic) MessageView *messageView;
@property (strong, nonatomic) VoiceView *voiceView;
@property (strong, nonatomic) SettingView *settingView;

+ (MainViewController*) instance;

- (IBAction)historyBtnClick:(id)sender;
- (IBAction)playBtnClick:(id)sender;
- (IBAction)camaraBtnClick:(id)sender;
- (IBAction)knifeBtnClick:(id)sender;
- (IBAction)positionBtnClick:(id)sender;
- (IBAction)messageBtnClick:(id)sender;
- (IBAction)voiceBtnClick:(id)sender;
- (IBAction)settingBtnClick:(id)sender;

@end
