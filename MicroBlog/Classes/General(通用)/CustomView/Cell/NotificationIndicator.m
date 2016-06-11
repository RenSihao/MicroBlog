//
//  NotificationIndicator.m
//  MZBook
//
//  Created by ZHXL on 14-6-5.
//
//

#import "NotificationIndicator.h"

@implementation NotificationIndicator
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self customSetup];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self customSetup];
    }
    return self;
}
- (id)init{
    if (self = [super init]) {
        [self customSetup];
    }
    return self;
}
- (void)customSetup{
    self.textColor = [UIColor whiteColor];
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:12.0];
    self.backgroundColor = [UIColor redColor];
    self.layer.cornerRadius = 9.0;
    self.clipsToBounds = YES;
}
- (void)setText:(NSString *)text{
    [super setText:text];
    [self resetSizeWidth:(text.length - 1)*7+18.0];
}
- (void)setCount:(NSInteger)count{
    self.text = [NSString stringWithFormat:@"%ld",count];
}
@end
