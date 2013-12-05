//
//  ProductDataTableView.h
//  RadarIPad
//
//  Created by Yachen Dai on 13-9-27.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDataTableView : UIView<UITableViewDataSource, UITableViewDelegate>{
    UITableView *productDataTableView;
}

@property(nonatomic, retain) NSMutableArray *productDataArray;

@end
