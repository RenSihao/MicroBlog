//
//  Macros.h
//  MicroBlog
//
//  Created by RenSihao on 15/11/12.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

/* FrameWorks */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/* 宏文件 */

/* Const */
#import "SDKConfigureConst.h"
#import "NetworkConst.h"
#import "NotificationConst.h"

/* Venders */
#import "Masonry.h"
#import "SVPullToRefresh.h"
#import "WZLBadgeImport.h"
#import "SVProgressHUD.h"
#import "SDCycleScrollView.h"
#import "SDPhotoBrowser.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "BHBPopView.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "MJExtension.h"

/* Weibo SDK */
#import "WeiboSDK.h"

/* HttpRequest */
#import "SHNetworkClient.h"

/* Controler */
#import "AppDelegate.h"
#import "SHViewController.h"
#import "SHTableViewController.h"
#import "GestureNavController.h"
#import "SHWebViewController.h"


/* Model */
#import "SHModel.h"
#import "SHUserModel.h"


/* Managers */
#import "AppManager.h"
#import "UserManager.h"
#import "WeiboManager.h"

/* Category */
#import "UIImage+Image.h"
#import "UIImage+Color.h"
#import "UIView+Frame.h"
#import "UIView+Util.h"
#import "UIView+Additions.h"
#import "UIImage+Tint.h"
#import "UIImage+Alpha.h"
#import "UIImage+FlatUI.h"
#import "UIBarButtonItem+Item.h"
#import "NSDictionary+ObjectForKeyNotNull.h"
#import "NSString+Category.h"
#import "UIViewController+showHUD.h"
#import "NSJSONSerialization+Category.h"
#import "NSDate+Category.h"
#import "UITabBarItem+Category.h"
#import "NSString+Utilities.h"

#import "UITableView+FDTemplateLayoutCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"






/* View */
#import "SPTextFieldView.h"




#pragma mark - 快捷方法

//点击列表后，还原列表状态为deselect状态
#define deselectRowWithTableView(tableView) double delayInSeconds = 1.0;dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));dispatch_after(popTime, dispatch_get_main_queue(), ^(void){[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];});

// self弱引用
#define weakSelf(args)   __weak typeof(args) weakSelf = args
// self强引用
#define strongSelf(args) __strong typeof(args) strongSelf = args

/*********** UIColor **************/
//UIColor 十六进制RGB_0x
#define UIColorFromRGB_0x(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//UIColor 十六进制RGBA_0x
#define UIColorFromRGBA_0x(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF000000) >> 24))/255.0 \
green:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
blue:((float)((rgbValue & 0xFF00) >>8 ))/255.0 \
alpha:((float)(rgbValue & 0xFF))/255.0]

//UIColor 十进制RGB_D
#define UIColorFromRGB_D(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

//UIColor 十进制RGBA_D
#define UIColorFromRGBA_D(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]

/************** CGColor *****************/
//CGColor 十六进制RGB_0x
#define CGColorFromRGB_0x(rgbValue) UIColorFromRGB_0x(rgbValue).CGColor

//CGColor 十六进制RGBA_0x
#define CGColorFromRGBA_0x(rgbValue) UIColorFromRGB_0x(rgbVaue).CGColor

//CGColor 十进制RGB_D
#define CGColorFromRGB_D(R, G, B) UIColorFromRGB_D(R, G, B).CGColor

//CGColor 十进制RGBA_D
#define CGColorFromRGBA_D(R, G, B, A) UIColorFromRGBA_D(R, G, B, A).CGColor


/*************** General *****************/

#define SHKeyWindow [UIApplication sharedApplication].keyWindow //App唯一主窗口

#pragma mark - Frame

#define STATUES_HEIGHT 20 //默认状态栏高度
#define NAV_BAR_HEIGHT 64 //默认NavigationBar高度
#define TAB_BAR_HEIGHT 49 //默认TabBar高度

#define SCREEN_BOUNDS       [UIScreen mainScreen].bounds
#define SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height

#define CGWidth(rect)                rect.size.width
#define CGHeight(rect)               rect.size.height
#define CGOriginX(rect)              rect.origin.x
#define CGOriginY(rect)              rect.origin.y
#define CGEndX(rect)                 rect.origin.x + rect.size.width
#define CGEndY(rect)                 rect.origin.y + rect.size.height

