//
//  HistoryView.h
//  RadarIPad
//
//  Created by Yachen Dai on 8/11/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *productArray;

@property (strong, nonatomic) IBOutlet UIPickerView *startTimeChooser;

@property (strong, nonatomic) IBOutlet UIDatePicker *endTimeChooser;
@property (strong, nonatomic) IBOutlet UITableView *productTableView;

- (IBAction)predetemineTimeSearchControl:(id)sender;
- (IBAction)customTimeSearchBtnClick:(id)sender;

@end
