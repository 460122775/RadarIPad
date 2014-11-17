//
//  MessageListTableView.m
//  RadarIPad
//
//  Created by Yachen Dai on 11/17/14.
//  Copyright (c) 2014 Yachen Dai. All rights reserved.
//

#import "MessageListTableView.h"

@implementation MessageListTableView

@synthesize messageListArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.messageListArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.messageListArray != nil) return self.messageListArray.count;
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 41;
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
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    }
//    if(indexPath.row == selectIndex)
//    {
//        [cell setBackgroundColor:BackGroundBlueColor];
//        [cell.textLabel setTextColor:[UIColor whiteColor]];
//    }else if(indexPath.row % 2 == 1){
//        [cell setBackgroundColor:[UIColor whiteColor]];
//        [cell.textLabel setTextColor:ProductTextColor];
//    }else{
//        [cell setBackgroundColor:ForeGroundBlueColor];
//        [cell.textLabel setTextColor:ProductTextColor];
//    }
//    if(indexPath.row > self.friendListArray.count - 1) return cell;
//    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [self.friendListArray objectAtIndex:indexPath.row]]];
    return cell;
}

static int selectIndex = 0;
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
    
    //Test End...
}

@end
