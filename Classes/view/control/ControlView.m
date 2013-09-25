//
//  ControlPageView.m
//  YWRadar
//
//  Created by Yachen Dai on 13-8-11.
//  Copyright (c) 2013年 yuanwang. All rights reserved.
//

#import "ControlView.h"

@implementation ControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown)
                                                     name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden)
                                                     name:UIKeyboardWillHideNotification object:nil];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.45, self.frame.size.height)];
    backgroundScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:backgroundScrollView];
    UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardWasHidden)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [backgroundScrollView addGestureRecognizer:singleRecognizer];
    
    //radar state.
    int y = Padding;
    radarStateLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding, y, backgroundScrollView.frame.size.width - 2 * Padding, 30)];
    y += 35;
    radarStateLabel.backgroundColor = TitleColor;
    radarStateLabel.font = [UIFont fontWithName:@"Heiti SC" size:16];
    [radarStateLabel setTextColor:[UIColor whiteColor]];
    [radarStateLabel setText:@"  雷达状态"];
    [backgroundScrollView addSubview:radarStateLabel];
    
    directionLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding + 5, y, 50, 20)];
    directionLabel.backgroundColor = [UIColor clearColor];
    directionLabel.font = [UIFont fontWithName:@"Heiti SC" size:16];
    [directionLabel setTextColor:[UIColor darkGrayColor]];
    [directionLabel setText:@"方位:"];
    [backgroundScrollView addSubview:directionLabel];
    
    directionValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding + 60, y, 100, 20)];
    directionValueLabel.backgroundColor = [UIColor clearColor];
    directionValueLabel.font = [UIFont fontWithName:@"Heiti SC" size:16];
    [directionValueLabel setTextColor:[UIColor greenColor]];
    [directionValueLabel setText:@"00.00"];
    [backgroundScrollView addSubview:directionValueLabel];
    
    elevationLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding + 165, y, 50, 20)];
    elevationLabel.backgroundColor = [UIColor clearColor];
    elevationLabel.font = [UIFont fontWithName:@"Heiti SC" size:16];
    [elevationLabel setTextColor:[UIColor darkGrayColor]];
    [elevationLabel setText:@"俯仰:"];
    [backgroundScrollView addSubview:elevationLabel];
    
    elevationValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding + 220, y, 100, 20)];
    elevationValueLabel.backgroundColor = [UIColor clearColor];
    elevationValueLabel.font = [UIFont fontWithName:@"Heiti SC" size:16];
    [elevationValueLabel setTextColor:[UIColor greenColor]];
    [elevationValueLabel setText:@"00.00"];
    [backgroundScrollView addSubview:elevationValueLabel];
    
    rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding + 325, y, 50, 20)];
    rateLabel.backgroundColor = [UIColor clearColor];
    rateLabel.font = [UIFont fontWithName:@"Heiti SC" size:16];
    [rateLabel setTextColor:[UIColor darkGrayColor]];
    [rateLabel setText:@"速率:"];
    [backgroundScrollView addSubview:rateLabel];
    
    rateValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding + 380, y, 100, 20)];
    y += 25;
    rateValueLabel.backgroundColor = [UIColor clearColor];
    rateValueLabel.font = [UIFont fontWithName:@"Heiti SC" size:16];
    [rateValueLabel setTextColor:[UIColor greenColor]];
    [rateValueLabel setText:@"00.00"];
    [backgroundScrollView addSubview:rateValueLabel];
    
    radarStateSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects: @"天线", @"收发", @"信处", @"终端", nil]];
    [radarStateSegment setFrame:CGRectMake(Padding, y, 300, 30)];
    y += 35;
    radarStateSegment.selectedSegmentIndex = 0;
    [backgroundScrollView addSubview:radarStateSegment];
    
    radarStateContentView = [[UIView alloc] initWithFrame:CGRectMake(Padding, y, backgroundScrollView.frame.size.width - Padding * 2, 160)];
    y += 170;
    radarStateContentView.layer.borderWidth = 1;
    radarStateContentView.layer.borderColor = GrayColor.CGColor;
    [backgroundScrollView addSubview:radarStateContentView];
    
    //log & debug.
    logTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding, y, backgroundScrollView.frame.size.width - 2 * Padding, 30)];
    y += 35;
    logTitleLabel.backgroundColor = TitleColor;
    logTitleLabel.font = [UIFont fontWithName:@"Heiti SC" size:16];
    [logTitleLabel setTextColor:[UIColor whiteColor]];
    [logTitleLabel setText:@"  日志与调试"];
    [backgroundScrollView addSubview:logTitleLabel];
    
    contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(Padding, y, backgroundScrollView.frame.size.width - 2 * Padding, 300)];
    y += 305;
    [contentTextView setEditable:NO];
    contentTextView.layer.borderWidth = 1;
    contentTextView.layer.borderColor = GrayColor.CGColor;
    contentTextView.backgroundColor = [UIColor whiteColor];
    [directionLabel setTextColor:[UIColor darkGrayColor]];
    contentTextView.font = [UIFont fontWithName:@"Heiti SC" size:14];
    contentTextView.text = @"这里写的是日志与调试的信息。";
    [backgroundScrollView addSubview:contentTextView];
    
    commandLabel = [[UILabel alloc] initWithFrame:CGRectMake(Padding * 2, y, 100, 30)];
    commandLabel.backgroundColor = [UIColor clearColor];
    commandLabel.font = [UIFont fontWithName:@"Heiti SC" size:16];
    [commandLabel setTextColor:[UIColor darkGrayColor]];
    [commandLabel setText:@"管理员命令:"];
    [backgroundScrollView addSubview:commandLabel];
    
    commandInputTxfld = [[UITextField alloc] initWithFrame:CGRectMake(Padding + 105, y, backgroundScrollView.frame.size.width - 2 * Padding - 105, 30)];
    y += 40;
    commandInputTxfld.layer.borderWidth = 1;
    commandInputTxfld.layer.borderColor = GrayColor.CGColor;
    commandInputTxfld.backgroundColor = [UIColor whiteColor];
    commandInputTxfld.font = [UIFont fontWithName:@"Heiti SC" size:14];
    commandInputTxfld.placeholder = @"请输入命令.";
    commandInputTxfld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [backgroundScrollView addSubview:commandInputTxfld];
    
    //user control.
    y = Padding;
    controlTitle = [[UILabel alloc] initWithFrame:
                    CGRectMake(Padding * 3 + backgroundScrollView.frame.size.width, y, self.frame.size.width - backgroundScrollView.frame.size.width - 4 * Padding, 30)];
    y += 35;
    controlTitle.backgroundColor = TitleColor;
    controlTitle.font = [UIFont fontWithName:@"Heiti SC" size:16];
    [controlTitle setTextColor:[UIColor whiteColor]];
    controlTitle.text = @"  用户管理";
    [self addSubview:controlTitle];
    
    userTableView = [[UITableView alloc] initWithFrame:CGRectMake(controlTitle.frame.origin.x, y, controlTitle.frame.size.width, self.frame.size.height - y - Padding - 100 - 40) style:UITableViewStyleGrouped];
    y += self.frame.size.height - y - Padding - 100 - 40 + 5;
    userTableView.delegate = self;
    userTableView.dataSource = self;
    userTableView.backgroundView = nil;
    [self addSubview:userTableView];
    
    addUserBtn = [[UIButton alloc] initWithFrame:CGRectMake(controlTitle.frame.origin.x, y, 80, 40)];
    [addUserBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addUserBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self addSubview:addUserBtn];
    
    pageContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(addUserBtn.frame.origin.x + 80, y, 250, 40)];
    [pageContentLabel setText:@"当前第 1/1 页"];
    [pageContentLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:pageContentLabel];
    
    lastPageBtn = [[UIButton alloc] initWithFrame:CGRectMake(pageContentLabel.frame.origin.x + 250, y, 80, 40)];
    [lastPageBtn setTitle:@"上一页" forState:UIControlStateNormal];
    [lastPageBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self addSubview:lastPageBtn];
    
    nextPageBtn = [[UIButton alloc] initWithFrame:CGRectMake(lastPageBtn.frame.origin.x + 80, y, 80, 40)];
    [nextPageBtn setTitle:@"下一页" forState:UIControlStateNormal];
    [nextPageBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self addSubview:nextPageBtn];
}

#pragma mark - text field delegate
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

- (void)keyboardWasShown
{
    [backgroundScrollView setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height - 200)];
}

- (void)keyboardWasHidden
{
    [backgroundScrollView setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
    [commandInputTxfld resignFirstResponder];
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set categories
    static NSString *Identifier = @"HistoryCell";
    UITableViewCell *cell = [userTableView dequeueReusableCellWithIdentifier: Identifier];
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
