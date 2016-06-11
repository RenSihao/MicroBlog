//
//  FlipTableView.h
//  iOS_Control
//
//  Created by RenSihao on 16/3/24.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipTableView;

@protocol FlipTableViewDelegate <NSObject>

@required
/**
 *  滑动到第几个tableview 回调
 *
 *  @param index 下标
 */
- (void)didScrollChangeToIndex:(NSInteger)index;
@end


@interface FlipTableView : UIView

@property (nonatomic, weak) id<FlipTableViewDelegate> delegate;

/**
 *  init方法
 *
 *  @param frame          frame
 *  @param tableViewArray tableview容器数组
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame tableViewArray:(NSArray *)tableViewArray;

@end
