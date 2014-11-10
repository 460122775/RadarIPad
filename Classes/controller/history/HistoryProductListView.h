//
//  FirstProductListView.h
//  RadarIPad
//
//  Created by Yachen Dai on 8/7/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductFactory.h"
#import "ProductInfo.h"

@class ProductView;
@protocol HistoryProductListProtocol <NSObject>

@required
- (void)selectProduct:(int) index inDataArray:(NSMutableArray*) dataArray;
- (void)retryControl;

@end

@interface HistoryProductListView : UIView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *productDataArray;
@property (nonatomic, assign) id<HistoryProductListProtocol> delegate;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, retain) UIButton *backBtn;
@property (nonatomic, assign) BOOL showBackBtn;

- (void)resizeTableView;
- (NSMutableArray*)getArrayByProductType:(int)productType;

@end


