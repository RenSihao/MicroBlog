//
//  SHProfileCell.m
//  MicroBlog
//
//  Created by RenSihao on 16/2/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHProfileCell.h"
#import "SHProfileCellModel.h"
#import "WZLBadgeImport.h"

@interface SHProfileCell ()

@property (nonatomic, strong) UIImageView *iconImageView; //图标
@property (nonatomic, strong) UILabel *titleLab;          //标题
@property (nonatomic, strong) UILabel *detailTilteLab;    //详细标题
@property (nonatomic, strong) UIView *redBadgeView;       //小红点
@property (nonatomic, strong) UIImageView *rightArrow;    //右边箭头
@property (nonatomic, strong) UIView *line;               //分割线
@property (nonatomic, strong) SHProfileCellModel *model; 
@end

@implementation SHProfileCell

#pragma mark - public method

+ (CGFloat)cellHeight
{
    return 55.f;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLab];
        [self addSubview:self.detailTilteLab];
        [self addSubview:self.redBadgeView];
        [self addSubview:self.rightArrow];
        [self addSubview:self.line];
    }
    return self;
}
- (void)updateWithProfileCellModel:(SHProfileCellModel *)model
{
    _model = model;
    self.iconImageView.image = _model.iconImage;
    self.titleLab.text = _model.title;
    self.detailTilteLab.text = _model.detailTitle;
    
    //有新通知
    if (_model.hasNewNotification)
    {
        self.redBadgeView.hidden = NO;
        self.rightArrow.hidden = YES;
    }
    //没有新通知
    else
    {
        self.redBadgeView.hidden = YES;
        self.rightArrow.hidden = NO;
    }
}



#pragma mark - private method

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //图标
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(12);
        make.left.mas_equalTo(self).offset(12);
        make.bottom.mas_equalTo(self).offset(-12);
        make.height.mas_equalTo(self.iconImageView.mas_width);
    }];
    
    //标题
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(8);
        make.top.bottom.mas_equalTo(self.iconImageView);
    }];
    
    //详细标题
    [self.detailTilteLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset(8);
        make.top.bottom.mas_equalTo(self.titleLab);
    }];
    
    //小红点
    [self.redBadgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(self.height / 4);
    }];
    
    //右边箭头
    [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-12);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(self.height / 4);
    }];
    
    //分割线
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(self);
    }];
}


#pragma mark - lazy load

- (UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
}
- (UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont systemFontOfSize:15.f];
        [_titleLab.text boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_titleLab.font} context:nil];
        _titleLab.numberOfLines = 1;
    }
    return _titleLab;
}
- (UILabel *)detailTilteLab
{
    if (!_detailTilteLab)
    {
        _detailTilteLab = [[UILabel alloc] init];
        _detailTilteLab.textAlignment = NSTextAlignmentLeft;
        _detailTilteLab.textColor = [UIColor grayColor];
        _detailTilteLab.font = [UIFont systemFontOfSize:10.f];
        [_detailTilteLab.text boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_titleLab.font} context:nil];
        _detailTilteLab.numberOfLines = 1;
    }
    return _detailTilteLab;
}
- (UIView *)redBadgeView
{
    if (!_redBadgeView)
    {
        _redBadgeView = [[UIView alloc] init];
        _redBadgeView.badgeBgColor = [UIColor redColor];
        _redBadgeView.badgeCenterOffset = _redBadgeView.center;
        [_redBadgeView showBadgeWithStyle:WBadgeStyleRedDot value:0 animationType:WBadgeAnimTypeNone];
    }
    return _redBadgeView;
}
- (UIImageView *)rightArrow
{
    if (!_rightArrow)
    {
        _rightArrow = [[UIImageView alloc] init];
        _rightArrow.image = [UIImage imageNamed:@"common_icon_arrow"];
        _rightArrow.clipsToBounds = YES;
        _rightArrow.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rightArrow;
}
- (UIView *)line
{
    if (!_line)
    {
        _line = [UIView new];
        _line.backgroundColor = [UIColor grayColor];
        _line.alpha = 0.5;
    }
    return _line;
}

@end
