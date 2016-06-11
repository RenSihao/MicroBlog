//
//  NaviBarItem.h
//  MZBook
//
//  Created by hanqing on 14-5-13.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,NaviBarItemType){
    NaviBarItemLeft,
    NaviBarItemRight
};

@interface NaviBarItem : UIBarButtonItem

@property (nonatomic, strong) UIButton *btn;
-(id)initBackItemTarget:(id)target action:(SEL)action;

-(id)initWithType:(NaviBarItemType)type target:(id)target action:(SEL)action;
- (void)setBtnImage:(UIImage *)image forState:(UIControlState)state;
- (void)setBtnTitle:(NSString *)title forState:(UIControlState)state;

@end
