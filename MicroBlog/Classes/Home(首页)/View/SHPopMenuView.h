//
//  SHPopMenuView.h
//  MicroBlog
//
//  Created by RenSihao on 16/1/4.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,SHPopMenuArrowPositionType){
    SHPopMenuArrowPositionCenter,
    SHPopMenuArrowPositionLeft,
    SHPopMenuArrowPositionRight
};



@interface SHPopMenuView : UIView


@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;  //灰度
@property (nonatomic, assign) SHPopMenuArrowPositionType arrowPosition;  //图片拉伸方向（有三张不同的图片）


/**
 *  类方法
 *
 *  @param contentView <#contentView description#>
 *
 *  @return <#return value description#>
 */
+ (instancetype)popMenuViewWithContentView:(UIView *)contentView;

/**
 *  对象方法
 *
 *  @param contentView <#contentView description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithContentView:(UIView *)contentView;

/**
 *  显示弹出菜单
 *
 *  @param rect <#rect description#>
 */
- (void)showInRect:(CGRect)rect;

/**
 *  隐藏弹出菜单
 */
+ (void)hide;

/**
 *  设置菜单的背景图片
 */
- (void)setBackgroundImage:(UIImage *)backgroundImage;







@end
