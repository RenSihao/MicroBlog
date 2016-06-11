//
//  SHProfileHeaderView.m
//  MicroBlog
//
//  Created by RenSihao on 16/2/17.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHProfileHeaderView.h"
#import "SHUserModel.h"

/************* 个人信息 **********************/
@interface SHProfileHeaderView ()

@property (nonatomic, strong) UIImageView *avatarImageView; //头像
@property (nonatomic, strong) UILabel *nickNameLab;         //昵称
@property (nonatomic, strong) UILabel *introductionLab;     //个性签名
@property (nonatomic, strong) UIImageView *levelImageView;  //等级
@property (nonatomic, strong) UIButton *vipBtn;             //会员
@property (nonatomic, strong) UIView *line;                 //分割线

@property (nonatomic, strong) SHUserModel *model;
@end

@implementation SHProfileHeaderView

#pragma mark - public method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self addAllSubviews];
    }
    return self;
}
- (void)configureProfileHeaderViewWithUserModel:(SHUserModel *)model
{
    _model = model;
    
    //头像
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.avatarHDUrl]
                            placeholderImage:nil
                                     options:SDWebImageAvoidAutoSetImage
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        //圆形裁剪
        self.avatarImageView.image = [UIImage cricelImage:image borderWidth:0 borderColor:[UIColor whiteColor]];
    }];
    
    //昵称
    self.nickNameLab.text = _model.screenName;
    [self.nickNameLab sizeToFit];
    
    //个性签名
    NSString *introductionString = [NSString stringWithFormat:@"简介：%@", _model.userDescription.length > 0 ? _model.userDescription : @"暂无"];
    self.introductionLab.text = introductionString;
}

#pragma mark - private method

- (void)addAllSubviews
{
    CGFloat margin = 4;
    
    //头像
    [self.contentView addSubview:self.avatarImageView];
    self.avatarImageView.sd_layout
    .topSpaceToView(self.contentView, 2*margin)
    .leftSpaceToView(self.contentView, 2*margin)
    .widthIs(75)
    .heightEqualToWidth();
    
    //昵称
    [self.contentView addSubview:self.nickNameLab];
    self.nickNameLab.sd_layout
    .topSpaceToView(self.contentView, 6*margin)
    .leftSpaceToView(self.avatarImageView, 2*margin)
    .heightIs(20);
    [self.nickNameLab setSingleLineAutoResizeWithMaxWidth:200];
    
    //个人简介
    [self.contentView addSubview:self.introductionLab];
    self.introductionLab.sd_layout
    .leftEqualToView(self.nickNameLab)
    .topSpaceToView(self.nickNameLab, margin)
    .heightIs(15);
    [self.introductionLab setSingleLineAutoResizeWithMaxWidth:200];
    
    //会员按钮
    [self.contentView addSubview:self.vipBtn];
    self.vipBtn.sd_layout
    .rightSpaceToView(self.contentView, 2*margin)
    .centerYEqualToView(self.contentView)
    .widthRatioToView(self.contentView, 0.1)
    .heightIs(20);
    
    //VIP图标
    [self.contentView addSubview:self.levelImageView];
    self.levelImageView.sd_layout
    .rightSpaceToView(self.vipBtn, margin)
    .centerYEqualToView(self.vipBtn)
    .widthIs(25)
    .heightEqualToWidth();
    
    
    
    //分割线
    [self.contentView addSubview:self.line];
    self.line.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .topSpaceToView(self.avatarImageView, 2*margin)
    .heightIs(0.5);

    [self setupAutoHeightWithBottomView:self.line bottomMargin:0];
}

#pragma mark - lazy load

