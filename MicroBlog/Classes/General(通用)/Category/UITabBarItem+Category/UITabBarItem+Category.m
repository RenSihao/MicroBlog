//
//  UITabBarItem+Category.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/11.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "UITabBarItem+Category.h"

@implementation UITabBarItem (Category)

+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)aTitle
                           normalName:(UIImage *)aNormal
                         selectedName:(UIImage *)aSelected
                                  tag:(NSInteger)aTag
{
    UITabBarItem *result = nil;
    
    if (IOS_7_OR_LATER)
    {
        result = [[UITabBarItem alloc] initWithTitle:aTitle image:aNormal selectedImage:aSelected];
        [result setTag:aTag];
    }
    else
    {
        result = [[UITabBarItem alloc] initWithTitle:aTitle image:aNormal tag:aTag];
    }
    
    return result;
}
@end
