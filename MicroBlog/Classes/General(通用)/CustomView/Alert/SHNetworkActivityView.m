//
//  SHNetworkActivityView.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/6.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHNetworkActivityView.h"

@interface SHNetworkActivityView ()

//加载指示器
@property(nonatomic,strong) UIActivityIndicatorView *actView;

//提示信息
@property(nonatomic,strong) UILabel *msgLabel;
@end

@implementation SHNetworkActivityView

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    CGFloat width = 70.0;
    CGFloat height = 70.0;
    frame = CGRectMake((SCREEN_WIDTH - width) / 2.0, (SCREEN_HEIGHT - STATUES_HEIGHT - NAV_BAR_HEIGHT - height) / 2.0, width, height);
    self = [super initWithFrame:frame];
    if(self)
    {
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = MainLightGrayColor;
        
        UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        view.center = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0);
        view.alpha = 0.6;
        [self addSubview:view];
        self.actView = view;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:MainFontName size:14.0];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        self.msgLabel = label;
        
        self.alpha = 0.6;
        [self.actView startAnimating];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = [self.msgLabel.text stringSizeWithFont:self.msgLabel.font contraintWith:self.width];
    
    self.actView.center = CGPointMake(self.width / 2.0, (self.height - size.height) / 2.0);
    
    CGRect frame = self.msgLabel.frame;
    frame.size = size;
    
    frame.origin.y = self.actView.bottom;
    self.msgLabel.frame = frame;
}

#pragma mark- property

- (void)setMsg:(NSString *)msg
{
    _msgLabel.text = msg;
    [self setNeedsLayout];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.actView.center = CGPointMake(self.width / 2.0, self.height / 2.0);
}

- (void)setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    
    if(self.hidden)
    {
        [self.actView stopAnimating];
    }
    else
    {
        [self.actView startAnimating];
    }
}
@end
