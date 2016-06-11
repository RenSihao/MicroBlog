//
//  SHProfilePageHeadView.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/13.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHProfilePageHeadView.h"

@interface SHProfilePageHeadView ()

/**
 *  背景图片
 */
@property (nonatomic, strong) UIImageView *coverImageView;

/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *avatarImageView;

/**
 *  昵称
 */
@property (nonatomic, strong) UILabel *nameLab;

/**
 *  性别
 */
@property (nonatomic, strong) UIImageView *sexImageView;

/**
 *  会员
 */
@property (nonatomic, strong) UIImageView *vipImageView;

/**
 *  关注
 */
@property (nonatomic, strong) UILabel *focusLab;

/**
 *  分割线
 */
@property (nonatomic, strong) UIView *line;

/**
 *  粉丝
 */
@property (nonatomic, strong) UILabel *fansLab;

/**
 *  个性签名
 */
@property (nonatomic, strong) UILabel *descriptionLab;
@end

@implementation SHProfilePageHeadView

#pragma mark - init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
    }
    return self;
}

#pragma mark - 数据源更新

- (void)setModel:(SHUserModel *)model
{
    _model = model;
    
    /**
     *  背景
     */
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_model.coverImageForPhoneUrl] placeholderImage:nil completed:nil];
    
    /**
     *  头像
     */
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.avatarHDUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.avatarImageView.image = [UIImage cricelImage:image borderWidth:0 borderColor:[UIColor whiteColor]];
    }];
    
    //昵称
    self.nameLab.text = _model.name;
    
    if ([_model.gender isEqualToString:@"f"])
    {
        self.sexImageView.image = [UIImage imageNamed:@""];
    }
    else if ([_model.gender isEqualToString:@"m"])
    {
        self.sexImageView.image = [UIImage imageNamed:@""];
    }
    
    //VIP
    self.vipImageView.image = [UIImage imageNamed:@"userinfo_membership_level1"];
    
    
    //关注
    self.focusLab.text = [NSString stringWithFormat:@"关注 %ld", _model.friendsCount];
    
    //粉丝
    self.fansLab.text = [NSString stringWithFormat:@"粉丝 %ld", _model.followersCount];
    
    //个性签名
    self.descriptionLab.text = [NSString stringWithFormat:@"简介：%@", _model.userDescription];
}

#pragma mark - 子控件

- (void)addAllSubViews
{
    [super addAllSubViews];
    
    CGFloat margin = 5;
    
    /**
     *  背景
     */
    [self.contentView addSubview:self.coverImageView];
    self.coverImageView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(-30, 0, 0, 0));
    
    /**
     *  头像
     */
    [self.contentView addSubview:self.avatarImageView];
    self.avatarImageView.sd_layout
    .topSpaceToView(self.contentView, 64+4*margin)
    .centerXEqualToView(self.contentView)
    .widthIs(70)
    .widthEqualToHeight();
    
    /**
     *  昵称
     */
    [self.contentView addSubview:self.nameLab];
    self.nameLab.sd_layout
    .topSpaceToView(self.avatarImageView, margin)
    .centerXEqualToView(self.avatarImageView)
    .autoHeightRatio(0);
    [self.nameLab setSingleLineAutoResizeWithMaxWidth:self.contentView.width*0.5];
    
    /**
     *  性别
     */
    [self.contentView addSubview:self.sexImageView];
    self.sexImageView.sd_layout
    .centerYEqualToView(self.nameLab)
    .leftSpaceToView(self.nameLab, margin)
    .widthIs(10)
    .heightEqualToWidth();
    
    /**
     *  vip会员
     */
    [self.contentView addSubview:self.vipImageView];
    self.vipImageView.sd_layout
    .centerYEqualToView(self.nameLab)
    .leftSpaceToView(self.sexImageView, margin)
    .widthIs(30)
    .heightIs(10);
    
    /**
     *  分割线
     */
    [self.contentView addSubview:self.line];
    self.line.sd_layout
    .topSpaceToView(self.nameLab, 2*margin)
    .centerXEqualToView(self.nameLab)
    .widthIs(1)
    .heightIs(15);
    
    
    /**
     *  关注
     */
    [self.contentView addSubview:self.focusLab];
    self.focusLab.sd_layout
    .topEqualToView(self.line)
    .rightSpaceToView(self.line, 2*margin)
    .autoHeightRatio(0);
    [self.focusLab setSingleLineAutoResizeWithMaxWidth:100];
    
    /**
     *  粉丝
     */
    [self.contentView addSubview:self.fansLab];
    self.fansLab.sd_layout
    .topEqualToView(self.line)
    .leftSpaceToView(self.line, 2*margin)
    .autoHeightRatio(0);
    [self.fansLab setSingleLineAutoResizeWithMaxWidth:100];
    
    /**
     *  个性签名
     */
    [self.contentView addSubview:self.descriptionLab];
    self.descriptionLab.sd_layout
    .topSpaceToView(self.line, 2*margin)
    .centerXEqualToView(self.line)
    .autoHeightRatio(0);
    [self.descriptionLab setSingleLineAutoResizeWithMaxWidth:self.contentView.width *0.75];
    
    [self setupAutoHeightWithBottomView:self.descriptionLab bottomMargin:4*margin];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - lazy load

- (UIImageView *)coverImageView
{
    if (!_coverImageView)
    {
        _coverImageView = [UIImageView new];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.layer.masksToBounds = YES;
    }
    return _coverImageView;
}
- (UIImageView *)avatarImageView
{
    if (!_avatarImageView)
    {
        _avatarImageView = [UIImageView new];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        _avatarImageView.layer.masksToBounds = YES;
    }
    return _avatarImageView;
}
- (UILabel *)nameLab
{
    if (!_nameLab)
    {
        _nameLab = [UILabel new];
        _nameLab.font = [UIFont fontWithName:kDefaultBoldFontFamilyName size:17.f];
        _nameLab.textColor = kColorTextWhite;
    }
    return _nameLab;
}
- (UIImageView *)sexImageView
{
    if (!_sexImageView)
    {
        _sexImageView = [UIImageView new];
        _sexImageView.contentMode = UIViewContentModeScaleAspectFit;
        _sexImageView.layer.masksToBounds = YES;
    }
    return _sexImageView;
}
- (UIImageView *)vipImageView
{
    if (!_vipImageView)
    {
        _vipImageView = [UIImageView new];
        _vipImageView.contentMode = UIViewContentModeScaleAspectFit;
        _vipImageView.layer.masksToBounds = YES;
    }
    return _vipImageView;
}
- (UILabel *)focusLab
{
    if (!_focusLab)
    {
        _focusLab = [UILabel new];
        _focusLab.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:14.f];
        _focusLab.textColor = kColorTextWhite;
    }
    return _focusLab;
}
- (UIView *)line
{
    if (!_line)
    {
        _line = [UIView new];
        _line.backgroundColor = [UIColor whiteColor];
    }
    return _line;
}
- (UILabel *)fansLab
{
    if (!_fansLab)
    {
        _fansLab = [UILabel new];
        _fansLab.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:14.f];
        _fansLab.textColor = kColorTextWhite;
    }
    return _fansLab;
}
- (UILabel *)descriptionLab
{
    if (!_descriptionLab)
    {
        _descriptionLab = [UILabel new];
        _descriptionLab.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:13.f];
        _descriptionLab.textColor = kColorTextWhite;
    }
    return _descriptionLab;
}

@end


