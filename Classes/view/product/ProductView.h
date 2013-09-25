//
//  ProductView.h
//  RadarIPad
//
//  Created by Yachen Dai on 13-9-25.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductView : UIView<UITableViewDelegate, UITableViewDataSource>{
    NSMutableDictionary *productViewDic;
    
    UIButton *productChooseBtn;
    UILabel *productNameLabel;
    UIView *parameterView;
    UITableView *productTableView;
    UILabel *parameterAttentionLabel;
    
}

@end
