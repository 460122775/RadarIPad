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
        self.backgroundColor = [UIColor clearColor];
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
    y += 230;
    radarStateContentView.layer.borderWidth = 1;
    radarStateContentView.layer.borderColor = GrayColor.CGColor;
    [backgroundScrollView addSubview:radarStateContentView];
    
    taskTableView = [[UITableView alloc] initWithFrame:CGRectMake(Padding, y, backgroundScrollView.frame.size.width - Padding * 2, self.frame.size.height - y - Padding - 60) style:UITableViewStylePlain];
    y += self.frame.size.height - y - Padding - 100 - 40 + 5;
    taskTableView.delegate = self;
    taskTableView.dataSource = self;
    taskTableView.backgroundColor = [UIColor clearColor];
    taskTableView.backgroundView = nil;
    taskTableView.layer.borderWidth = 1;
    taskTableView.layer.borderColor = GrayColor.CGColor;
    [self addSubview:taskTableView];
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
    [backgroundScrollView setContentSize:CGSizeMake(self.frame.size.width * 0.45, self.frame.size.height - 200)];
}

- (void)keyboardWasHidden
{
    [backgroundScrollView setContentSize:CGSizeMake(self.frame.size.width * 0.45, self.frame.size.height)];
}

#pragma mark - tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //set categories
    static NSString *Identifier = @"TASKCELL";
    UITableViewCell *cell = [taskTableView dequeueReusableCellWithIdentifier: Identifier];
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
