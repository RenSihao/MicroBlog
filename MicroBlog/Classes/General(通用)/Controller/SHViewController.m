//
//  SHViewController.m
//  MicroBlog
//
//  Created by RenSihao on 15/12/24.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "SHViewController.h"
#import "SHNavTitleLab.h"

@interface SHViewController ()

@property (nonatomic, strong) SHNavTitleLab *titleLab;
@end

@implementation SHViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:kColorBgSub];
    
    //设置导航栏
    [self setupNaviBarItems];
    
    //添加Notification
    [self addNotificationObservers];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"$$$$ begin auto Log page %@",[self class]);
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"$$$$ end auto Log page %@",[self class]);
}

-(void)dealloc{
    NSLog(@"dealloc_at %@",[self class]);
    [self removeNotificationObservers];
    
//    [self cancelRequest];
}

#pragma mark - setter/getter

-(void)setTitle:(NSString *)title{
    if (self.titleLab == nil) {
        self.titleLab = [[SHNavTitleLab alloc] initWithTitle:title];
        self.navigationItem.titleView = self.titleLab;
    }
    [self.titleLab setText:title];
}

#pragma mark - Request

//-(void)setRequest:(SPRequest *)request{
//    if (_request!=request) {
//        _request = request;
//    }
//}
//
//-(void)cancelRequest{
//    if (self.request && self.request.isRunning) {
//        [self.request cancel];
//        self.request = nil;
//        if ([SVProgressHUD isVisible]) {
//            [SVProgressHUD dismiss];
//        }
//    }else{
//        self.request = nil;
//    }
//}

#pragma mark - 导航

- (void)setupNaviBarItems
{
    if ([self.navigationController.viewControllers count] > 1)
    {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(didClickBack:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - Notifications

//添加通知
-(void) addNotificationObservers{
    
}

//移除通知
-(void) removeNotificationObservers{
    
}

#pragma mark - Click

-(void) didClickBack:(id) sender{
    if ([self.navigationController.viewControllers count] > 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
