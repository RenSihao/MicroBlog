//
//  SHTabBar.m
//  MicroBlog
//
//  Created by RenSihao on 15/11/4.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "SHTabBar.h"
#import "SHTabBarButton.h"

@interface SHTabBar ()

@property (nonatomic, strong) NSMutableArray *tabBarButtons; //所有的按钮
@property (nonatomic, strong) UIButton *specialButton; //中间特殊的加号按钮
@property (nonatomic, strong) UIButton *selectButton; //当前被选中的按钮
@end


@implementation SHTabBar

- (void)setItems:(NSArray *)items
{
    _items = items;
    //遍历模型数组，创建对应按钮
    for(UITabBarItem *item in _items)
    {
        SHTabBarButton *tabBarButton = [SHTabBarButton buttonWithType:UIButtonTypeCustom];
        
        //设置item
        tabBarButton.item = item;
        
        //设置tag并添加响应事件
        tabBarButton.tag = self.tabBarButtons.count;
        [tabBarButton addTarget:self action:@selector(DidClickTabBarButton:) forControlEvents:UIControlEventTouchUpInside];
        
        //默认打开首页
        if(tabBarButton.tag == 0)
            [self DidClickTabBarButton:tabBarButton];
        
        //添加
        [self addSubview:tabBarButton];
        [self.tabBarButtons addObject:tabBarButton];
    }
}

//子控件被添加时，系统自动调用
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSLog(@"%s", __func__);
    
    //设置内部按钮frame
    [self setTabBarButtonsFrame];
    
    //设置特殊按钮frame
    [self setSpecialButtonFrame];
}

- (void)setTabBarButtonsFrame
{
    NSInteger count = self.tabBarButtons.count + 1;
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    NSInteger i = 0;
    for(UIView *tabBarButton in self.tabBarButtons)
    {
        //设置到第三个的时候，统一往后移动一个按钮的距离，留出特殊加号按钮的位置
        if(i == 2)
        {
            i = 3;
        }
        tabBarButton.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
        i ++;
    }
}
- (void)setSpecialButtonFrame
{
    CGFloat centerX = self.width * 0.5;
    CGFloat centerY = self.height * 0.5;
    self.specialButton.center = CGPointMake(centerX, centerY);
}

#pragma mark - lazyload
- (NSMutableArray *)tabBarButtons
{
    if(!_tabBarButtons)
    {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}
- (UIButton *)specialButton
{
    if(!_specialButton)
    {
        _specialButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_specialButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_specialButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [_specialButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [_specialButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        //默认将此按钮大小设置为根据背景图片或者文字的尺寸最合适大小
        [_specialButton sizeToFit];
        
        
        [_specialButton addTarget:self action:@selector(DidClickAddButton) forControlEvents:UIControlEventTouchUpInside];
        
        //如果声明属性是weak，这句话可以强引用它
        [self addSubview:_specialButton];
        
    }
    return _specialButton;
}


#pragma mark - SHTabBarDelegate
//监听加号按钮点击
- (void)DidClickAddButton
{
    NSLog(@"%s", __func__);
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickAddButton:)])
    {
        [self.delegate tabBarDidClickAddButton:self];
    }
}
//监听非加号按钮点击
- (void)DidClickTabBarButton:(UIButton *)sender
{
    NSLog(@"%ld", sender.tag);
    _selectButton.selected = NO;
    sender.selected = YES;
    _selectButton = sender;
    
    //通知代理
    if([self.delegate respondsToSelector:@selector(tabBar:didClickItem:)])
    {
        [self.delegate tabBar:self didClickItem:sender.tag];
    }
    
}


@end
