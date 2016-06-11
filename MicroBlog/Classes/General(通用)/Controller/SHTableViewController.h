//
//  SHTableViewController.h
//  MicroBlog
//
//  Created by RenSihao on 15/12/24.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  点击列表后，还原列表状态为deselect状态
 *
 *  @param tableView
 */
#define deselectRowWithTableView(tableView) double delayInSeconds = 1.0;dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));dispatch_after(popTime, dispatch_get_main_queue(), ^(void){[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];});

/**
 *  上下拉刷新代理
 */
@protocol SHTableViewRefreshDelegate <NSObject>
@optional
/**
 *  下拉刷新事件
 */
- (void)tableViewDidTriggerHeaderRefresh;

/**
 *  上拉加载事件
 */
- (void)tableViewDidTriggerFooterRefresh;

@end


@interface SHTableViewController : SHViewController

@property (nonatomic, strong) UITableView *tableView;

/**
 *  初始方法
 *  @param style
 */
- (instancetype)initWithStyle:(UITableViewStyle) style;


#pragma mark - Refresh

@property (nonatomic) BOOL enableHeaderRefresh;//是否支持下拉刷新
@property (nonatomic) BOOL enableFooterRefresh;//是否支持上拉加载
@property (nonatomic, weak) id<SHTableViewRefreshDelegate> refreshDelegate;//监听上下拉刷新

/**
 *  完成刷新或加载
 *  @param reload 是否[tableView reloadData]
 */
- (void)tableViewDidFinishTriggerWithReload:(BOOL)reload;

@end
