//
//  SHNavigationController.m
//  MicroBlog
//
//  Created by RenSihao on 15/12/24.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "SHNavigationController.h"
#import "SHTabBar.h"
@interface SHNavigationController ()

@end

@implementation SHNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB_0x(0xFAFAFA) cornerRadius:0] forBarMetrics:UIBarMetricsDefault];
    if ([self.navigationBar respondsToSelector:@selector(setShadowImage:)]) {
        [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
    //    self.navigationBar.translucent = NO;
    
    [self.navigationBar setTintColor:[UIColor blackColor]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  拦截push然后过滤
 *
 *  @param viewController <#viewController description#>
 *  @param animated       <#animated description#>
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 导航栏都是栈管理的，如果栈里面的内容大于0，说明push了，
    if (self.viewControllers.count > 0)
    {
        
        // 把tabbar隐藏
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}


@end
