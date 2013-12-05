//
//  LoginView.m
//  RadarIPad
//
//  Created by Yachen Dai on 13-7-17.
//  Copyright (c) 2013年 Yachen Dai. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(keyboardWasShown)
                                                     name: UIKeyboardWillShowNotification
                                                   object: nil];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(keyboardWasHidden)
                                                     name: UIKeyboardWillHideNotification
                                                   object: nil];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [bgView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:bgView];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollView.backgroundColor = [UIColor clearColor];
    [scrollView setContentSize:CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height)];
    [self addSubview:scrollView];
    
    logo = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 100) / 2, 150, 100, 100)];
    [logo setImage:[UIImage imageNamed:@"touxiang"]];
    [scrollView addSubview:logo];
    
    usernameTextField = [[UITextField alloc]initWithFrame:CGRectMake((self.frame.size.width - 250) / 2, 285, 250, 40)];
    usernameTextField.delegate = self;
    usernameTextField.placeholder = @"请输入用户名";
    usernameTextField.background = [UIImage imageNamed:@"textfield_top"];
    usernameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 1)];
    usernameTextField.leftViewMode = UITextFieldViewModeAlways;
    usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [usernameTextField setFont:[UIFont fontWithName:@"Heiti SC" size:16]];
    [usernameTextField setReturnKeyType:UIReturnKeyNext];
    [scrollView addSubview:usernameTextField];
    
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake((self.frame.size.width - 250) / 2, 325, 250, 40)];
    passwordTextField.delegate=self;
    passwordTextField.placeholder=@"请输入密码";
    passwordTextField.background = [UIImage imageNamed:@"textfield_buttom"];
    passwordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 1)];
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordTextField.secureTextEntry = YES;
    [passwordTextField setFont:[UIFont fontWithName:@"Heiti SC" size:16]];
    [passwordTextField setReturnKeyType:UIReturnKeyDone];
    [scrollView addSubview:passwordTextField];
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setFrame: CGRectMake(self.frame.size.width / 2 - 125, 405, 120, 42)];
    [loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_normal"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_highlight"] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:loginBtn];
    
    noLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [noLoginBtn setFrame: CGRectMake(self.frame.size.width / 2 + 5, 405, 120, 42)];
    [noLoginBtn setTitle:@"游客登录" forState:UIControlStateNormal];
    [noLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_normal"] forState:UIControlStateNormal];
    [noLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_highlight"] forState:UIControlStateHighlighted];
    [noLoginBtn addTarget:self action:@selector(noLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:noLoginBtn];
    
    scrollView.alwaysBounceVertical = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardWasHidden)];
    tap.numberOfTapsRequired = 1;
    tap.enabled = YES;
    tap.cancelsTouchesInView = NO;
    [scrollView addGestureRecognizer:tap];
    
    //set normal value:
    usernameTextField.text = @"admin";
    passwordTextField.text = @"admin";
}

-(void)loginBtnClick
{
    if(usernameTextField.text && passwordTextField.text)
    {
        [self.delegate loginBtnClick:usernameTextField.text andPassword:passwordTextField.text];
    }
}

-(void)noLoginBtnClick
{
    [self.delegate noLoginBtnClick];
}

#pragma mark - keyboard & textField

- (void)keyboardWasShown
{
    [scrollView setContentSize:CGSizeMake(scrollView.contentSize.width, self.frame.size.height + 100)];
    if ([usernameTextField isFirstResponder] || [passwordTextField isFirstResponder])
    {
        [scrollView setContentOffset:CGPointMake(0, 100) animated:YES];
    }
}

- (void)keyboardWasHidden
{
    [scrollView setContentSize:CGSizeMake(scrollView.contentSize.width, self.frame.size.height)];
    if ([usernameTextField isFirstResponder] || [passwordTextField isFirstResponder])
    {
        [usernameTextField resignFirstResponder];
        [passwordTextField resignFirstResponder];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    if ([usernameTextField isFirstResponder]){
        [passwordTextField becomeFirstResponder];
        [self keyboardWasShown];
    }else if ([passwordTextField isFirstResponder]){
        [self keyboardWasHidden];
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([usernameTextField isFirstResponder])
        [usernameTextField setBackground:[UIImage imageNamed:@"textfield_top"]];
    else
        [passwordTextField setBackground:[UIImage imageNamed:@"textfield_buttom"]];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if([usernameTextField isFirstResponder])
        [usernameTextField setBackground:[UIImage imageNamed:@"textfield_top"]];
    else
        [passwordTextField setBackground:[UIImage imageNamed:@"textfield_buttom"]];
    return YES;
}

@end
