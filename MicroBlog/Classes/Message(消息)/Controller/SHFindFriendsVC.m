//
//  SHDiscoverFriendsVC.m
//  MicroBlog
//
//  Created by RenSihao on 16/3/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHFindFriendsVC.h"

@interface SHFindFriendsVC ()

@end

@implementation SHFindFriendsVC

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"发现群";
}

#pragma mark - private method

- (void)setupNaviBarItems
{
    [super setupNaviBarItems];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新建群" style:UIBarButtonItemStylePlain target:self action:@selector(didClickBack:)];
}


@end
