//
//  ProductDataTableView.m
//  RadarIPad
//
//  Created by Yachen Dai on 13-9-27.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import "ProductDataTableView.h"

@implementation ProductDataTableView
@synthesize productDataArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    productDataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStyleGrouped];
    [self addSubview:productDataTableView];
}

#pragma mark - table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set categories
    static NSString *Identifier = @"ProductDataTableCell";
    UITableViewCell *cell = [productDataTableView dequeueReusableCellWithIdentifier: Identifier];
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
