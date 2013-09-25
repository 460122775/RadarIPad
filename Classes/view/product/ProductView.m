//
//  ProductView.m
//  RadarIPad
//
//  Created by Yachen Dai on 13-9-25.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import "ProductView.h"

@implementation ProductView

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
    int yPosition = Padding;
    // init left bar.
    productChooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(Padding, yPosition, 200, 40)];
    [productChooseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [productChooseBtn setTitle:@"产品选择" forState:UIControlStateNormal];
    [productChooseBtn setBackgroundColor:BlueBackGroundColor];
    [self addSubview:productChooseBtn];
    
    productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding + 210, yPosition, 180, 40)];
    yPosition += 45;
    [productNameLabel setText:@"<<请选择"];
    [productNameLabel setTextColor:[UIColor darkGrayColor]];
    [self addSubview:productNameLabel];
    
    parameterView = [[UIView alloc] initWithFrame:CGRectMake(Padding, yPosition, 400, self.frame.size.height - 100 - yPosition)];
    parameterView.layer.borderColor = GrayColor.CGColor;
    parameterView.layer.borderWidth = 2;
    [self addSubview:parameterView];
    
    parameterAttentionLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding * 2, yPosition, 400, 40)];
    [parameterAttentionLabel setBackgroundColor:[UIColor clearColor]];
    [parameterAttentionLabel setText:@"该产品没有需要配置的参数。"];
    [parameterAttentionLabel setTextColor:[UIColor darkGrayColor]];
    [self addSubview:parameterAttentionLabel];
    
    // init right bar.
    productTableView = [[UITableView alloc] initWithFrame:CGRectMake(Padding + 400 + 50, Padding, self.frame.size.width - 400 - 50 - Padding * 2, self.frame.size.height - 100 - Padding) style:UITableViewStyleGrouped];
    productTableView.delegate = self;
    productTableView.dataSource = self;
    productTableView.backgroundView = nil;
    [productTableView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:productTableView];
    
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set categories
    static NSString *Identifier = @"HistoryCell";
    UITableViewCell *cell = [productTableView dequeueReusableCellWithIdentifier: Identifier];
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
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
