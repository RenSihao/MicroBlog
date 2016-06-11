//
//  GestureNavController.m
//  MicroBlog
//
//  Created by RenSihao on 15/12/24.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "GestureNavController.h"

@interface GestureNavController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation GestureNavController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    // Enable the gesture again once the new controller is shown
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        
        if(self.viewControllers.count>1)
            self.interactivePopGestureRecognizer.enabled = YES;
        else
            self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        if(self.viewControllers.count>1)
            self.interactivePopGestureRecognizer.delegate = self;
        else
            self.interactivePopGestureRecognizer.delegate = nil;
        
    }
    
}


#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //return ![otherGestureRecognizer isKindOfClass:UIPanGestureRecognizer.class];
    return NO;
}

@end
