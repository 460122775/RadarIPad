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
    // init left bar.
    productTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding, Padding + 65, 250, 40)];
    [productTitleLabel setText:@"产品选择"];
    [productTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [productTitleLabel setTextColor:[UIColor darkGrayColor]];
    [productTitleLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:productTitleLabel];
    
    productTableView = [[UITableView alloc] initWithFrame:CGRectMake(Padding, Padding + 105, 250, self.frame.size.height - 180)
                                                    style:UITableViewStylePlain];
    productTableView.delegate = self;
    productTableView.dataSource = self;
    productTableView.backgroundView = nil;
    [productTableView setBackgroundColor:[UIColor clearColor]];
    [productTableView.layer setBorderWidth:1];
    [productTableView.layer setBorderColor:GrayColor.CGColor];
    [self addSubview:productTableView];

    productConfigTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding + 250, Padding + 65, 300, 40)];
    [productConfigTitleLabel setText:@"参数配置"];
    [productConfigTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [productConfigTitleLabel setTextColor:[UIColor darkGrayColor]];
    [productConfigTitleLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:productConfigTitleLabel];
    
    productConfigView = [[UIView alloc] initWithFrame:CGRectMake(Padding + 260, Padding + 105, 300, self.frame.size.height - 180)];
    productConfigView.layer.borderColor = GrayColor.CGColor;
    productConfigView.layer.borderWidth = 1;
    [self addSubview:productConfigView];
    
    parameterAttentionLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding + 270, Padding + 115, 400, 40)];
    [parameterAttentionLabel setBackgroundColor:[UIColor clearColor]];
    [parameterAttentionLabel setText:@"该产品没有需要配置的参数。"];
    [parameterAttentionLabel setTextColor:[UIColor darkGrayColor]];
    [self addSubview:parameterAttentionLabel];
    
    // init right bar.
    appliedProductTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding + 550, Padding + 65, 480, 40)];
    [appliedProductTitleLabel setText:@"已申请产品"];
    [appliedProductTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [appliedProductTitleLabel setTextColor:[UIColor darkGrayColor]];
    [appliedProductTitleLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:appliedProductTitleLabel];
    
    productTableView = [[UITableView alloc] initWithFrame:CGRectMake(Padding + 570, Padding + 105, 430, self.frame.size.height - 180) style:UITableViewStylePlain];
    productTableView.delegate = self;
    productTableView.dataSource = self;
    productTableView.backgroundView = nil;
    [productTableView setBackgroundColor:[UIColor clearColor]];
    [productTableView.layer setBorderWidth:1];
    [productTableView.layer setBorderColor:GrayColor.CGColor];
    [self addSubview:productTableView];
    
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 14;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set categories
    static NSString *Identifier = @"ProductTableViewCell";
    UITableViewCell *cell = [productTableView dequeueReusableCellWithIdentifier: Identifier];
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
