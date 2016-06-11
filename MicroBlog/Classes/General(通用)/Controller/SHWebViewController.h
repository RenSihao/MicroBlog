//
//  SHWebViewController.h
//  MicroBlog
//
//  Created by RenSihao on 16/2/24.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHViewController.h"

@interface SHWebViewController : SHViewController


/**
 *  whether the webpage scales to fit the view and the user can change the scale.
 */
@property (nonatomic, assign) BOOL needScalesPageToFit;

/**
 *  初始化页面，传入url和导航栏title
 *
 *  @param title 导航栏title
 *  @param url   访问url
 *
 *  @return 显示传入url的h5页面
 */
-(instancetype)initWithTitle:(NSString *) title url:(NSString *) url;

/**
 *  初始化页面，传入内容和导航栏title
 *
 *  @param title   导航栏title
 *  @param content 页面内容（带有html标签的页面内容，或者单纯的无标签内容）
 *
 *  @return 根据传入的内容显示页面
 */
-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content;

@end
