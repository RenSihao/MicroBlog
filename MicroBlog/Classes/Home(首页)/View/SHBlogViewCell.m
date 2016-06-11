//
//  SHBlogViewCell.m
//  MicroBlog
//
//  Created by RenSihao on 16/2/24.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHBlogViewCell.h"
#import "SHBlogDetailModel.h"
#import "SHPhotoContainerView.h"
#import "SHStatusModel.h"

@interface SHBlogViewCell () <SHBlogViewCellDelegate>

@property (nonatomic, strong) UIImageView *avatarImageView; //头像
@property (nonatomic, strong) UILabel *nameLab;             //昵称
@property (nonatomic, strong) UIImageView *vipImageView;    //会员标志
@property (nonatomic, strong) UILabel *timeLab;             //时间
@property (nonatomic, strong) UILabel *sourceLab;           //来源
@property (nonatomic, strong) UIButton *functionBtn;        //右上角功能按钮
@property (nonatomic, strong) UILabel *textLab;             //文字
@property (nonatomic, strong) SHPhotoContainerView *pictureView; //图片
@property (nonatomic, strong) UIButton *relayBtn;           //转发
@property (nonatomic, strong) UIButton *commentBtn;         //评论
@property (nonatomic, strong) UIButton *praiseBtn;          //点赞
@property (nonatomic, strong) UIView *line;                 //水平分割线
@property (nonatomic, strong) UIView *line1 , *line2;       //垂直分割线
@property (nonatomic, strong) UIView *footView;             //底部分割背景

@end

@implementation SHBlogViewCell

#pragma mark - public method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = kColorBgMain;
        [self addAllSubViews];
    }
    return self;
}
- (void)setModel:(SHStatusModel *)model
{
    _model = model;
    
    //头像
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.user.avatar_large ? _model.user.avatar_large: _model.user.avatar_hd] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.avatarImageView.image = [UIImage cricelImage:image borderWidth:0 borderColor:[UIColor clearColor]];
    }];;
    
    //昵称
    self.nameLab.text = _model.user.name;
    
    //时间
    self.timeLab.text = _model.created_at;
    
    //来源
    if (_model.source.length > 0)
    {
        NSArray *strArray = [[_model.source componentsSeparatedByString:@">"][1] componentsSeparatedByString:@"<"];
        self.sourceLab.text = [NSString stringWithFormat:@"%@", strArray[0]];
    }
    else
    {
        self.sourceLab.text = @"未知来源";
    }
    
    
    //文字
    NSString *str = _model.text;
    self.textLab.text = str;
    
    //图片
    if (_model.pic_urls.count > 0)
    {
        NSMutableArray *pictureArray = [NSMutableArray array];
        for (PictureUrlModel *pictureModel in _model.pic_urls)
        {
            [pictureArray addObject:pictureModel.thumbnail_pic];
        }
        self.pictureView.picturesPathStringArray = pictureArray;
    }
    
    
    //设置图片距离文字的间距
    CGFloat pictureContainerTopMargin = 0;
    if (_model.pic_urls.count > 0)
    {
        pictureContainerTopMargin = 10;
    }
    self.pictureView.sd_layout.topSpaceToView(self.textLab, pictureContainerTopMargin);
    
    //转发
    [self.relayBtn setTitle:_model.reposts_count ? [NSString stringWithFormat:@"%ld", _model.reposts_count]:@"转发" forState:UIControlStateNormal];
    
    //评论
    [self.commentBtn setTitle:_model.comments_count ? [NSString stringWithFormat:@"%ld", _model.comments_count]:@"评论"  forState:UIControlStateNormal];
    
    //点赞
    [self.praiseBtn setTitle:_model.attitudes_count ? [NSString stringWithFormat:@"%ld", _model.attitudes_count]:@"赞" forState:UIControlStateNormal];
    
    
    //VIP过滤，进行特殊处理
//    if (_model.vip)
//    {
//        self.nameLab.textColor = [UIColor orangeColor];
//    }
//    
//    switch (_model.vip) {
//        case 1:
//        {
//            self.vipImageView.image = [UIImage imageNamed:@"common_icon_membership_level1"];
//        }
//            break;
//        case 2:
//        {
//            self.vipImageView.image = [UIImage imageNamed:@"common_icon_membership_level2"];
//        }
//            break;
//        case 3:
//        {
//            self.vipImageView.image = [UIImage imageNamed:@"common_icon_membership_level3"];
//        }
//            break;
//        case 4:
//        {
//            self.vipImageView.image = [UIImage imageNamed:@"common_icon_membership_level4"];
//        }
//            break;
//        case 5:
//        {
//            self.vipImageView.image = [UIImage imageNamed:@"common_icon_membership_level5"];
//        }
//            break;
//        case 6:
//        {
//            self.vipImageView.image = [UIImage imageNamed:@"common_icon_membership_level6"];
//        }
//            break;
//            
//        default:
//      
//            break;
//    }

}

