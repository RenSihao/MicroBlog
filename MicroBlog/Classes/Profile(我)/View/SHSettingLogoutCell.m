//
//  SHSettingLogoutCell.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/6.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHSettingLogoutCell.h"

@interface SHSettingLogoutCell ()

@property (nonatomic, strong) UILabel *titleLab;
@end

@implementation SHSettingLogoutCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.contentView);
    }];
}

- (UILabel *)titleLab
{
    if (!_titleLab)
    {
        _titleLab = [UILabel new];
        _titleLab.font = [UIFont fontWithName:kDefaultBoldFontFamilyName size:17.f];
        _titleLab.textColor = [UIColor redColor];
        _titleLab.contentMode = UIViewContentModeCenter;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"退出当前账号";
    }
    return _titleLab;
}

@end
