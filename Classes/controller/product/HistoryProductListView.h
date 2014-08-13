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
- (void)selectProduct:(id) productObject;

@end

@interface HistoryProductListView : UIView<UITableViewDataSource, UITableViewDelegate>{
    UITableView *tableView;
}

@property(nonatomic, retain) NSMutableArray *productDataArray;
@property(nonatomic, assign) id<HistoryProductListProtocol> delegate;

@end


