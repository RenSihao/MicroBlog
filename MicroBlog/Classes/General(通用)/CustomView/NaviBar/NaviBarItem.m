//
//  NaviBarItem.m
//  MZBook
//
//  Created by hanqing on 14-5-13.
//
//

#import "NaviBarItem.h"
#import "UIImage+Tint.h"

#define naviItemWidth 40.f

@implementation NaviBarItem

-(id)initBackItemTarget:(id)target action:(SEL)action{
    self = [super init];
    if (self) {
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(12, 0, naviItemWidth, 44);
//        [_btn setImage:[[UIImage imageNamed:@"Btn_Back.png"] imageWithTintColor:kColorBlueMain] forState:UIControlStateNormal];
//        [_btn setImage:[[UIImage imageNamed:@"Btn_Back.png"] imageWithTintColor:[kColorBlueMain colorWithAlphaComponent:.2f]] forState:UIControlStateHighlighted];
        [_btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self = [self initWithCustomView:_btn];
        
    }
    
    return self;
    
}

-(id)initWithType:(NaviBarItemType)type target:(id)target action:(SEL)action{
    self = [super init];
    if (self) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (type == NaviBarItemLeft) {
            _btn.frame = CGRectMake(12, 0, naviItemWidth, 44);
            _btn.titleLabel.textAlignment = NSTextAlignmentLeft;
            _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;            
        } else if (type == NaviBarItemRight){
            _btn.frame = CGRectMake(0, 0, naviItemWidth, 44);
            _btn.titleLabel.textAlignment = NSTextAlignmentRight;
            _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
        [_btn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
//        [_btn setTitleColor:kColorBlueMain  forState:UIControlStateNormal];
//        [_btn setTitleColor:[kColorBlueMain colorWithAlphaComponent:0.2] forState:UIControlStateHighlighted];
//        [_btn setTitleColor:[kColorBlueMain colorWithAlphaComponent:0.2] forState:UIControlStateDisabled];
        [_btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        self = [self initWithCustomView:_btn];
        
    }
    return self;
}

- (void)setBtnImage:(UIImage *)image forState:(UIControlState)state{
    if (_btn) {
        [_btn setImage:image forState:state];
    }
}

- (void)setBtnTitle:(NSString *)title forState:(UIControlState)state{
    if (_btn) {
        [_btn setTitle:title forState:state];
        CGSize titleSize = [title sizeWithFont:_btn.titleLabel.font constrainedToSize:CGSizeMake(100, _btn.titleLabel.frame.size.height) lineBreakMode:NSLineBreakByTruncatingTail];
        [_btn setFrame:CGRectMake(CGRectGetMinX(_btn.frame), CGRectGetMinY(_btn.frame), titleSize.width, titleSize.height)];
        [_btn setContentEdgeInsets:UIEdgeInsetsMake(5, 0, 0, 0)];
    }
}


@end
