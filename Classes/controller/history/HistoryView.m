//
//  HistoryView.m
//  RadarIPad
//
//  Created by Yachen Dai on 8/11/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "HistoryView.h"

@implementation HistoryView

@synthesize startTimeChooserView, endTimeChooserView, productTableView, historyProductListView, productArray, productConfigViewBg, conditionView, conditionViewBg, historyProductListViewBg, delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [ProductView setShadowTaste:productConfigViewBg andForeView:productTableView];
    [ProductView setShadowTaste:conditionViewBg andForeView:conditionView];
    [ProductView setShadowTaste:self.historyProductListViewBg andForeView:self.historyProductListView];
    
    RBCustomDatePickerView *startTimeChooserPicker = [[RBCustomDatePickerView alloc] initWithFrame:CGRectMake(-5, -130, 305, 216)];
    [self.startTimeChooserView addSubview:startTimeChooserPicker];
    
    RBCustomDatePickerView *endTimeChooserPicker = [[RBCustomDatePickerView alloc] initWithFrame:CGRectMake(-5, -130, 305, 216)];
    [self.endTimeChooserView addSubview:endTimeChooserPicker];
    
    historyProductListView.delegate = self;
    historyProductListView.showBackBtn = NO;
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];

    self.productArray = [[NSMutableArray alloc] initWithObjects:@"基本反射率[Z]",@"基本速度[V]",@"基本谱宽[W]",
                         @"距离高度显示[RHI]",@"垂直最大反射率[MAXREF]",@"垂直累积液态含水量[VIL]",@"回波顶高[ET]",
                         @"回波底高[EB]",@"一小时降水量[OHP]",@"三小时降水量[THP]",@"等高平面位置显示[CAPPI]",
                         @"多层反射率CAPPI",@"多层速度CAPPI",@"多层谱宽CAPPI",@"反射率垂直切割[RCS]",
                         @"速度垂直切割[VCS]",@"谱宽垂直切割[WCS]",@"雨强[RZ]",@"组合反射率平均值[LRA]",
                         @"组合反射率最大值[LRM]",nil];
    self.productTableView.delegate = self;
    self.productTableView.dataSource = self;
    [self.productTableView reloadData];
    [self.productTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]    animated:YES scrollPosition:UITableViewScrollPositionTop];
    
}

- (IBAction)predetemineTimeSearchControl:(id)sender
{
//    int timeInterval = ((UIButton*)sender).tag;
//    [self.startTimeChooser setDate:[[NSDate alloc] init]];
//    [self.endTimeChooser setDate:[[NSDate alloc] initWithTimeInterval: -1 * timeInterval * 3600 / 2
//                                                            sinceDate:self.startTimeChooser.date]];
}

- (IBAction)customTimeSearchBtnClick:(id)sender
{

}

static int selectedIndex = 0;
- (int)getSelectedProductType
{
    NSString *text = (NSString*)[self.productArray objectAtIndex:selectedIndex];
    if ([text  isEqual: @"基本速度[V]"])
    {
        return ProductType_V;
    }else if([text  isEqual: @"基本谱宽[W]"]){
        return ProductType_W;
    }else{
        return ProductType_R;
    }
    text = nil;
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 17;
}

- (UIView *)tableView:(UITableView *)_tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.productTableView.bounds.size.width, 40)];
    [sectionView setBackgroundColor:BackGroundBlueColor];
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, self.productTableView.bounds.size.width, 40);
    label.backgroundColor = [UIColor clearColor];
    label.font=[UIFont fontWithName:@"Helvetica" size:18];
    label.text = @"产品选择列表";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [sectionView addSubview:label];
    return sectionView;
}

static NSString *Identifier = @"HistoryProductListCell";
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
        [cell.textLabel setFrame:cell.bounds];
        [cell.textLabel setTextColor:ProductTextColor];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    }
    if (indexPath.row % 2 == 1)
    {
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = ForeGroundBlueColor;
    }
    if(indexPath.row > self.productArray.count - 1) return cell;
    [cell.textLabel setText:(NSString*)[self.productArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = 0;
    for(UITableViewCell *cell in _tableView.visibleCells)
    {
        if (selectedIndex++ % 2 == 1)
        {
            cell.backgroundColor = [UIColor whiteColor];
        }else{
            cell.backgroundColor = ForeGroundBlueColor;
        }
        [cell.textLabel setTextColor:ProductTextColor];
    }
    selectedIndex = indexPath.row;
    [_tableView cellForRowAtIndexPath:indexPath].backgroundColor = BackGroundBlueColorA;
    [_tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor whiteColor];
    
    // Test Start...
    [self.historyProductListView getArrayByProductType:[self getSelectedProductType]];
    // Test End...
}

#pragma mark HistoryProductListProtocol
- (void)selectProduct:(int) index inDataArray:(NSMutableArray*) dataArray
{
    [self.delegate selectProduct:index inDataArray:dataArray];
}

- (void)retryControl
{
    
}

@end
