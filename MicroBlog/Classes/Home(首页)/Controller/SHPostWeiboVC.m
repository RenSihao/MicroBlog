//
//  SHPostWeiboVC.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/14.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHPostWeiboVC.h"
#import "SHNavTitleLab.h"

@interface SHPostWeiboVC () <UITextViewDelegate>

@property (nonatomic, strong) UINavigationBar *navBar;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeholderLab;
@property (nonatomic, strong) UIButton *postBtn;
@end

@implementation SHPostWeiboVC

#pragma mark - init

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.navBar];
    [self.tableView addSubview:self.textView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textView becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.textView resignFirstResponder];
}

#pragma mark -

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0)
    {
        self.placeholderLab.hidden = YES;
        self.postBtn.enabled = YES;
        [self.postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        self.placeholderLab.hidden = NO;
        self.postBtn.enabled = NO;
        [self.postBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    }
}

#pragma mark - lazy load

- (UINavigationBar *)navBar
{
    if (!_navBar)
    {
        _navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        
        //背景色
        [_navBar setBackgroundImage:[UIImage imageWithColor:[UIColor orangeColor] cornerRadius:0] forBarMetrics:UIBarMetricsDefault];
        //NavBar背景色
//        _navBar.barTintColor = [UIColor orangeColor];
        //NavBar字体色
        _navBar.tintColor = [UIColor whiteColor];
        
        UINavigationItem *item = [[UINavigationItem alloc] init];
        item.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(didClickBack:)];
        SHNavTitleLab *titleLab = [[SHNavTitleLab alloc] initWithTitle:@"发微博"];
        titleLab.textColor = kColorTextWhite;
        item.titleView = titleLab;
        item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.postBtn];
        self.postBtn.enabled = NO;
        item.rightBarButtonItem.enabled = YES;
        [_navBar pushNavigationItem:item animated:YES];
    }
    return _navBar;
}
- (UITextView *)textView
{
    if (!_textView)
    {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, self.tableView.width, self.tableView.height)];
        _textView.delegate = self;
        _textView.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:16];
        _textView.textColor = [UIColor blackColor];
        [_textView addSubview:self.placeholderLab];
    }
    return _textView;
}
- (UILabel *)placeholderLab
{
    if (!_placeholderLab)
    {
        _placeholderLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.tableView.width*0.5, 16)];
        _placeholderLab.text = @"分享新鲜事...";
        _placeholderLab.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:16];
        _placeholderLab.textColor = [UIColor grayColor];
    }
    return _placeholderLab;
}
- (UIButton *)postBtn
{
    if (!_postBtn)
    {
        _postBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
        _postBtn.enabled = NO;
        [_postBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_postBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_postBtn addTarget:self action:@selector(didClickPost:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postBtn;
}

#pragma mark - 点击事件

- (void)didClickPost:(UIButton *)sender
{
    weakSelf(self);
    [WBHttpRequest requestWithURL:Weibo_Post_URL
                       httpMethod:Weibo_HttpMethod_POST
                           params:@{@"access_token":[UserManager shareInstance].userSecurity.accessToken,
                                    @"status":[weakSelf.textView.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]}
                            queue:[NSOperationQueue mainQueue]
            withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
                if (error)
                {
                    [weakSelf showTextHud:@"网络似乎出了点问题，请稍后再试"];
                }
                else
                {
                    [weakSelf showTextHud:@"发布成功"];
                    weakSelf(self);
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                       
                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
                    });
                }
    }];
}
- (void)didClickBack:(id)sender
{
    [self showTextHud:@"取消发布"];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
