//
//  BaseSimpleCell.h
//  CherryBlossomAddressBook
//
//  Created by RenSihao on 16/4/8.
//  Copyright © 2016年 XuJiajia. All rights reserved.
//

#import "BaseTableViewCell.h"


typedef NS_OPTIONS(NSUInteger, BaseSimpleCellBGViewPosition){
    BaseSimpleCellBGPositionSingle = 0,
    BaseSimpleCellBGPositionTop,
    BaseSimpleCellBGPositionBottom,
    BaseSimpleCellBGPositionMiddle
};

typedef  void(^SelectedAction)();

//@interface FakeSectionTitleView : CustomSeperatorLineCell
//{
//    UIButton * _additionalBtn;
//}
//@property (nonatomic,readonly)UIButton * additionalBtn;
//@end

@interface BaseSimpleCell : BaseTableViewCell
@property(nonatomic, assign) NSInteger notificationCount;
@property(nonatomic, copy) SelectedAction selectedAction;
@property(nonatomic, assign) BaseSimpleCellBGViewPosition position;
@property(nonatomic, assign) BOOL isShowBadge;
+(CGFloat) cellHeight;
@end

@interface BaseSimpleInputCell : BaseSimpleCell
{
    UITextField * _inputView;
}
@property(nonatomic,readonly)UITextField * inputView;
@end

static inline UIView * clearView (BOOL enabled){
    UIView * v = [[UIView alloc]init];
    v.backgroundColor = [UIColor clearColor];
    v.userInteractionEnabled = enabled;
    return v;
}
