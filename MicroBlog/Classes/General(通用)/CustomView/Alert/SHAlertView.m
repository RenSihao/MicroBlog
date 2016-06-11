//
//  SHAlertView.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/6.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHAlertView.h"

#define SHAlertViewButtonStartTag 1200

@interface SHAlertView ()

//内容
@property(nonatomic,strong) UIView *contentView;

//内容目标frame
@property(nonatomic,assign) CGRect targetFrame;

//黑色背景
@property(nonatomic,strong) UIView *backgroundView;

//标题
@property(nonatomic,strong) UILabel *titleLabel;

@end

@implementation SHAlertView

#pragma mark - init

- (id)initWithTitle:(NSString*) title otherButtonTitles:(NSArray*) otherButtonTitles
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if(self)
    {
        _buttonCount = (NSInteger)otherButtonTitles.count;
        _destructiveButtonIndex = NSNotFound;
        
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _backgroundView.alpha = 0;
        [self addSubview:_backgroundView];
        
        CGFloat textMargin = 10.0;
        CGFloat contentWidth = 230.0;
        CGFloat topMargin = 20.0;
        
        UIFont *font = [UIFont fontWithName:MainFontName size:MainFontSize46];
        CGSize size = [title stringSizeWithFont:font contraintWith:contentWidth - textMargin * 2];
        
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(textMargin, topMargin, contentWidth - textMargin * 2, size.height)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.text = title;
        
        if(size.height > 20.0)
        {
            topMargin = 10.0;
            _titleLabel.top = topMargin;
            _titleLabel.textAlignment = NSTextAlignmentLeft;
        }
        _titleLabel.textColor = MainDeepGrayColor;
        _titleLabel.font = font;
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/ 2.0, SCREEN_HEIGHT / 2.0, 1.0, 1.0)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 5.0;
        _contentView.layer.masksToBounds = YES;
        _contentView.clipsToBounds = YES;
        [self addSubview:_contentView];
        
        CGFloat buttonHeight = 40.0;
        CGFloat lineWidth = kSeparatorLineWidth;
        
        [_contentView addSubview:_titleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(textMargin, _titleLabel.bottom + topMargin - kSeparatorLineWidth, contentWidth - textMargin * 2, kSeparatorLineWidth)];
        line.backgroundColor = kSeparatorLineColor;
        [_contentView addSubview:line];
        
        if(otherButtonTitles.count > 2)
        {
            CGFloat buttonWidth = contentWidth;
            for(int i = 0;i < otherButtonTitles.count;i ++)
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.tag = SHAlertViewButtonStartTag + i;
                btn.frame = CGRectMake(0 , _titleLabel.bottom + (buttonHeight + lineWidth) * i, buttonWidth, buttonHeight);
                [btn addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitle:[otherButtonTitles objectAtIndex:i] forState:UIControlStateNormal];
                [btn setTitleColor:_titleLabel.textColor forState:UIControlStateNormal];
                btn.titleLabel.font = _titleLabel.font;
                [_contentView addSubview:btn];
                
                if(i != otherButtonTitles.count - 1)
                {
                    line = [[UIView alloc] initWithFrame:CGRectMake(textMargin, btn.bottom, contentWidth - textMargin * 2, lineWidth)];
                    line.backgroundColor = kSeparatorLineColor;
                    
                    [_contentView addSubview:line];
                }
            }
            
            buttonHeight *= otherButtonTitles.count;
        }
        else
        {
            CGFloat buttonWidth = (contentWidth - lineWidth * (otherButtonTitles.count - 1)) / otherButtonTitles.count;
            for(int i = 0;i < otherButtonTitles.count;i ++)
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.tag = SHAlertViewButtonStartTag + i;
                btn.frame = CGRectMake((buttonWidth + lineWidth) * i, _titleLabel.bottom + topMargin, buttonWidth, buttonHeight);
                [btn addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
                [btn setTitle:[otherButtonTitles objectAtIndex:i] forState:UIControlStateNormal];
                [btn setTitleColor:_titleLabel.textColor forState:UIControlStateNormal];
                btn.titleLabel.font = _titleLabel.font;
                [_contentView addSubview:btn];
                
                if(i != otherButtonTitles.count - 1)
                {
                    line = [[UIView alloc] initWithFrame:CGRectMake(btn.right, btn.top + 10.0, lineWidth, buttonHeight - 10.0 * 2)];
                    line.backgroundColor = kSeparatorLineColor;
                    
                    [_contentView addSubview:line];
                }
            }
        }
        
        CGFloat margin = (SCREEN_WIDTH - contentWidth) / 2.0;
        CGFloat height = topMargin + _titleLabel.height + topMargin + buttonHeight;
        self.targetFrame = CGRectMake(margin, (SCREEN_HEIGHT - height) / 2.0, contentWidth, height);
    }
    
    return self;
}

#pragma mark- public method

- (void)setDestructiveButtonIndex:(NSInteger)destructiveButtonIndex
{
    if(_destructiveButtonIndex != destructiveButtonIndex)
    {
        [self setButtonTitleColor:MainDeepGrayColor forIndex:_destructiveButtonIndex];
        _destructiveButtonIndex = destructiveButtonIndex;
        [self setButtonTitleColor:kColorAppMain forIndex:_destructiveButtonIndex];
    }
}


- (void)setButtonTitleColor:(UIColor*)color forIndex:(NSInteger)index
{
    UIButton *btn = [self buttonForIndex:index];
    [btn setTitleColor:color forState:UIControlStateNormal];
}

-(void)setbuttontitleFont:(UIFont*)font forIndex:(NSInteger)index
{
    UIButton * btn = [self buttonForIndex:index];
    btn.titleLabel.font = font;
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:kAnimationDuration animations:^(void){
        
        self.backgroundView.alpha = 1.0;
        self.contentView.frame = self.targetFrame;
    }];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

#pragma mark- private method

- (UIButton*)buttonForIndex:(NSInteger) index
{
    return (UIButton*)[self.contentView viewWithTag:SHAlertViewButtonStartTag + index];
}

- (void)buttonDidClick:(UIButton*) btn
{
    //delegate 方式
    if([self.delegate respondsToSelector:@selector(alertView:didClickAtIndex:)])
    {
        [self.delegate alertView:self didClickAtIndex:btn.tag - SHAlertViewButtonStartTag];
    }
    
    //只有确定和取消
    if (_buttonCount == 2)
    {
        //点击确定
        if ((btn.tag - SHAlertViewButtonStartTag) == 1 && self.didClickOKBlock)
        {
            self.didClickOKBlock(YES);
        }
    }
    
    //只有确定
    if (_buttonCount == 1)
    {
        //点击确定
        if ((btn.tag - SHAlertViewButtonStartTag) == 0 && self.didClickOKBlock)
        {
            self.didClickOKBlock(YES);
        }
    }
    
    
    [self dismiss];
}

@end
