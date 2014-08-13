//
//  FirstProductListView.m
//  RadarIPad
//
//  Created by Yachen Dai on 8/7/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "HistoryProductListView.h"

@implementation HistoryProductListView
@synthesize productDataArray, delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    tableView = [[UITableView alloc]
                 initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self addSubview:tableView];
}

- (void)didMoveToSuperview
{
    self.productDataArray = [[NSMutableArray alloc] initWithObjects:
                             @"20140701_000218.02.003.000_2.40 97KB",
                             @"20140701_000908.02.003.000_2.40 92KB",
                             @"20140701_001556.02.003.000_2.40 96KB",
                             @"20140701_002311.02.003.000_2.40 86KB",
                             @"20140701_003003.02.003.000_2.40 78KB",
                             @"20140701_002311.02.003.000_2.40 75KB",
                             @"20140701_001556.02.003.000_2.40 68KB",
                             @"20140701_000908.02.003.000_2.40 92KB",
                             @"20140701_000218.02.003.000_2.40 97KB",
                             nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 41;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)_tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40)];
    [sectionView setBackgroundColor:[UIColor whiteColor]];
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, tableView.bounds.size.width, 40);
    label.backgroundColor = [UIColor clearColor];
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18];
    label.text = @"历史查询结果";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = ProductTextColor;
    [sectionView addSubview:label];
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"HistoryProductDataListCell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 284, 40)];
        contentLabel.tag = 1;
        [contentLabel setTextColor:ProductTextColor];
        [contentLabel setFont: [UIFont fontWithName:@"Helvetica" size:14.5]];
        [contentLabel setTextAlignment:NSTextAlignmentCenter];
        [cell addSubview:contentLabel];
    }
    if (indexPath.row % 2 == 1)
    {
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = ForeGroundBlueColor;
    }
    if(indexPath.row > self.productDataArray.count - 1) return cell;
    [(UILabel*)[cell viewWithTag:1] setText:(NSString*)[self.productDataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = 0;
    for(UITableViewCell *cell in _tableView.visibleCells)
    {
        if (index++ % 2 == 1)
        {
            cell.backgroundColor = [UIColor whiteColor];
        }else{
            cell.backgroundColor = ForeGroundBlueColor;
        }
        ((UILabel*)[cell viewWithTag:1]).textColor = ProductTextColor;
    }
    [_tableView cellForRowAtIndexPath:indexPath].backgroundColor = BackGroundBlueColor;
    ((UILabel*)[[_tableView cellForRowAtIndexPath:indexPath] viewWithTag:1]).textColor = [UIColor whiteColor];

    //Test Code...
    NSString *productStr = (NSString*)[self.productDataArray objectAtIndex:indexPath.row];
    ProductInfo *vo = [[ProductInfo alloc] initWithPosFileStr:[NSString stringWithFormat:@"/%@.zdb",[productStr substringWithRange:NSMakeRange(0, productStr.length - 5)]]];
    //Test End...
    
    [self.delegate selectProduct:vo];
    productStr = nil;
    vo = nil;
}

@end
