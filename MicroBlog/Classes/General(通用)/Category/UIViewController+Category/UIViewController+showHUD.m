//
//  UIViewController+showHUD.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/6.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "UIViewController+showHUD.h"
#import "SHAlertView.h"
#import "SHNetworkActivityView.h"
#import "SHPromptView.h"

@implementation UIViewController (showHUD)
-(void)showTextHud:(NSString*)message
{
    //    MBProgressHUD *textHUD = [MBProgressHUD showHUDAddedTo:getKeyWindow() animated:YES];
    //    [textHUD setMode:MBProgressHUDModeText];
    //    [textHUD setLabelText:message];
    //    [textHUD setMargin:10.f];
    //    [textHUD setYOffset:self.view.frame.size.height/2-49];
    //    [textHUD setRemoveFromSuperViewOnHide:YES];
    //    [textHUD setUserInteractionEnabled:NO];
    //    [textHUD hide:YES afterDelay:2];
    [self showtextHUDWith:message andDelay:2.0];
}
- (void)showTextHudNoTab:(NSString *)message{
    //    MBProgressHUD *textHUD = [MBProgressHUD showHUDAddedTo:getKeyWindow() animated:YES];
    //    [textHUD setMode:MBProgressHUDModeText];
    //    [textHUD setLabelText:message];
    //    [textHUD setMargin:10.f];
    //    [textHUD setYOffset:self.view.frame.size.height/2-65];
    //    [textHUD setRemoveFromSuperViewOnHide:YES];
    //    [textHUD setUserInteractionEnabled:NO];
    //    [textHUD hide:YES afterDelay:2];
    [self showtextHUDWith:message andDelay:2.0];
}
- (void)showTextHud:(NSString *)message delay:(int)delay{
    //    MBProgressHUD *textHUD = [MBProgressHUD showHUDAddedTo:getKeyWindow() animated:YES];
    //    [textHUD setMode:MBProgressHUDModeText];
    //    [textHUD setLabelText:message];
    //    [textHUD setMargin:10.f];
    //    [textHUD setYOffset:self.view.frame.size.height/2-49];
    //    [textHUD setRemoveFromSuperViewOnHide:YES];
    //    [textHUD setUserInteractionEnabled:NO];
    //    [textHUD hide:YES afterDelay:delay];
    [self showtextHUDWith:message andDelay:delay];
}
-(void)showIndeterminateHud:(NSString *)text delay:(int)delay{
    //    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    [HUD setMode:MBProgressHUDModeIndeterminate];
    //    [HUD setRemoveFromSuperViewOnHide:YES];
    //    [HUD hide:YES afterDelay:delay];
    //    [HUD setLabelText:text];
    //    [HUD setMargin:10.f];
    [self showHUD];
    self.view.userInteractionEnabled = NO;;
}

- (void)showHUD
{
    SHNetworkActivityView *seaNet = [[SHNetworkActivityView alloc] init];
    [self.view addSubview:seaNet];
    [self.view bringSubviewToFront:seaNet];
    
}
- (void)showtextHUDWith:(NSString *)msg andDelay:(int)delay
{
    SHPromptView *alertView = [[SHPromptView alloc] initWithFrame:CGRectMake((self.view.width - SHPromptViewWidth) / 2.0, (self.contentHeight - SHPromptViewHeight) / 2.0, SHPromptViewWidth, SHPromptViewHeight) message:msg];
    [self.view addSubview:alertView];
    alertView.removeFromSuperViewAfterHidden = NO;
    alertView.messageLabel.text = msg;
    [self.view bringSubviewToFront:alertView];
    [alertView showAndHideDelay:delay];
}
- (void)hideHud
{
    for (UIView *view in self.view.subviews)
    {
        if ([view isKindOfClass:[SHNetworkActivityView class]])
        {
            [view removeFromSuperview];
        }
        else if ([view isKindOfClass:[SHPromptView class]])
        {
            [view removeFromSuperview];
        }
    }
    self.view.userInteractionEnabled = YES;
}
//获取可显示内容的高度
- (CGFloat)contentHeight
{
    CGFloat contentHeight = SCREEN_HEIGHT;
    
    BOOL existNav = self.navigationController.navigationBar && !self.navigationController.navigationBar.translucent && !self.navigationController.navigationBarHidden;
    if(existNav)
    {
        contentHeight -= self.navigationController.navigationBar.height;
    }
    
    if(self.tabBarController && !self.tabBarController.tabBar.hidden && !self.hidesBottomBarWhenPushed)
    {
        contentHeight -= self.tabBarController.tabBar.height;
    }
    
    if(!self.navigationController.toolbar.hidden && !self.hidesBottomBarWhenPushed && !self.navigationController.toolbar.translucent)
    {
        contentHeight -= self.navigationController.toolbar.height;
    }
    
    if(!IOS_7_OR_LATER || (![UIApplication sharedApplication].statusBarHidden && existNav))
    {
        contentHeight -= [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    
    return contentHeight;
}
- (void)showAlertViewWith:(SEL)selector andMessgae:(NSString *)str
{
    //    UICustomDialog *dialog = [[UICustomDialog alloc] init];
    //    [dialog setMessage:str];
    //    [dialog setOkButton:@"确认" target:self
    //                 action:selector];
    //    [dialog setCancelButton:@"取消" target:nil action:nil];
    //    [dialog hideTitleView:YES];
    //    [dialog show];
}
- (void)showSHAlertViewWithDelegate:(id)delegate
                         andMessage:(NSString *)str
                 isWithCancelButton:(BOOL)isWithCancel
{
    NSArray *buttonTitleArr;
    if (isWithCancel) {
        buttonTitleArr = @[@"取消",@"确定"];
    }
    else{
        buttonTitleArr = @[@"确定"];
    }
    SHAlertView *alert = [[SHAlertView alloc] initWithTitle:str otherButtonTitles:buttonTitleArr];
    alert.delegate = delegate;
    if (isWithCancel)
    {
        [alert setButtonTitleColor:kColorAppMain forIndex:1];
    }
    else
    {
        [alert setButtonTitleColor:kColorAppMain forIndex:0];
    }
    [alert show];
}
- (void)showSHAlertViewWithMessage:(NSString *)messageStr
                isWithCancelButton:(BOOL)isWithCancel
                   didClickOKBlock:(DidClickOKBlock)didClickOKBlock
{
    NSArray *buttonTitleArr;
    if (isWithCancel)
    {
        buttonTitleArr = @[@"取消",@"确定"];
    }
    else
    {
        buttonTitleArr = @[@"确定"];
    }
    SHAlertView *alert = [[SHAlertView alloc] initWithTitle:messageStr otherButtonTitles:buttonTitleArr];
    alert.didClickOKBlock = didClickOKBlock;
    if (isWithCancel)
    {
        [alert setButtonTitleColor:kColorAppMain forIndex:1];
    }
    else
    {
        [alert setButtonTitleColor:kColorAppMain forIndex:0];
    }
    [alert show];
    
}
- (void)disMissAlertView
{
    for (UIView *view in self.view.subviews)
    {
        if ([view isKindOfClass:[SHAlertView class]])
        {
            [(SHAlertView *)view dismiss];
        }
    }
}
@end
