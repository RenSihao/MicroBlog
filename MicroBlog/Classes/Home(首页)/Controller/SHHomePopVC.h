//
//  SHHomePopViewController.h
//  MicroBlog
//
//  Created by RenSihao on 16/1/4.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PopViewType){
    PopViewTypeGroup, //好友分组
    PopViewTypeRadar  //雷达、扫一扫
    
};

@protocol SHHomePopViewDelegate <NSObject>

- (void)didSelectGroup:(NSString *)group;

@end

@interface SHHomePopVC : UITableViewController

@property (nonatomic, assign) PopViewType type;
@property (nonatomic, weak) id<SHHomePopViewDelegate> delegate;
- (instancetype)initWithPopViewType:(PopViewType)type;
@end
