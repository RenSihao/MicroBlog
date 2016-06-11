//
//  UIView+Util.m
//  AdressBook
//
//  Created by XuJiajia on 16/3/26.
//  Copyright © 2016年 mac-025. All rights reserved.
//

#import "UIView+Util.h"

static CGFloat selfEdgeRadius   = 10.f;
static CGFloat selfReliefOffset = 0.5f;
static CGFloat selfAvatorOffset = 1.5f;

@implementation UIView (Util)
- (UIView *)addShadowTanView{
    return [self addShadowTanViewWithInsets:UIEdgeInsetsMake(selfEdgeRadius/2, selfEdgeRadius, selfEdgeRadius/2, selfEdgeRadius)];
}

- (UIView *)addShadowTanViewWithInsets:(UIEdgeInsets)insets{
    UIView *conV = self;
    UIView *view = nil;
    
    UIView *tanV = [[UIView alloc] init];
    tanV.clipsToBounds = YES;
    tanV.backgroundColor = [UIColor whiteColor];
    tanV.layer.cornerRadius = 5;
    view = tanV;
    
    [conV addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(conV).insets(insets);
    }];
    
    [tanV addShadowvWithOffset:selfReliefOffset];
    return tanV;
}

- (UIView *)addAvatorShadowV{
    return [self addShadowvWithOffset:selfAvatorOffset];
}

- (UIView *)addShadowvWithOffset:(CGFloat)offset{
    UIView *conV = self.superview;
    UIView *view = nil;
    
    UIView *shadowView = [[UIView alloc] init];
    shadowView.backgroundColor = [UIColor whiteColor];
    view = shadowView;
    
    CGFloat radius = self.layer.cornerRadius;
    view.layer.cornerRadius = radius;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.33;
    view.layer.shadowOffset = CGSizeMake(0, offset);
    view.layer.shadowRadius = offset;
    
    [conV insertSubview:shadowView belowSubview:self];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    return shadowView;
}

@end
