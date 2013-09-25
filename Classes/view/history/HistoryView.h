//
//  HistoryView.h
//  RadarIPad
//
//  Created by Yachen Dai on 13-9-25.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface HistoryView : UIView<UITableViewDataSource, UITableViewDelegate>{
    UIButton *productChooseBtn;
    UILabel *productNameLabel;
    
    UILabel *startTimeLabel;
    
    UILabel *endTimeLabel;
    
    UIButton *searchBtn;
    
    UIButton *elevationChooseBtn;
    UILabel *elevationChooseBtnLabel;
    UIButton *createAnimationBtn;
    
    UITableView *dataTableView;
    
    UIScrollView *historyScrollView;
    UIView *animationView;
}

@end
