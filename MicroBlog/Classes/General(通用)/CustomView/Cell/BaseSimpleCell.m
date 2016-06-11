//
//  BaseSimpleCell.m
//  CherryBlossomAddressBook
//
//  Created by RenSihao on 16/4/8.
//  Copyright © 2016年 XuJiajia. All rights reserved.
//

#import "BaseSimpleCell.h"
#import "NotificationIndicator.h"
#import "BadgeView.h"

#define kSeparatorLineInset 10.0f

@interface BaseSimpleCell ()
{
    NotificationIndicator * _indicator;
    BadgeView *_badgeView;
}
@end

@implementation BaseSimpleCell

+(CGFloat) cellHeight{
    return kSimpleCellHeight;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.separatorLineInset = kSeparatorLineInset;
        self.separatorLineTailInset = kSeparatorLineInset;
        self.backgroundView.backgroundColor = kColorBgMain;
        
        self.textLabel.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:17.0];
        self.textLabel.textColor = kColorTextMain;
        //    self.imageView.frame;
        self.detailTextLabel.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:14.0];
        self.detailTextLabel.textColor = kColorTextSub;
        self.detailTextLabel.textAlignment = NSTextAlignmentRight;
        UIImageView *  accessoryView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 8, 13)];
        accessoryView.image = imageAccessoryArrow;
        accessoryView.backgroundColor = [UIColor clearColor];
        self.accessoryView = accessoryView;
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        self.accessoryView.backgroundColor = [UIColor clearColor];
        _indicator = [[NotificationIndicator alloc]initWithFrame:CGRectMake(0, 0, 0, 18)];
        [self.contentView addSubview:_indicator];
        _indicator.hidden = YES;
        
        //新订单  显示圆点
        _badgeView = [[BadgeView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
        _badgeView.layer.cornerRadius = 7.5f;
        _badgeView.layer.masksToBounds = YES;
        _badgeView.value = @"N";
        _badgeView.backgroundColor = UIColorFromRGB_D(250,60,0);
        _badgeView.textColor = UIColorFromRGB_D(250,200,140);
        _badgeView.font = [UIFont systemFontOfSize:11.5f];
        [self.contentView addSubview:_badgeView];
        _badgeView.hidden = YES;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    if (!self.imageView.image) {
        [self.textLabel sizeToFit];
        self.textLabel.center = CGPointMake(21 + self.textLabel.frame.size.width/2.0 , height/2.0);
    }
    
    self.accessoryView.center = CGPointMake(width-21.0-CGRectGetWidth(self.accessoryView.bounds)/2.0, height/2.0);
    
    [self.detailTextLabel sizeToFit];
    
    self.detailTextLabel.center = CGPointMake((self.accessoryView.hidden ? width - 21.0 : CGRectGetMinX(self.accessoryView.frame) - 8.0) - self.detailTextLabel.frame.size.width/2.0, height/2.0);
    //    CGFloat d_x_h = CGRectGetMinX(self.detailTextLabel.frame);
    //    CGFloat t_x_t = CGRectGetMaxX(self.textLabel.frame);
    //    if (d_x_h < t_x_t) {
    //        [self.detailTextLabel resetOriginX:t_x_t + 12 width:CGRectGetWidth(self.detailTextLabel.frame) - (t_x_t - d_x_h) - 12];
    //    }
    if (!_indicator.hidden) {
        _indicator.center = CGPointMake(CGRectGetMinX(self.accessoryView.frame) - 8.0 - _indicator.frame.size.width/2.0, height/2.0);
    }
    
    if (!_badgeView.hidden) {
        _badgeView.center = CGPointMake(CGRectGetMinX(self.accessoryView.frame) - 11.0 - _badgeView.frame.size.width / 2.0 ,height/2.0);
    }
}

- (void)setIsShowBadge:(BOOL)isShowBadge
{   _isShowBadge = isShowBadge;
    _badgeView.hidden = !isShowBadge;
    [self setNeedsLayout];
}

- (void)setNotificationCount:(NSInteger)notificationCount{
    _notificationCount = notificationCount;
    _indicator.hidden = notificationCount <= 0;
    _indicator.count = notificationCount;
    [self setNeedsLayout];
}
- (void)prepareForReuse{
    [super prepareForReuse];
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
    self.accessoryView.hidden = NO;
    self.textLabel.textColor = kColorTextMain;
    self.selectedAction = nil;
}

-(void)setPosition:(BaseSimpleCellBGViewPosition)position{
    _position = position;
    
    if (position == BaseSimpleCellBGPositionTop) {
        self.drawHeadLine = YES;
        self.separatorLineInset = kSeparatorLineInset;
        self.separatorLineTailInset = self.separatorLineInset;
    } else if (position == BaseSimpleCellBGPositionMiddle) {
        self.drawHeadLine = NO;
        self.separatorLineInset = kSeparatorLineInset;
        self.separatorLineTailInset = self.separatorLineInset;
    } else if (position == BaseSimpleCellBGPositionBottom) {
        self.drawHeadLine = NO;
        self.separatorLineInset = 0;
        self.separatorLineTailInset = self.separatorLineInset;
    } else if (position == BaseSimpleCellBGPositionSingle) {
        self.drawHeadLine = YES;
        self.separatorLineInset = 0;
        self.separatorLineTailInset = self.separatorLineInset;
    }
    
}

-(void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType{
    [super setAccessoryType:accessoryType];
    if (accessoryType == UITableViewCellAccessoryNone) {
        [self.accessoryView setHidden:YES];
    }
}

@end

//#define kTextTopMargin 8.0
//
//@implementation FakeSectionTitleView
//
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor = [UIColor clearColor];
//        self.contentView.backgroundColor = [UIColor clearColor];
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.textLabel.textColor = kColorGrey55;
//        self.textLabel.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:14.0];
//    }
//    return self;
//}
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    [self.textLabel sizeToFit];
//    self.textLabel.center = CGPointMake(21.0 + self.textLabel.bounds.size.width/2.0 , self.bounds.size.height - self.textLabel.font.pointSize/2.0 - kTextTopMargin);
//    [_additionalBtn sizeToFit];
//    _additionalBtn.center = CGPointMake(CGRectGetMaxX(self.textLabel.frame) + _additionalBtn.bounds.size.width /2.0, self.textLabel.center.y);
//}
//- (UIButton *)additionalBtn{
//    if (!_additionalBtn) {
//        _additionalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _additionalBtn.backgroundColor = [UIColor clearColor];
//        _additionalBtn.contentEdgeInsets = UIEdgeInsetsMake(6, 0, 6, 0);
//        [_additionalBtn setTitleColor:kColorAppMain forState:UIControlStateNormal];
//        [_additionalBtn setTitleColor:[kColorAppMain colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];
//        _additionalBtn.titleLabel.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:14.0];
//        [self.contentView addSubview:_additionalBtn];
//    }
//    return _additionalBtn;
//}
//@end


#pragma mark -

@implementation BaseSimpleInputCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _inputView = [[UITextField alloc]initWithFrame:CGRectZero];
        _inputView.font = self.textLabel.font;
        _inputView.textColor = kColorTextMain;
        _inputView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.contentView addSubview:_inputView];
        _inputView.keyboardType = UIKeyboardTypeEmailAddress;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.accessoryView.hidden = YES;
    [self.textLabel resetSizeWidth:96.0];
    _inputView.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame), 0, self.bounds.size.width - CGRectGetMaxX(self.textLabel.frame)*2 + CGRectGetWidth(self.textLabel.frame), self.bounds.size.height);
}
@end
