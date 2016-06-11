//
//  BaseTableViewCell.h
//  CherryBlossomAddressBook
//
//  Created by RenSihao on 16/4/8.
//  Copyright © 2016年 XuJiajia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIImage+Tint.h"

#define imageAccessoryArrow [UIImage imageNamed:@"Arrow_Right"]

typedef NS_ENUM(NSUInteger, TableViewCellCustomSeperatLineStyle){
    TableViewCellContinousLine = 0,
    TableViewCellDashedLine = 1,
};
/**
 *  定义分割线BackgroudView
 */
@interface CustomSeperatorBgView : UIView
@property(nonatomic, assign)BOOL drawHeadLine;
@property(nonatomic, assign)BOOL drawSeperatorLine;
@property(nonatomic, assign)CGFloat separatorLineInset;
@property(nonatomic, assign)CGFloat separatorLineWidth;
@property(nonatomic, assign)CGFloat separatorLineTailInset;
@property(nonatomic, strong)UIColor *seperatorColor;
@property(nonatomic, assign)TableViewCellCustomSeperatLineStyle seperatorLineStyle;
@end

/**
 *  BaseTableViewCell(Cell基类)
 */
@interface BaseTableViewCell : UITableViewCell
@property(nonatomic, assign)BOOL drawHeadLine;//default NO
@property(nonatomic, assign)BOOL drawSeperatorLine;//default YES
@property(nonatomic, assign)CGFloat separatorLineInset;//default 0
@property(nonatomic, assign)CGFloat separatorLineWidth;//default 1
@property(nonatomic, assign)CGFloat separatorLineTailInset;//default 0
@property(nonatomic, strong)UIColor *selectedBgColor;
@property(nonatomic, readonly)CustomSeperatorBgView *bgView;
- (void)drawOther:(CGRect)rect context:(CGContextRef)context;
- (void)addAllSubViews;
@end

