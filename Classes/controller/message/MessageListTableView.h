//
//  MessageListTableView.h
//  RadarIPad
//
//  Created by Yachen Dai on 11/17/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageListTableView : UITableView<UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (nonatomic, retain) NSMutableArray *messageListArray;

@end
