//
//  UIBarButtonItem+Item.m
//  MicroBlog
//
//  Created by RenSihao on 15/11/11.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+ (instancetype)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvent
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:controlEvent];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