#pragma mark - private method

- (void)addAllSubViews
{
    CGFloat margin = 4;
    
    //头像
    [self.contentView addSubview:self.avatarImageView];
    self.avatarImageView.sd_layout
    .leftSpaceToView(self.contentView, 2*margin)
    .topSpaceToView(self.contentView, 2*margin)
    .widthIs(40)
    .heightEqualToWidth();
    
    
    //昵称
    [self.contentView addSubview:self.nameLab];
    self.nameLab.sd_layout
    .leftSpaceToView(self.avatarImageView, 2*margin)
    .topSpaceToView(self.contentView, 3*margin)
    .heightRatioToView(self.avatarImageView, 0.4);
    [self.nameLab setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH*0.75];
    
    
    //VIP
    [self.contentView addSubview:self.vipImageView];
    self.vipImageView.sd_layout
    .leftSpaceToView(self.nameLab, margin)
    .topEqualToView(self.nameLab)
    .widthIs(15).heightIs(15);
    
    
    //时间
    [self.contentView addSubview:self.timeLab];
    self.timeLab.sd_layout
    .leftEqualToView(self.nameLab)
    .topSpaceToView(self.nameLab, 0);
    [self.timeLab setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH*0.75];
    
    //来源
    [self.contentView addSubview:self.sourceLab];
    self.sourceLab.sd_layout
    .leftSpaceToView(self.timeLab, margin)
    .topEqualToView(self.timeLab);
    [self.sourceLab setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH*0.75];
    
    
    //功能按钮
    [self.contentView addSubview:self.functionBtn];
    self.functionBtn.sd_layout
    .topEqualToView(self.avatarImageView)
    .rightSpaceToView(self.contentView, 2*margin)
    .widthIs(20).heightIs(20);
    
    
    //文字
    [self.contentView addSubview:self.textLab];
    self.textLab.sd_layout
    .leftEqualToView(self.avatarImageView)
    .topSpaceToView(self.avatarImageView, 2*margin)
    .rightSpaceToView(self.contentView, 2*margin)
    .autoHeightRatio(0);
 
    
    //图片
    [self.contentView addSubview:self.pictureView];
    self.pictureView.sd_layout
    .leftEqualToView(self.textLab);
    
    //视频
    
    
    
    //水平分割线
    [self.contentView addSubview:self.line];
    self.line.sd_layout
    .topSpaceToView(self.pictureView, 2*margin)
    .leftEqualToView(self.contentView)
    .heightIs(2.5);

    CGFloat width = SCREEN_WIDTH / 3;
    
    //转发
    [self.contentView addSubview:self.relayBtn];
    self.relayBtn.sd_layout
    .topSpaceToView(self.line, 0)
    .leftEqualToView(self.contentView)
    .widthIs(width)
    .heightIs(40);

    //垂直分割线1
    [self.contentView addSubview:self.line1];
    self.line1.sd_layout
    .leftSpaceToView(self.contentView, width-0.5)
    .centerYEqualToView(self.relayBtn)
    .heightIs(20)
    .widthIs(0.5);
    
    
    //评论
    [self.contentView addSubview:self.commentBtn];
    self.commentBtn.sd_layout
    .leftSpaceToView(self.contentView, width)
    .topEqualToView(self.relayBtn)
    .widthIs(width)
    .heightIs(40);
    
    //垂直分割线2
    [self.contentView addSubview:self.line2];
    self.line2.sd_layout
    .leftSpaceToView(self.contentView, 2*width - 0.5)
    .centerYEqualToView(self.relayBtn)
    .heightIs(20)
    .widthIs(0.5);

    //点赞
    [self.contentView addSubview:self.praiseBtn];
    self.praiseBtn.sd_layout
    .topEqualToView(self.relayBtn)
    .leftSpaceToView(self.contentView, 2*width)
    .widthIs(width)
    .heightIs(40);

    //底部分割背景
    [self.contentView addSubview:self.footView];
    self.footView.sd_layout
    .topSpaceToView(self.relayBtn, 0)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(2*margin);
    
    
    [self setupAutoHeightWithBottomViewsArray:@[self.textLab, self.pictureView, self.line, self.relayBtn, self.footView] bottomMargin:margin];
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
- (UILabel *)nameLab
{
    if (!_nameLab)
    {
        _nameLab = [UILabel new];
        _nameLab.font = [UIFont systemFontOfSize:13.f];
        _nameLab.textColor = [UIColor blackColor];
    }
    return _nameLab;
}
- (UIImageView *)vipImageView
{
    if (!_vipImageView)
    {
        _vipImageView = [UIImageView new];
        _vipImageView.contentMode = UIViewContentModeScaleAspectFill;
        _vipImageView.layer.masksToBounds = YES;
    }
    return _vipImageView;
}
- (UILabel *)timeLab
{
    if (!_timeLab)
    {
        _timeLab = [UILabel new];
        _timeLab.textColor = [UIColor orangeColor];
        _timeLab.font = [UIFont systemFontOfSize:10.f];
    }
    return _timeLab;
}
- (UILabel *)sourceLab
{
    if (!_sourceLab)
    {
        _sourceLab = [UILabel new];
        _sourceLab.textAlignment = NSTextAlignmentLeft;
        _sourceLab.font = [UIFont systemFontOfSize:10.f];
    }
    return _sourceLab;
}
- (UIButton *)functionBtn
{
    if (!_functionBtn)
    {
        _functionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _functionBtn.imageEdgeInsets = UIEdgeInsetsZero;
        [_functionBtn setImage:[UIImage imageNamed:@"timeline_icon_more"] forState:UIControlStateNormal];
        _functionBtn.adjustsImageWhenHighlighted = NO;
        [_functionBtn addTarget:self action:@selector(didClickFunctionBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _functionBtn;
}
- (UILabel *)textLab
{
    if (!_textLab)
    {
        _textLab = [UILabel new];
        _textLab.textColor = [UIColor blackColor];
        _textLab.font = [UIFont systemFontOfSize:15.f];
    }
    return _textLab;
}
- (SHPhotoContainerView *)pictureView
{
    if (!_pictureView)
    {
        _pictureView = [SHPhotoContainerView new];
        _pictureView.contentMode = UIViewContentModeScaleAspectFill;
        _pictureView.layer.masksToBounds = YES;
    }
    return _pictureView;
}
- (UIButton *)relayBtn
{
    if (!_relayBtn)
    {
        _relayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _relayBtn.tag = 1;
        [_relayBtn setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
        [_relayBtn setTitleColor:kColorAppMain forState:UIControlStateSelected];
        [_relayBtn setTitle:@"转发" forState:UIControlStateNormal];
        [_relayBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_relayBtn.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
        [_relayBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [_relayBtn addTarget:self action:@selector(didClickFunctionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _relayBtn;
}
- (UIButton *)commentBtn
{
    if (!_commentBtn)
    {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentBtn.tag = 2;
        [_commentBtn setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateNormal];
        [_commentBtn setImage:[UIImage imageNamed:@"messages_comment_icon_highlighted"] forState:UIControlStateSelected];
        [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
        [_commentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_commentBtn setTitleColor:kColorAppMain forState:UIControlStateSelected];
        [_commentBtn.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
        [_commentBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [_commentBtn addTarget:self action:@selector(didClickFunctionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}
- (UIButton *)praiseBtn
{
    if (!_praiseBtn)
    {
        _praiseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _praiseBtn.tag = 3;
        [_praiseBtn setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
        [_praiseBtn setImage:[UIImage imageNamed:@"common_praise_light_selected"] forState:UIControlStateSelected];
        [_praiseBtn setTitle:@"赞" forState:UIControlStateNormal];
        [_praiseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_praiseBtn setTitleColor:kColorAppMain forState:UIControlStateSelected];
        [_praiseBtn.titleLabel setFont:[UIFont systemFontOfSize:13.f]];
        [_praiseBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [_praiseBtn addTarget:self action:@selector(didClickFunctionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseBtn;
}
- (UIView *)line
{
    if (!_line)
    {
        _line= [UIView new];
        _line.backgroundColor = [UIColor blackColor];
        _line.alpha = 1;
    }
    return _line;
}
- (UIView *)line1
{
    if (!_line1)
    {
        _line1 = [UIView new];
        _line1.backgroundColor = [UIColor grayColor];
        _line1.alpha = 0.2;
    }
    return _line1;
}
- (UIView *)line2
{
    if (!_line2)
    {
        _line2 = [UIView new];
        _line2.backgroundColor = [UIColor grayColor];
        _line2.alpha = 0.2;
    }
    return _line2;
}
- (UIView *)footView
{
    if (!_footView)
    {
        _footView = [UIView new];
        _footView.backgroundColor = kColorBgSub;
        _footView.alpha = 0.5;
    }
    return _footView;
}

#pragma mark - SHBlogViewCellDelegate

- (void)didClickFunctionBtn:(UIButton *)functionBtn
{
    if ([self.delegate respondsToSelector:@selector(didClickFunctionBtn:info:)])
    {
        [self.delegate didClickFunctionBtn:functionBtn info:_model];
    }
}




@end
