//
//  FriendListTableView.m
//  RadarIPad
//
//  Created by Yachen Dai on 11/17/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "FriendListTableView.h"

@implementation FriendListTableView

@synthesize friendListArray, friendListDelegate;

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
    self.delegate = self;
    self.dataSource = self;
}

- (void)didMoveToSuperview
{
    self.friendListArray = [[NSMutableArray alloc] initWithObjects:@"戴亚晨", @"超级管理员", @"普通管理员", @"吴静海", @"郑小彤", @"王启正", @"陈宏", @"贾德彪", @"徐华", @"李哲", @"赵浩亮", @"宋希", @"Dr. Wang", @"Mike Zhang", nil];
    [self reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.friendListArray != nil) return self.friendListArray.count;
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
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    [sectionView setBackgroundColor:[UIColor whiteColor]];
    UILabel * label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, self.bounds.size.width, 40);
    label.backgroundColor = BackGroundBlueColor;
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18];
    label.text = @"在线用户列表";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [sectionView addSubview:label];
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"currentUserListCell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        contentLabel.tag = 1;
        [contentLabel setFont: [UIFont fontWithName:@"Helvetica" size:17]];
        [contentLabel setTextAlignment:NSTextAlignmentCenter];
        [cell addSubview:contentLabel];
    }
    ((UILabel*)[cell viewWithTag:1]).textColor = ProductTextColor;
    if (indexPath.row % 2 == 1)
    {
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        cell.backgroundColor = ForeGroundBlueColor;
    }
    if(indexPath.row > self.friendListArray.count - 1) return cell;
    [(UILabel*)[cell viewWithTag:1] setText:(NSString*)[self.friendListArray objectAtIndex:indexPath.row]];
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
    [_tableView cellForRowAtIndexPath:indexPath].backgroundColor = BackGroundBlueColorA;
    ((UILabel*)[[_tableView cellForRowAtIndexPath:indexPath] viewWithTag:1]).textColor = [UIColor whiteColor];
    
    //Test Code...
    [self.friendListDelegate selectedCellControl:((UILabel*)[[_tableView cellForRowAtIndexPath:indexPath] viewWithTag:1]).text];
    //Test End...
}

@end
