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
@protocol CurrentProductListDelegate <NSObject>

@required
- (void)selectProduct:(id)productObject;

@end

@interface CurrentProductListView : UIView<UITableViewDataSource, UITableViewDelegate>{
    UITableView *tableView;
}

@property(nonatomic, retain) NSMutableArray *productArray;
@property(nonatomic, assign) id<CurrentProductListDelegate> delegate;

@end