- (UIImageView *)avatarImageView
{
    if (!_avatarImageView)
    {
        _avatarImageView = [UIImageView new];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.layer.masksToBounds = YES;
    }
    return _avatarImageView;
}
- (UILabel *)nickNameLab
{
    if (!_nickNameLab)
    {
        _nickNameLab = [UILabel new];
        _nickNameLab.font = [UIFont boldSystemFontOfSize:15.f];
        _nickNameLab.textColor = [UIColor blackColor];
        _nickNameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _nickNameLab;
}
- (UILabel *)introductionLab
{
    if (!_introductionLab)
    {
        _introductionLab = [UILabel new];
        _introductionLab.font = [UIFont systemFontOfSize:12.f];
        _introductionLab.textColor = [UIColor grayColor];
        _introductionLab.textAlignment = NSTextAlignmentLeft;
    }
    return _introductionLab;
}
- (UIImageView *)levelImageView
{
    if (!_levelImageView)
    {
//        _levelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_membership_expired"]];
        _levelImageView = [UIImageView new];
        _levelImageView.contentMode = UIViewContentModeScaleAspectFill;
        _levelImageView.layer.masksToBounds = YES;
    }
    return _levelImageView;
}
- (UIButton *)vipBtn
{
    if (!_vipBtn)
    {
        _vipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_vipBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:12.f]];
        [_vipBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_vipBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_vipBtn setTitle:@"会员" forState:UIControlStateNormal];
        [_vipBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_right"] forState:UIControlStateNormal];
        _vipBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        _vipBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        
        [_vipBtn sizeToFit];
    }
    return _vipBtn;
}
- (UIView *)line
{
    if (!_line)
    {
        _line = [UIView new];
        _line.backgroundColor = [UIColor blackColor];
        _line.alpha = 0.2;
    }
    return _line;
}



@end




/************* 微博 关注 粉丝 ****************/
@interface SHProfileBlogCountView ()

@property (nonatomic, strong) UILabel *weiBoCountLab;       //微博数量
@property (nonatomic, strong) UILabel *weiBoLab;            //微博
@property (nonatomic, strong) UILabel *focusCountLab;       //关注数量
@property (nonatomic, strong) UILabel *focusLab;            //关注
@property (nonatomic, strong) UILabel *fansCountLab;        //粉丝数量
@property (nonatomic, strong) UILabel *fansLab;             //粉丝

@property (nonatomic, strong) SHUserModel *model;
@end

@implementation SHProfileBlogCountView

#pragma mark - public method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self addAllSubviews];
    }
    return self;
}
- (void)configureProfileBlogCountViewWithUserModel:(SHUserModel *)model
{
    _model = model;
    self.weiBoCountLab.text = [NSString stringWithFormat:@"%ld", _model.statusesCount];
    self.focusCountLab.text = [NSString stringWithFormat:@"%ld", _model.friendsCount];
    self.fansCountLab.text  = [NSString stringWithFormat:@"%ld", _model.followersCount];

    [self.weiBoCountLab sizeToFit];
}

#pragma mark - private method

