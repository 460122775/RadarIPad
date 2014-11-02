//
//  MessageView.m
//  RadarIPad
//
//  Created by Yachen Dai on 7/25/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "MessageView.h"

@implementation MessageView

@synthesize leftListViewBg, leftTableView, rightView, rightViewBg;

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
    
    // Drawing code
//    int padding = 5;
//    tableView = [[UITableView alloc] initWithFrame:CGRectMake(padding, padding, self.frame.size.width - padding * 2, self.frame.size.height - 60 - padding * 3)];
//    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [tableView.layer setBorderWidth:1];
//    [tableView.layer setBorderColor:[BackGroundBlueColor CGColor]];
//    [self addSubview: tableView];
//    
//    switchBtn = [[UIButton alloc] initWithFrame:CGRectMake(padding, tableView.frame.size.height + padding * 2, 60, 60)];
//    [switchBtn.layer setBorderWidth:1];
//    [switchBtn.layer setBorderColor:[BackGroundBlueColor CGColor]];
//    [switchBtn setBackgroundImage:[UIImage imageNamed:@"voice2.png"] forState:UIControlStateNormal];
//    [switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:switchBtn];
//    
//    voiceBtn = [[UIButton alloc] initWithFrame:CGRectMake(switchBtn.frame.size.width + padding * 2, tableView.frame.size.height + padding * 2, self.frame.size.width - 60 - padding * 3, 60)];
//    [voiceBtn setTitle:@"长按说话" forState:UIControlStateNormal];
//    [voiceBtn setTitleColor:BackGroundBlueColor forState:UIControlStateNormal];
//    [voiceBtn.layer setBorderColor:[BackGroundBlueColor CGColor]];
//    [voiceBtn.layer setBorderWidth:1];
//    
//    textView = [[UITextView alloc] initWithFrame:CGRectMake(switchBtn.frame.size.width + padding * 2, tableView.frame.size.height + padding * 2, self.frame.size.width - 60 * 2 - padding * 4, 60)];
//    [textView.layer setBorderWidth:1];
//    [textView.layer setBorderColor:[BackGroundBlueColor CGColor]];
//    [textView setFont:[UIFont fontWithName:@"Heiti SC" size:16]];
//    [self addSubview:textView];
//    
//    sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(switchBtn.frame.size.width + textView.frame.size.width + 3 * padding, tableView.frame.size.height + padding * 2, 60, 60)];
//    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
//    [sendBtn setTitleColor:BackGroundBlueColor forState:UIControlStateNormal];
//    [sendBtn.layer setBorderWidth:1];
//    [sendBtn.layer setBorderColor:[BackGroundBlueColor CGColor]];
//    [self addSubview: sendBtn];
}

- (void)switchBtnClick:(id)sender
{
    if (switchBtn.tag == 0)
    {
        [switchBtn setBackgroundImage:[UIImage imageNamed:@"keyboard.png"] forState:UIControlStateNormal];
        [textView removeFromSuperview];
        [sendBtn removeFromSuperview];
        [self addSubview:voiceBtn];
        switchBtn.tag = 1;
    }else{
        [switchBtn setBackgroundImage:[UIImage imageNamed:@"voice2.png"] forState:UIControlStateNormal];
        [voiceBtn removeFromSuperview];
        [self addSubview:textView];
        [self addSubview:sendBtn];
        switchBtn.tag = 0;
    }
    
}


@end
