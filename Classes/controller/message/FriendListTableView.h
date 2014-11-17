//
//  FriendListTableView.h
//  RadarIPad
//
//  Created by Yachen Dai on 11/17/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FriendListTableViewProtocol <NSObject>

- (void)selectedCellControl:(NSString*) cellLabel;

@end

@interface FriendListTableView : UITableView<UITableViewDelegate, UITableViewDataSource>{
    
}

@property (nonatomic, retain) NSMutableArray *friendListArray;
@property (nonatomic, assign) id<FriendListTableViewProtocol> friendListDelegate;

@end
