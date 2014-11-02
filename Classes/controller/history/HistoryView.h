//
//  HistoryView.h
//  RadarIPad
//
//  Created by Yachen Dai on 8/11/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryProductListView.h"
#import "RBCustomDatePickerView.h"

@protocol HistoryViewProtocol <NSObject>

@required
- (void)selectProduct:(int) index inDataArray:(NSMutableArray*) dataArray;

@end

@interface HistoryView : UIView<UITableViewDataSource, UITableViewDelegate, HistoryProductListProtocol>

@property (strong, nonatomic) NSMutableArray *productArray;
@property(nonatomic, assign) id<HistoryViewProtocol> delegate;

@property (strong, nonatomic) IBOutlet UIView *productConfigViewBg;
@property (strong, nonatomic) IBOutlet UITableView *productTableView;

@property (strong, nonatomic) IBOutlet UIView *conditionViewBg;
@property (strong, nonatomic) IBOutlet UIView *conditionView;
@property (strong, nonatomic) IBOutlet RBCustomDatePickerView *startTimeChooserView;
@property (strong, nonatomic) IBOutlet RBCustomDatePickerView *endTimeChooserView;
@property (strong, nonatomic) IBOutlet UIView *historyProductListViewBg;
@property (strong, nonatomic) IBOutlet HistoryProductListView *historyProductListView;

- (IBAction)predetemineTimeSearchControl:(id)sender;
- (IBAction)customTimeSearchBtnClick:(id)sender;

@end
