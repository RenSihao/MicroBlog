//
//  SHTitleButton.m
//  MicroBlog
//
//  Created by RenSihao on 16/1/4.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHTitleButton.h"

@implementation SHTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //设置字体
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont fontWithName:kDefaultBoldFontFamilyName size:17.f]];
        
        //设置背景色
        [self setBackgroundImage:[UIImage imageWithStrechableName:@"navigationbar_button_background"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithStrechableName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //无图模式 直接返回
    if (self.currentImage == nil)
        return ;
    
    //有图模式 文字在左 图片在右 (UIButton默认是 图片在左 文字在右)
    //title
    self.titleLabel.x = self.imageView.x;
    //image
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}



@end
