//
//  SHBlogDetailWebVC.m
//  MicroBlog
//
//  Created by RenSihao on 16/3/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHBlogDetailWebVC.h"

@interface SHBlogDetailWebVC ()

@end

@implementation SHBlogDetailWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
