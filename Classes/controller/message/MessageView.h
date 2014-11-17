//
//  MessageView.h
//  RadarIPad
//
//  Created by Yachen Dai on 7/25/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendListTableView.h"

@interface MessageView : UIView<FriendListTableViewProtocol>{
    
}

@property (strong, nonatomic) IBOutlet UIView *leftListViewBg;
@property (strong, nonatomic) IBOutlet FriendListTableView *leftTableView;
@property (strong, nonatomic) IBOutlet UIView *rightViewBg;
@property (strong, nonatomic) IBOutlet UIView *rightView;
@property (strong, nonatomic) IBOutlet UIView *userNameTitleView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UIView *speakBar;
@property (strong, nonatomic) IBOutlet UIButton *sendBtn;

@end
