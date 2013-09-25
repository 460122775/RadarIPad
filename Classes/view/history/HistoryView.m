//
//  HistoryView.m
//  RadarIPad
//
//  Created by Yachen Dai on 13-9-25.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import "HistoryView.h"

@implementation HistoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    int yPosition = Padding;
    // init left bar.
    productChooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(Padding, yPosition, 120, 40)];
    [productChooseBtn setTitle:@"产品选择" forState:UIControlStateNormal];
    [productChooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [productChooseBtn setBackgroundColor:BlueBackGroundColor];
    [self addSubview:productChooseBtn];
    
    productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding + 130, yPosition, 150, 40)];
    yPosition += 45;
    [productNameLabel setTextColor:[UIColor darkGrayColor]];
    [productNameLabel setText:@"<<请选择"];
    [self addSubview:productNameLabel];
    
    startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding, yPosition, 100, 40)];
    yPosition += 45;
    [startTimeLabel setText:@"开始时间:"];
    [startTimeLabel setTextColor:[UIColor darkGrayColor]];
    [self addSubview:startTimeLabel];
    
    endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding, yPosition, 100, 40)];
    yPosition += 45;
    [endTimeLabel setText:@"结束时间:"];
    [endTimeLabel setTextColor:[UIColor darkGrayColor]];
    [self addSubview:endTimeLabel];
    
    searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(Padding, yPosition, 300, 40)];
    yPosition += 45;
    [searchBtn setTitle:@"数据查询" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:BlueBackGroundColor];
    [self addSubview:searchBtn];
    
    elevationChooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(Padding, yPosition, 120, 40)];
    [elevationChooseBtn setTitle:@"仰角选择" forState:UIControlStateNormal];
    [elevationChooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [elevationChooseBtn setBackgroundColor:BlueBackGroundColor];
    [self addSubview:elevationChooseBtn];
    
    elevationChooseBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding + 130, yPosition, 150, 40)];
    yPosition += 45;
    [elevationChooseBtnLabel setText:@"<<请选择"];
    [elevationChooseBtnLabel setTextColor:[UIColor darkGrayColor]];
    [self addSubview:elevationChooseBtnLabel];
    
    createAnimationBtn = [[UIButton alloc] initWithFrame:CGRectMake(Padding, yPosition, 300, 40)];
    yPosition += 45;
    [createAnimationBtn setTitle:@"生成动画" forState:UIControlStateNormal];
    [createAnimationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createAnimationBtn setBackgroundColor:BlueBackGroundColor];
    [self addSubview:createAnimationBtn];
    
    dataTableView = [[UITableView alloc] initWithFrame:
                     CGRectMake(Padding, yPosition, 300, self.frame.size.height - 100 - yPosition - Padding)
                                                 style:UITableViewStyleGrouped];
    [dataTableView setBackgroundColor:[UIColor clearColor]];
    [dataTableView setBackgroundView:nil];
    [dataTableView setDelegate:self];
    [dataTableView setDataSource:self];
    [self addSubview:dataTableView];
    
    //init middle bar.
    historyScrollView = [[UIScrollView alloc] initWithFrame:
                         CGRectMake(300 + Padding * 2, Padding, self.frame.size.width - 300 - Padding * 3, self.frame.size.height - Padding * 2 - 100)];
    [historyScrollView setBackgroundColor:[UIColor clearColor]];
    [historyScrollView.layer setBorderColor:GrayColor.CGColor];
    [historyScrollView.layer setBorderWidth:2];
    [self addSubview:historyScrollView];
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set categories
    static NSString *Identifier = @"HistoryCell";
    UITableViewCell *cell = [dataTableView dequeueReusableCellWithIdentifier: Identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        UIView *selectionview = [[UIView alloc]initWithFrame:cell.bounds];
        [selectionview setBackgroundColor:[UIColor clearColor]];
        cell.selectedBackgroundView=selectionview;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