#define WIDTH_3_5_INCH  320.f
#define WIDTH_4_INCH    320.f
#define WIDTH_4_7_INCH  375.f
#define WIDTH_5_5_INCH  414.f
#define HEIGHT_3_5_INCH 480.f
#define HEIGHT_4_INCH   568.f
#define HEIGHT_4_7_INCH 667.f
#define HEIGHT_5_5_INCH 736.f


#pragma mark - 适配机型和系统

#define WINDOW_3_5_INCH ([[UIScreen mainScreen] bounds].size.height == HEIGHT_3_5_INCH)
#define WINDOW_4_INCH   ([[UIScreen mainScreen] bounds].size.height == HEIGHT_4_INCH)
#define WINDOW_4_7_INCH ([[UIScreen mainScreen] bounds].size.height == HEIGHT_4_7_INCH)
#define WINDOW_5_5_INCH ([[UIScreen mainScreen] bounds].size.height == HEIGHT_5_5_INCH)

#define IOS_7_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_8_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS_9_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)


#pragma mark - 动画时间

//动画时间
static NSTimeInterval const kAnimationDuration = 0.25;

#pragma mark - 字体

#define SHFontNavBarTitle [UIFont systemWithFont:34]
#define SHFontTabBarItem  [UIFont systemWithFont:20]

//主要字体名称
#define MainFontName @"Helvetica"

#define kDefaultRegularFontFamilyName @"HelveticaNeue"
#define kDefaultBoldFontFamilyName    @"HelveticaNeue-Bold"
#define kDefaultFontFamilyNameForRead @"XinGothic-Mzread W4"

//字体大小
#define MainFontSize22 (25.0 / 3.0) ///22号字体
#define MainFontSize23 (26.0 / 3.0) ///23号字体
#define MainFontSize24 (27.0 / 3.0) ///24号字体
#define MainFontSize25 (28.0 / 3.0) ///25号字体
#define MainFontSize30 (33.0 / 3.0) ///30号字体
#define MainFontSize34 (37.0 / 3.0) ///34号字体
#define MainFontSize36 (39.0 / 3.0) ///36号字体
#define MainFontSize46 (49.0 / 3.0) ///46号字体
#define MainFontSize40 (43.0 / 3.0) ///40号字体
#define MainFontSize50 (53.0 / 3.0) ///50号字体
#define MainFontSize56 (59.0 / 3.0) ///56号字体

//字体颜色
#define MainLightGrayColor [UIColor colorWithRed:153.0 / 255.0 green:153.0 / 255.0 blue:153.0 / 255.0 alpha:1.0] ///#999999
#define MainGrayColor [UIColor colorWithRed:102.0 / 255.0 green:102.0 / 255.0 blue:102.0 / 255.0 alpha:1.0] ///#666666
#define MainDeepGrayColor [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0] ///#333333





#pragma mark - 颜色

#define kColorAppMain       UIColorFromRGB_0x(0xFF8200)      //APP主色调(橘色)
#define kColorBgMain        UIColorFromRGB_0x(0xFFFFFF)      //一级框架背景色(纯白色)
#define kColorBgSub         UIColorFromRGB_0x(0xeFeFF4)      //二级框架背景色
#define kColorHairline      UIColorFromRGB_0x(0xe5e5e5)       //cell分割线颜色
#define kColorCellBgSel    [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.95f alpha:1.0f] //cell背景色

#define kSimpleCellHeight   55.f
#define kColorTextMain      UIColorFromRGB_0x(0x333333)
#define kColorTextSub       UIColorFromRGB_0x(0x666666)
#define kColorTextWhite     UIColorFromRGB_0x(0xFFFFFF)

#pragma mark - 分割线

#define kSeparatorLineColor [UIColor colorWithWhite:0.8 alpha:1.0]
#define kSeparatorLineWidth 0.5
#define kSeparatorLineHeight 0.5

#pragma mark - 
#define kColorTabBarSelItem [UIColor orangeColor]


#pragma mark - 预编译函数及命令

//发布(release)的项目不打印日志
#ifndef __OPTIMIZE__ //debug
#define NSLog(...) NSLog(__VA_ARGS__)
#else //release
#define NSLog(...) {}
#endif




#endif /* Macros_h */


