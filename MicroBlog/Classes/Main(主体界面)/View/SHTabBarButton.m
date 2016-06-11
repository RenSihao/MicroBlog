//
//  SHTabBarButton.m
//  MicroBlog
//
//  Created by RenSihao on 15/11/4.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "SHTabBarButton.h"
#import "SHBadgeView.h"

@interface SHTabBarButton ()

@property (nonatomic, strong) SHBadgeView *badgeView;
@end


@implementation SHTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //设置图片位置居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        //设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        
        //设置文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //设置文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
    }
    return self;
}

//对外提供接口
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    //设置小红点的值
    self.badgeView.badgeValue = _item.badgeValue;
    
    // KVO，注册添加观察者，监听一个对象的属性有没有改变
    // 给谁添加观察者
    // Observer:按钮
    [_item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"selImage" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil]; 
}
/**
 监听到某个对象的属性改变了，自动调用此方法
 @prama KeyPath 属性名
 @prama object  哪个对象属性被改变
 @prama change  属性发生的改变
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    //小红点赋值
    self.badgeView.badgeValue = _item.badgeValue;
    
    //设置文字
    [self setTitle:_item.title forState:UIControlStateNormal];
    
    //设置图片
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
}
//移除观察者
- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"title"];
    [self removeObserver:self forKeyPath:@"image"];
    [self removeObserver:self forKeyPath:@"selImage"];
    [self removeObserver:self forKeyPath:@"badgeValue"];
}

#pragma mark - 重写内部的一些方法
//重写去掉高亮状态
- (void)setHighlighted:(BOOL)highlighted
{}
//重写内部图片frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * 0.8;
    return CGRectMake(0, 0, imageW, imageH);
}
//重写内部文字frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * 0.8 - 5;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}


#pragma mark - lazyload
- (SHBadgeView *)badgeView
{
    if(!_badgeView)
    {
        _badgeView = [SHBadgeView buttonWithType:UIButtonTypeCustom];
        //设置x y
        _badgeView.x = self.width - _badgeView.width - 10;
        _badgeView.y = 0;
        [self addSubview:_badgeView];
    }
    return _badgeView;
}



























@end
