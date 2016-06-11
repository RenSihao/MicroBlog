//
//  SHBadgeView.m
//  MicroBlog
//
//  Created by RenSihao on 15/11/4.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "SHBadgeView.h"

@implementation SHBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //设置背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        //设置字
        self.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        
        //设置自身尺寸
        [self sizeToFit];
        
        //设置交互为NO
        self.userInteractionEnabled = NO;
        
    }
    return self;
}
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    
    if(badgeValue == nil || [badgeValue isEqualToString:@""] || [badgeValue isEqualToString:@"0"])
    {
        self.hidden = YES;
        return ;
    }
    else
    {
        self.hidden = NO;
    }
    
    //设置字的宽度
    CGFloat titleW = [badgeValue boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0f]} context:nil].size.width;
    
    if (titleW > self.width) { // 文字宽度大于按钮宽度
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
    
    
    
}

@end
