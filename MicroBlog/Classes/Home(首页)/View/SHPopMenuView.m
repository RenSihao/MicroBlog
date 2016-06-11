//
//  SHPopMenuView.m
//  MicroBlog
//
//  Created by RenSihao on 16/1/4.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHPopMenuView.h"

@interface SHPopMenuView ()

@property (nonatomic, strong) UIView *contentView;  //外界传入的内容视图

@property (nonatomic, strong) UIView *coverView;  //蒙版（负责监听点击空白）

@property (nonatomic, strong) UIImageView *container;  //容器（用来装入外界传入的内容视图）
@end

@implementation SHPopMenuView

#pragma mark - init

+ (instancetype)popMenuViewWithContentView:(UIView *)contentView
{
    return [[self alloc] initWithContentView:contentView];
}
- (instancetype)initWithContentView:(UIView *)contentView
{
    if (self = [super init])
    {
        _contentView = contentView;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //覆盖表面的一层蒙版
        [self addSubview:self.coverView];
        
        //弹出菜单 拉伸背景图片
        [self addSubview:self.container];
    }
    return self;
}

#pragma mark - public method

+ (void)hide
{
    for (UIView *popMenuView in SHKeyWindow.subviews)
    {
        if ([popMenuView isKindOfClass:[self class]])
        {
            [popMenuView removeFromSuperview];
        }
    }
}

#pragma mark - private method

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - lazy load

- (UIView *)coverView
{
    if (!_coverView)
    {
        _coverView = [[UIView alloc] initWithFrame:SCREEN_BOUNDS];
        _coverView.backgroundColor = [UIColor clearColor];
        _coverView.alpha = 0.2;
        _coverView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickCoverView:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}
- (UIImageView *)container
{
    if (!_container)
    {
        _container = [[UIImageView alloc] init];
        _container.userInteractionEnabled = YES;
    }
    return _container;
}

#pragma mark - 私有方法

- (void)didClickCoverView:(UITapGestureRecognizer *)tap
{
    [self hide];
}

#pragma mark - 公共方法

- (void)showInRect:(CGRect)rect
{
    // 添加菜单整体到窗口身上
    self.frame = SHKeyWindow.bounds;
    [SHKeyWindow addSubview:self];
    
    // 设置容器的frame 将传入视图加载到容器里
    self.container.frame = rect;
    [self.container addSubview:self.contentView];
    
    // 设置容器里面内容的frame
    CGFloat topMargin = 9;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottomMargin = 5;
    
    self.contentView.y = topMargin;
    self.contentView.x = leftMargin;
    self.contentView.width = self.container.width - leftMargin - rightMargin;
    self.contentView.height = self.container.height - topMargin - bottomMargin;
}

- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    if (_dimBackground)
    {
        self.coverView.backgroundColor = [UIColor blackColor];
        self.coverView.alpha = 0.3;
    }
    else {
        self.coverView.backgroundColor = [UIColor clearColor];
        self.coverView.alpha = 1.0;
    }

}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    self.container.image = backgroundImage;
}
- (void)setArrowPosition:(SHPopMenuArrowPositionType)arrowPosition
{
    switch (arrowPosition) {
        case SHPopMenuArrowPositionCenter:
        {
            self.container.image = [UIImage imageWithStrechableName:@"popover_background"];
        }
            break;
        case SHPopMenuArrowPositionLeft:
        {
            self.container.image = [UIImage imageWithStrechableName:@"popover_background_left"];
        }
            break;
        case SHPopMenuArrowPositionRight:
        {
            self.container.image = [UIImage imageWithStrechableName:@"popover_background_right"];
        }
            break;
        default:
            break;
    }
}
- (void)hide
{
    [self removeFromSuperview];
}


@end
