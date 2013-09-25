//
//  ControlPageView.h
//  YWRadar
//
//  Created by Yachen Dai on 13-8-11.
//  Copyright (c) 2013年 yuanwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlView : UIView<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>{
    UIScrollView *backgroundScrollView;
    
    UILabel *radarStateLabel;
    UILabel *directionLabel;
    UILabel *directionValueLabel;
    UILabel *elevationLabel;
    UILabel *elevationValueLabel;
    UILabel *rateLabel;
    UILabel *rateValueLabel;
    UISegmentedControl *radarStateSegment;
    UIView *radarStateContentView;
    
    UILabel *logTitleLabel;
    UITextView *contentTextView;
    UILabel *commandLabel;
    UITextField *commandInputTxfld;
    
    UILabel *controlTitle;
    UIButton *addUserBtn;
    UILabel *pageContentLabel;
    UIButton *lastPageBtn;
    UIButton *nextPageBtn;
    UITableView *userTableView;
}

@end
