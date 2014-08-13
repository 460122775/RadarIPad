//
//  FirstProductListView.m
//  RadarIPad
//
//  Created by Yachen Dai on 8/7/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "CurrentProductListView.h"

@implementation CurrentProductListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.productArray = [ProductFactory getProductList:[[NSMutableArray alloc] init]];
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
    label.text = @"实时产品列表";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = ProductTextColor;
    [sectionView addSubview:label];
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"CurrentProductListCell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
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
    ProductVo *vo = (ProductVo*)[self.productArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@(%@)", vo.name, vo.ename]];
    
    vo = nil;
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
        [cell.textLabel setTextColor:ProductTextColor];
    }
    [_tableView cellForRowAtIndexPath:indexPath].backgroundColor = BackGroundBlueColor;
    [_tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor whiteColor];
    
    //Test Code...
    ProductInfo *vo = nil;
    switch (((ProductVo*)[self.productArray objectAtIndex:indexPath.row]).type)
    {
        case ProductType_R:
            vo = [[ProductInfo alloc] initWithPosFileStr:@"/20140701_001556.06.003.000_6.19.zdb"];
            break;
        case ProductType_V:
            vo = [[ProductInfo alloc] initWithPosFileStr:@"/20140701_001556.06.004.000_6.19.zdb"];
            break;
        case ProductType_W:
            vo = [[ProductInfo alloc] initWithPosFileStr:@"/20140701_001556.06.005.000_6.19.zdb"];
            break;
        default:
            vo = nil;
            return;
    }
    //Test End...
    [self.delegate selectProduct:vo];
    vo = nil;
}

@end
