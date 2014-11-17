//
//  MessageView.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/25/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "MessageView.h"

@implementation MessageView

@synthesize leftListViewBg, leftTableView, rightView, rightViewBg, userNameTitleView, userNameLabel, speakBar, sendBtn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:BackGroundGrayColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [ProductView setShadowTaste:self.leftListViewBg andForeView:self.leftTableView];
    [ProductView setShadowTaste:self.rightViewBg andForeView:self.rightView];
    [self.userNameTitleView setBackgroundColor:BackGroundBlueColor];
    [self.userNameLabel setTextColor:[UIColor whiteColor]];
    [self.speakBar.layer setBorderWidth:1];
    [self.speakBar.layer setBorderColor:[BackGroundBlueColor CGColor]];
    [self.sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sendBtn setBackgroundColor:BackGroundBlueColor];
    
    [self.leftTableView setFriendListDelegate:self];
    [self.leftTableView reloadData];
}

- (void)switchBtnClick:(id)sender
{
//    if (switchBtn.tag == 0)
//    {
//        [switchBtn setBackgroundImage:[UIImage imageNamed:@"keyboard.png"] forState:UIControlStateNormal];
//        [textView removeFromSuperview];
//        [sendBtn removeFromSuperview];
//        [self addSubview:voiceBtn];
//        switchBtn.tag = 1;
//    }else{
//        [switchBtn setBackgroundImage:[UIImage imageNamed:@"voice2.png"] forState:UIControlStateNormal];
//        [voiceBtn removeFromSuperview];
//        [self addSubview:textView];
//        [self addSubview:sendBtn];
//        switchBtn.tag = 0;
//    }
}

#pragma -mark FriendListTableViewProtocol
- (void)selectedCellControl:(NSString *)cellLabel
{
    [self.userNameLabel setText:cellLabel];
}

@end
