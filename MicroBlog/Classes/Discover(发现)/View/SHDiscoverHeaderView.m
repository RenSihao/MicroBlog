//
//  SHDiscoverHeaderView.m
//  MicroBlog
//
//  Created by RenSihao on 16/2/17.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHDiscoverHeaderView.h"
#import "SHDiscoverHeaderModel.h"

@interface SHDiscoverHeaderView () 

@property (nonatomic, strong) UIView *topLine, *leftLine, *bottomLine, *rightLine; //四条分割线
@property (nonatomic, strong) UIButton *leftTopBtn, *rightTopBtn, *leftBottomBtn, *rightBottomBtn; //四个按钮
@property (nonatomic, strong) SHDiscoverHeaderModel *model; //数据模型
@end

@implementation SHDiscoverHeaderView

#pragma mark - public method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        [self.contentView addSubview:self.topLine];
        [self.contentView addSubview:self.leftLine];
        [self.contentView addSubview:self.bottomLine];
        [self.contentView addSubview:self.rightLine];
        [self.contentView addSubview:self.leftTopBtn];
        [self.contentView addSubview:self.rightTopBtn];
        [self.contentView addSubview:self.leftBottomBtn];
        [self.contentView addSubview:self.rightBottomBtn];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
    }
    return self;
}
- (void)updateWithDiscoverHeaderModel:(SHDiscoverHeaderModel *)model
{
    _model = model;

    [self.leftTopBtn setTitle:[NSString stringWithFormat:@"#%@#", _model.leftTopTitle] forState:UIControlStateNormal];
    [self.rightTopBtn setTitle:[NSString stringWithFormat:@"#%@#", _model.rightTopTitle] forState:UIControlStateNormal];
    [self.leftBottomBtn setTitle:[NSString stringWithFormat:@"#%@#", _model.leftBottomTitle] forState:UIControlStateNormal];
    [self.rightBottomBtn setTitle:[NSString stringWithFormat:@"#%@#", _model.rightBotttomTitle] forState:UIControlStateNormal];
}

#pragma mark - private method

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //上分割线
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(2);
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(self.contentView.height / 2 - 4);
    }];
    
    //左分割线
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(2);
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView.width / 2 - 4);
        make.height.mas_equalTo(0.5);
    }];
    
    //底分割线
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).offset(-2);
        make.centerX.width.height.mas_equalTo(self.topLine);
    }];
    
    //右分割线
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-2);
        make.centerY.width.height.mas_equalTo(self.leftLine);
    }];
    
    //左上按钮
    [self.leftTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView);
        make.width.mas_equalTo((self.contentView.width - 0.5) / 2);
        make.height.mas_equalTo((self.contentView.height - 0.5) / 2);
    }];
    
    //右上按钮
    [self.rightTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(self.leftTopBtn);
    }];
    
    //左下按钮
    [self.leftBottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(self.leftTopBtn);
    }];
    
    //右下按钮
    [self.rightBottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(self.leftTopBtn);
    }];
    
    
}

#pragma mark - lazy load

- (UIView *)topLine
{
    if (!_topLine)
    {
        _topLine = [UIView new];
        _topLine.backgroundColor = [UIColor blackColor];
        _topLine.alpha = 0.75;
    }
    return _topLine;
}
- (UIView *)leftLine
{
    if (!_leftLine)
    {
        _leftLine = [UIView new];
        _leftLine.backgroundColor = [UIColor blackColor];
        _leftLine.alpha = 0.75;
    }
    return _leftLine;
}
- (UIView *)bottomLine
{
    if (!_bottomLine)
    {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = [UIColor blackColor];
        _bottomLine.alpha = 0.75;
    }
    return _bottomLine;
}
-(UIView *)rightLine
{
    if (!_rightLine)
    {
        _rightLine = [UIView new];
        _rightLine.backgroundColor = [UIColor blackColor];
        _rightLine.alpha = 0.75;
    }
    return _rightLine;
}
- (UIButton *)leftTopBtn
{
   if (!_leftTopBtn)
   {
       _leftTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       _leftTopBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
       _leftTopBtn.titleLabel.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:17.f];
       [_leftTopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       _leftTopBtn.tag = 1;

       [_leftTopBtn addTarget:self action:@selector(didClickButtonOfTag:) forControlEvents:UIControlEventTouchUpInside];
   }
    return _leftTopBtn;
}
- (UIButton *)rightTopBtn
{
   if (!_rightTopBtn)
   {
       _rightTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       _rightTopBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
       [_rightTopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       _rightTopBtn.titleLabel.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:17.f];
       _rightTopBtn.tag = 2;
       [_rightTopBtn addTarget:self action:@selector(didClickButtonOfTag:) forControlEvents:UIControlEventTouchUpInside];
   }
    return _rightTopBtn;
}
- (UIButton *)leftBottomBtn
{
    if (!_leftBottomBtn)
    {
        _leftBottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBottomBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_leftBottomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _leftBottomBtn.titleLabel.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:17.f];
        _leftBottomBtn.tag = 3;
        [_leftBottomBtn addTarget:self action:@selector(didClickButtonOfTag:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBottomBtn;
}
- (UIButton *)rightBottomBtn
{
    if (!_rightBottomBtn)
    {
        _rightBottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBottomBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_rightBottomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rightBottomBtn.titleLabel.font = [UIFont fontWithName:kDefaultRegularFontFamilyName size:17.f];
        _rightBottomBtn.tag = 4;
        [_rightBottomBtn addTarget:self action:@selector(didClickButtonOfTag:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBottomBtn;
}

#pragma mark - 监听点击事件

- (void)didClickButtonOfTag:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(discoverHeaderView:didClickItemAtIndex:)])
    {
        [self.delegate discoverHeaderView:self didClickItemAtIndex:sender.tag];
    }
}





@end
