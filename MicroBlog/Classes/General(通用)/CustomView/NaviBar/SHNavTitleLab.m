//
//  SHNavTitleLab.m
//  MicroBlog
//
//  Created by RenSihao on 16/2/24.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHNavTitleLab.h"

@implementation SHNavTitleLab

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *) title{
    self = [super init];
    if (self) {
        // Initialization code
        UIFont *titleFont = [UIFont boldSystemFontOfSize:17.0];
        self.frame = CGRectMake(0, floorf((44-titleFont.lineHeight)*0.5), 120, titleFont.lineHeight);
        self.text = title;
        self.font = titleFont;
        self.textColor = [UIColor blackColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end
