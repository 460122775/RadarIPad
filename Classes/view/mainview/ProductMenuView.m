//
//  ProductMenuView.m
//  RadarIPad
//
//  Created by Yachen Dai on 12/12/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import "ProductMenuView.h"

@implementation ProductMenuView

static const int paddingLeft = 15;
static const int paddingTop = 15;

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
    // Init Frist Product View.
    firstProductBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstProductBtn setFrame: CGRectMake(paddingLeft, paddingTop, 300, 40)];
    [firstProductBtn setNeedsDisplayInRect:CGRectMake(0, 0, 300, 40)];
    [firstProductBtn setTitle:@"一次产品" forState:UIControlStateNormal];
    [firstProductBtn setBackgroundColor:BlueBackGroundColor];
    [firstProductBtn addTarget:self action:@selector(firstProductBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:firstProductBtn];
    
    firstProductTable = [[UITableView alloc] initWithFrame:CGRectMake(paddingLeft, paddingTop + 40, 300, self.frame.size.height - paddingTop * 2 - 40) style:UITableViewStylePlain];
    firstProductTable.delegate = self;
    firstProductTable.dataSource = self;
    firstProductTable.backgroundView = nil;
    [firstProductTable setBackgroundColor:[UIColor clearColor]];
    [firstProductTable.layer setBorderWidth:1];
    [firstProductTable.layer setBorderColor:GrayColor.CGColor];
    [self addSubview:firstProductTable];
    
    secondProductBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [secondProductBtn setFrame: CGRectMake(paddingLeft + 330, paddingTop, 400, 40)];
    [secondProductBtn setNeedsDisplayInRect:CGRectMake(0, 0, 300, 40)];
    [secondProductBtn setTitle:@"二次产品" forState:UIControlStateNormal];
    [secondProductBtn setBackgroundColor:BlueBackGroundColor];
    [secondProductBtn addTarget:self action:@selector(secondProductBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:secondProductBtn];
    
    secondProductTable = [[UITableView alloc] initWithFrame:CGRectMake(paddingLeft + 330, paddingTop + 40, 400, self.frame.size.height - paddingTop * 2 - 40) style:UITableViewStylePlain];
    secondProductTable.delegate = self;
    secondProductTable.dataSource = self;
    secondProductTable.backgroundView = nil;
    [secondProductTable setBackgroundColor:[UIColor clearColor]];
    [secondProductTable.layer setBorderWidth:1];
    [secondProductTable.layer setBorderColor:GrayColor.CGColor];
    [self addSubview:secondProductTable];
}

- (void)firstProductBtnClick
{
    
}

- (void)secondProductBtnClick
{
    
}


#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set categories
    static NSString *Identifier = @"SecondProductTableCell";
    UITableViewCell *cell = [secondProductTable dequeueReusableCellWithIdentifier: Identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = [UIView new] ;
        cell.selectedBackgroundView = [UIView new];

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
