//
//  SegmentTapView.m
//  iOS_Control
//
//  Created by RenSihao on 16/3/24.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SegmentTapView.h"

@interface SegmentTapView ()

/**
 *  标题按钮数组
 */
@property (nonatomic, strong) NSMutableArray *buttonsArray;

/**
 *  底部分割线
 */
@property (nonatomic, strong) UIView *bottomLine;

/**
 *  当前选中按钮
 */
@property (nonatomic, strong) UIButton *selectedButton;

/**
 *  数据源 标题数组
 */
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation SegmentTapView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray
{
    if (self = [super initWithFrame:frame])
    {
        _titleArray = titleArray;
        _buttonsArray = [NSMutableArray array];
        
        //默认属性设置
        _titleFont = [UIFont systemFontOfSize:15.f];
        _titleNormalColor = [UIColor blackColor];
        _titleSelectColor = [UIColor redColor];
        self.backgroundColor = [UIColor whiteColor];
        
        [self addAllSubViews];
    }
    return self;
}

#pragma mark - private method

- (void)addAllSubViews
{
    //添加标题按钮控件
    [self addTitleButtons];
    
    //添加底部分割线
    [self addBottomLine];
}
- (void)addTitleButtons
{
    NSUInteger count = _titleArray.count;
    CGFloat    width = self.frame.size.width / count;
    CGFloat   height = self.frame.size.height - 1;
    
    for (NSUInteger i=0; i<count; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width, 0, width, height);
        button.tag = i;
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:_titleNormalColor forState:UIControlStateNormal];
        [button setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        [button.titleLabel setFont:_titleFont];
        
        //默认选中首个按钮
        if (i == 0)
        {
            button.selected = YES;
            _selectedButton = button;
        }
        
        [button addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [_buttonsArray addObject:button];
        [self addSubview:button];
    }
}
- (void)addBottomLine
{
    NSUInteger count = _titleArray.count;
    CGFloat    width = self.frame.size.width / count;
    CGFloat   height = self.frame.size.height - 1;
    
    _bottomLine = [UIView new];
    _bottomLine.frame = CGRectMake(0, height - 1, width, 3);
    _bottomLine.backgroundColor = [UIColor orangeColor];
    _bottomLine.alpha = 0.5;
    [self addSubview:_bottomLine];
}
- (void)successChangeUIofSelectIndex:(NSInteger)index
{
    //1、改变按钮状态
    for (UIButton *obj in _buttonsArray)
    {
        if (obj.tag == index)
        {
            obj.selected = YES;
            _selectedButton = obj;
        }
        else
        {
            obj.selected = NO;
        }
    }
    
    //2、底部分割线滑动
    [UIView animateWithDuration:0.3f animations:^{
        
        CGRect originFrame = _bottomLine.frame;
        _bottomLine.frame = CGRectMake(originFrame.size.width * index,
                                       originFrame.origin.y,
                                       originFrame.size.width,
                                       originFrame.size.height);
        
    } completion:nil];
}

#pragma mark - setter

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    for (UIButton *button in _buttonsArray)
    {
        [button.titleLabel setFont:_titleFont];
    }
}
- (void)setTitleNormalColor:(UIColor *)titleNormalColor
{
    _titleNormalColor = titleNormalColor;
    for (UIButton *button  in _buttonsArray)
    {
        [button setTitleColor:_titleNormalColor forState:UIControlStateNormal];
    }
}
- (void)setTitleSelectColor:(UIColor *)titleSelectColor
{
    _titleSelectColor = titleSelectColor;
    for (UIButton *button in _buttonsArray)
    {
        [button setTitleColor:_titleSelectColor forState:UIControlStateSelected];
    }
}

#pragma mark - 监听点击事件

/**
 *  标题按钮点击触发
 *
 *  @param sender 
 */
- (void)didClickButton:(UIButton *)sender
{
    if (_selectedButton == sender)
    {
        return ;
    }
    
    //选中按钮tag
    NSInteger index = (NSUInteger)sender.tag;
    
    //1、刷新UI
    [self successChangeUIofSelectIndex:index];
    
    //2、代理回调
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentTapViewDidSelectedIndex:)])
    {
        [self.delegate segmentTapViewDidSelectedIndex:index];;
    }
}

#pragma mark - 外界调用接口

- (void)selectIndex:(NSInteger)index
{
    if (_selectedButton.tag == index)
    {
        return ;
    }
    
    //刷新UI
    [self successChangeUIofSelectIndex:index];
}


@end
