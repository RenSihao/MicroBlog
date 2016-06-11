//
//  SHLeftItemViewController.m
//  MicroBlog
//
//  Created by RenSihao on 16/2/16.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHLeftItemVC.h"

@interface SHLeftItemVC ()

@end

@implementation SHLeftItemVC

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"好友关注动态";
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, self.tableView.contentSize.height );
}

#pragma mark - private method

- (void)setupNaviBarItems
{
    [super setupNaviBarItems];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(didClickMore:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - 监听点击NavBarItem

- (void)didClickMore:(UIBarButtonItem *)item
{
    
}





@end
