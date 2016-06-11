//
//  UITabBarItem+Category.h
//  MicroBlog
//
//  Created by RenSihao on 16/4/11.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (Category)

+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)aTitle
                           normalName:(UIImage *)aNormal
                         selectedName:(UIImage *)aSelected
                                  tag:(NSInteger)aTag;
@end
