//
//  ProductMenuView.h
//  RadarIPad
//
//  Created by Yachen Dai on 12/12/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductMenuView : UIView<UITableViewDelegate, UITableViewDataSource>{
    UIButton *firstProductBtn;
    UITableView *firstProductTable;
    
    UIButton *secondProductBtn;
    UITableView *secondProductTable;
}

@end
