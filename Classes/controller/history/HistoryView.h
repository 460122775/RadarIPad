//
//  HistoryView.h
//  RadarIPad
//
//  Created by Yachen Dai on 8/11/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryProductListView.h"

@interface HistoryView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *productArray;

@property (strong, nonatomic) IBOutlet UIView *productConfigViewBg;
@property (strong, nonatomic) IBOutlet UITableView *productTableView;

@property (strong, nonatomic) IBOutlet UIView *conditionViewBg;
@property (strong, nonatomic) IBOutlet UIView *conditionView;
@property (strong, nonatomic) IBOutlet UIPickerView *startTimeChooser;
@property (strong, nonatomic) IBOutlet UIPickerView *endTimeChooser;

@property (strong, nonatomic) IBOutlet UIView *historyProductListViewBg;
@property (strong, nonatomic) IBOutlet HistoryProductListView *historyProductListView;

- (IBAction)predetemineTimeSearchControl:(id)sender;
- (IBAction)customTimeSearchBtnClick:(id)sender;

@end
