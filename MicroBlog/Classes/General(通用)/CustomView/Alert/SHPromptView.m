//
//  SHPromtView.m
//  MicroBlog
//
//  Created by RenSihao on 16/4/6.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHPromptView.h"

//间距
#define _margin_ 5.0

#define _alertCornerRadius_ 8
#define _alertBackgroundColor_ [UIColor colorWithWhite:0 alpha:0.6]

@implementation SHPromptView

- (instancetype)initWithFrame:(CGRect)frame message:(NSString*)aMessage
{
    if(self = [super initWithFrame:frame])
    {
        self.removeFromSuperViewAfterHidden = NO;
        self.backgroundColor = _alertBackgroundColor_;
        self.layer.cornerRadius = _alertCornerRadius_;
        self.layer.masksToBounds = YES;
        
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, _margin_, _margin_)];
        [_messageLabel setTextAlignment:NSTextAlignmentCenter];
        _messageLabel.font = [UIFont fontWithName:MainFontName size:16.0];
        _messageLabel.numberOfLines = 0;
        _messageLabel.text = aMessage;
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.textColor = [UIColor whiteColor];
        [self addSubview:_messageLabel];
        
        _isAnimating = NO;
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _messageLabel.frame = CGRectInset(self.bounds, _margin_, _margin_);
}

- (void)dealloc
{
    
}

- (void)showAndHideDelay:(NSTimeInterval)delay
{
    [self canPerformAction:@selector(alertViewHidden) withSender:self];
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        self.hidden = NO;
        
        [self performSelector:@selector(alertViewHidden) withObject:nil afterDelay:delay];
    });
}

//提示框隐藏
- (void)alertViewHidden
{
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        _isAnimating = NO;
        self.hidden = YES;
        if(self.removeFromSuperViewAfterHidden)
        {
            [self removeFromSuperview];
        }
    });
}
@end
