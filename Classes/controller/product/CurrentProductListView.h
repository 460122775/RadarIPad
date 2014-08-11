//
//  FirstProductListView.h
//  RadarIPad
//
//  Created by Yachen Dai on 8/7/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductFactory.h"
#import "ProductVo.h"

@interface CurrentProductListView : UIView<UITableViewDataSource, UITableViewDelegate>{
    UITableView *tableView;
}

@property(nonatomic, retain) NSMutableArray *productArray;

@end
