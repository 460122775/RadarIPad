//
//  MessageView.h
//  RadarIPad
//
//  Created by Yachen Dai on 7/25/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductView.h"

@interface MessageView : UIView{
    UITableView *tableView;
    UIButton *switchBtn;
    UIButton *voiceBtn;
    UIButton *sendBtn;
    UITextView *textView;
}

@property (strong, nonatomic) IBOutlet UIView *leftListViewBg;
@property (strong, nonatomic) IBOutlet UITableView *leftTableView;
@property (strong, nonatomic) IBOutlet UIView *rightViewBg;
@property (strong, nonatomic) IBOutlet UIView *rightView;

@end