- (void)addAllSubviews
{
    CGFloat margin = 4;
    CGFloat width = SCREEN_WIDTH / 3;
    CGFloat height = self.contentView.height;
    
    //微博数量
    [self.contentView addSubview:self.weiBoCountLab];
    
    self.weiBoCountLab.sd_layout
    .centerXIs(width / 2)
    .centerYIs(height / 3)
    .heightIs(15);
    [self.weiBoCountLab setSingleLineAutoResizeWithMaxWidth:100];
    
    //微博
    [self.contentView addSubview:self.weiBoLab];
    self.weiBoLab.sd_layout
    .topSpaceToView(self.weiBoCountLab, margin)
    .centerXEqualToView(self.weiBoCountLab)
    .heightIs(15);
    [self.weiBoLab setSingleLineAutoResizeWithMaxWidth:100];
    
    //关注数量
    [self.contentView addSubview:self.focusCountLab];
    self.focusCountLab.sd_layout
    .centerXIs(width / 2 * 3)
    .centerYIs(height / 3)
    .heightIs(15);
    [self.focusCountLab setSingleLineAutoResizeWithMaxWidth:100];
    
    //关注
    [self.contentView addSubview:self.focusLab];
    self.focusLab.sd_layout
    .topEqualToView(self.weiBoLab)
    .centerXEqualToView(self.focusCountLab)
    .heightIs(15);
    [self.focusLab setSingleLineAutoResizeWithMaxWidth:100];
    
    //粉丝数量
    [self.contentView addSubview:self.fansCountLab];
    self.fansCountLab.sd_layout
    .centerXIs(width / 2 * 5)
    .centerYIs(height / 3)
    .heightIs(15);
    [self.fansCountLab setSingleLineAutoResizeWithMaxWidth:100];
    
    //粉丝
    [self.contentView addSubview:self.fansLab];
    self.fansLab.sd_layout
    .topEqualToView(self.focusLab)
    .centerXEqualToView(self.fansCountLab)
    .heightIs(15);
    [self.fansLab setSingleLineAutoResizeWithMaxWidth:100];
    
    //分别覆盖三个透明view 来响应点击手势
    for (int i=0; i<3; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(width*i, 0, width, self.contentView.height)];
        view.tag = i;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGest = [UITapGestureRecognizer alloc];
        tapGest.numberOfTapsRequired = 1;
        tapGest.numberOfTouchesRequired = 1;
        [tapGest addTarget:self action:@selector(didClickView:)];
        [view addGestureRecognizer:tapGest];
        [self.contentView addSubview:view];
    }
    
    
    [self setupAutoHeightWithBottomView:self.weiBoLab bottomMargin:margin];
}

#pragma mark - lazy load
- (UILabel *)weiBoCountLab
{
    if (!_weiBoCountLab)
    {
        _weiBoCountLab = [UILabel new];
        _weiBoCountLab.textColor = [UIColor blackColor];
        _weiBoCountLab.font = [UIFont boldSystemFontOfSize:12.f];
        _weiBoCountLab.textAlignment = NSTextAlignmentCenter;
    }
    return _weiBoCountLab;
}
- (UILabel *)weiBoLab
{
    if (!_weiBoLab)
    {
        _weiBoLab = [UILabel new];
        _weiBoLab.textColor = [UIColor grayColor];
        _weiBoLab.font = [UIFont systemFontOfSize:10.f];
        _weiBoLab.textAlignment = NSTextAlignmentCenter;
        _weiBoLab.text = @"微博";
    }
    return _weiBoLab;
}
- (UILabel *)focusCountLab
{
    if (!_focusCountLab)
    {
        _focusCountLab = [UILabel new];
        _focusCountLab.textColor = [UIColor blackColor];
        _focusCountLab.font = [UIFont boldSystemFontOfSize:12.f];
        _focusCountLab.textAlignment = NSTextAlignmentCenter;
    }
    return _focusCountLab;
}
- (UILabel *)focusLab
{
    if (!_focusLab)
    {
        _focusLab = [UILabel new];
        _focusLab.textColor = [UIColor grayColor];
        _focusLab.font = [UIFont systemFontOfSize:10.f];
        _focusLab.textAlignment = NSTextAlignmentCenter;
        _focusLab.text = @"关注";
    }
    return _focusLab;
}
- (UILabel *)fansCountLab
{
    if (!_fansCountLab)
    {
        _fansCountLab = [UILabel new];
        _fansCountLab.textColor = [UIColor blackColor];
        _fansCountLab.font = [UIFont boldSystemFontOfSize:12.f];
        _fansCountLab.textAlignment = NSTextAlignmentCenter;
    }
    return _fansCountLab;
}
- (UILabel *)fansLab
{
    if (!_fansLab)
    {
        _fansLab = [UILabel new];
        _fansLab.textColor = [UIColor grayColor];
        _fansLab.font = [UIFont systemFontOfSize:10.f];
        _fansLab.textAlignment = NSTextAlignmentCenter;
        _fansLab.text = @"粉丝";
    }
    return _fansLab;
}



- (void)didClickView:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(profileCountView:didClickItem:)])
    {
        [self.delegate profileCountView:self didClickItem:tap.view.tag];
    }
}


@end


















