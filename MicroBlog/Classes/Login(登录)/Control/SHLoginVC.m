//
//  SHLoginVC.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/6.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHLoginVC.h"

typedef NS_OPTIONS(NSUInteger, Type){
    UserName = 1,
    Password
};

@interface SHLoginVC () <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView     *avatar;
@property (nonatomic, strong) SPTextFieldView *userName;
@property (nonatomic, strong) SPTextFieldView *password;
@property (nonatomic, strong) UIButton        *login;
@property (nonatomic, strong) UIButton        *forget;

@end

@implementation SHLoginVC

#pragma mark - 视图生命周期

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kColorBgMain;
    
    //添加所有子控件
    [self addAllSubViews];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
//    self.userName.textField.text = [UserManager shareInstance].userSecurity.account;
//    self.password.textField.text = [UserManager shareInstance].userSecurity.password;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark - 子控件

/**
 *  添加所有子控件
 */
- (void)addAllSubViews
{
    [self.view addSubview:self.avatar];
    [self.view addSubview:self.userName];
    [self.view addSubview:self.password];
    [self.view addSubview:self.login];
    [self.view addSubview:self.forget];
}
/**
 *  设置所有子控件约束（系统自动调用该方法）
 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //朋客标志
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(69+20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(93, 74));
    }];
    
    //账户
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatar.mas_bottom).offset(50);
        make.left.mas_equalTo(self.view.mas_left).offset(23);
        make.right.mas_equalTo(self.view.mas_right).offset(-23);
        make.height.mas_equalTo(44);
    }];
    
    //密码
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userName.mas_bottom).offset(20);
        make.left.right.height.mas_equalTo(self.userName);
    }];
    
    //登录
    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.password.mas_bottom).offset(32);
        make.left.right.height.mas_equalTo(self.password);
    }];
    
    //忘记密码
    [self.forget mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-22);
        make.top.mas_equalTo(self.login.mas_bottom).offset(24);
    }];
    
}

#pragma mark - Notifications

-(void)addNotificationObservers
{
    [super addNotificationObservers];
    
    //登录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotificationLogin:) name:kNotificationDidLogin object:nil];
    //键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDisappear:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)removeNotificationObservers
{
    [super removeNotificationObservers];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//登录成功
- (void)didReceiveNotificationLogin:(NSNotification *) notification
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//键盘出现
- (void)keyboardAppear:(NSNotification *)notification
{
    //系统键盘通知所有信息
    NSDictionary *userInfo = [notification userInfo];
    
    //从中拿到键盘准确属性
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //键盘遮挡不住忘记密码按钮 直接返回
    if(keyboardFrame.origin.y > CGRectGetMaxY(self.forget.frame)+8)
    {
        return ;
    }
    
    //设法捕获当前第一响应者 很奇怪 firstResponder
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    
    //适配 6 和 6p
    if(WINDOW_4_7_INCH || WINDOW_5_5_INCH)
    {
        CGFloat offset = keyboardFrame.origin.y - CGRectGetMaxY(self.forget.frame);
        self.view.frame = CGRectMake(0, self.view.origin.y + offset - 8, self.view.width, self.view.height);
    }
    //适配 5
    if(WINDOW_4_INCH)
    {
        if([firstResponder isKindOfClass:[UITextField class]])
        {
            if (firstResponder.tag == UserName)
            {
                CGFloat offset = keyboardFrame.origin.y - CGRectGetMaxY(self.login.frame);
                self.view.frame = CGRectMake(0, self.view.origin.y + offset - 8, self.view.width, self.view.height);
            }
            else if (firstResponder.tag == Password)
            {
                CGFloat offset = keyboardFrame.origin.y - CGRectGetMaxY(self.forget.frame);
                self.view.frame = CGRectMake(0, self.view.origin.y + offset - 8, self.view.width, self.view.height);
            }
        }
    }
    //适配 4
    if(WINDOW_3_5_INCH)
    {
        if([firstResponder isKindOfClass:[UITextField class]])
        {
            if (firstResponder.tag == UserName)
            {
                CGFloat offset = keyboardFrame.origin.y - CGRectGetMaxY(self.login.frame);
                self.view.frame = CGRectMake(0, self.view.origin.y + offset - 8, self.view.width, self.view.height);
            }
            else if (firstResponder.tag == Password)
            {
                CGFloat offset = keyboardFrame.origin.y - CGRectGetMaxY(self.login.frame);
                self.view.frame = CGRectMake(0, self.view.origin.y + offset - 8, self.view.width, self.view.height);
            }
        }
    }
    
}
- (void)keyboardChange:(NSNotification *)notification
{
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}
- (void)keyboardDisappear:(NSNotification *)notification
{
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

#pragma mark - lazyload

- (UIImageView *)avatar
{
    if(!_avatar)
    {
        _avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
        _avatar.contentMode = UIViewContentModeScaleAspectFill;
        _avatar.layer.masksToBounds = YES;
    }
    return _avatar;
}
- (SPTextFieldView *)userName
{
    if(!_userName)
    {
        _userName = [[SPTextFieldView alloc] initWithSPTextFieldImageType:SPTextFieldImageLeft];
        _userName.textField.placeholder = @"输入新浪微博账号";
        _userName.textField.secureTextEntry = NO;
        _userName.textField.keyboardType = UIKeyboardTypeDecimalPad;
        [_userName.imageBtn setImage:[UIImage imageNamed:@"login_id_icon"] forState:UIControlStateNormal];
        _userName.textField.tag = 1;
    }
    return _userName;
}
- (SPTextFieldView *)password
{
    if(!_password)
    {
        _password = [[SPTextFieldView alloc] initWithSPTextFieldImageType:SPTextFieldImageLeft];
        _password.textField.placeholder = @"请输入密码";
        _password.textField.secureTextEntry = YES;
        [_password.imageBtn setImage:[UIImage imageNamed:@"login_password_icon"] forState:UIControlStateNormal];
        _password.textField.tag = 2;
    }
    return _password;
}
- (UIButton *)login
{
    if(!_login)
    {
        _login = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _login.backgroundColor = kColorAppMain;
        [_login setTitle:@"登  录" forState:UIControlStateNormal];
        [_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_login setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _login.titleLabel.font = [UIFont systemFontOfSize:17.f];
        _login.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_login.layer setCornerRadius:2.f];
        [_login.layer setMasksToBounds:YES];
        
        [_login addTarget:self action:@selector(loginBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _login;
}
- (UIButton *)forget
{
    if(!_forget)
    {
        _forget = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forget setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forget setImage:[UIImage imageNamed:@"login_forget_icon"] forState:UIControlStateNormal];
        [_forget setTitleColor:kColorAppMain forState:UIControlStateNormal];
        _forget.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _forget.titleLabel.textAlignment = NSTextAlignmentCenter;
        _forget.titleEdgeInsets = UIEdgeInsetsMake(0, -35, 0, 0);
        _forget.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
        [_forget addTarget:self action:@selector(forgetBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [_forget sizeToFit];
    }
    return _forget;
}

#pragma mark - 登录操作

- (void)loginBtnDidClick
{
    //结束编辑收回键盘
    [self.view endEditing:YES];
    
    NSString *account = self.userName.textField.text;
    NSString *passwd  = self.password.textField.text;
    
    //发起登录请求
//    [[UserManager shareInstance] requestLoginWithAccount:account password:passwd];
}

#pragma mark - 忘记密码

- (void)forgetBtnDidClick
{
//    ForgetPwdVC *forgetPwdVC = [[ForgetPwdVC alloc] init];
//    [self.navigationController pushViewController:forgetPwdVC animated:YES];
}

#pragma mark - 监听点击事件

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //点击空白结束编辑
    [self.view endEditing:YES];
}

@end
