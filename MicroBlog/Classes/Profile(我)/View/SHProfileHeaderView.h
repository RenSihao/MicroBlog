//
//  SHProfileHeaderView.h
//  MicroBlog
//
//  Created by RenSihao on 16/2/17.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ProfileBlogType) {
    
    ProfileBlog,
    ProfileFocus,
    ProfileFans
};

@class SHProfileHeaderView;
@class SHUserModel;

@protocol SHProfileHeaderViewDelegate <NSObject>


@end

/************* 个人信息 **********************/
@interface SHProfileHeaderView : UITableViewCell

@property (nonatomic, weak) id<SHProfileHeaderViewDelegate> delegate;

- (void)configureProfileHeaderViewWithUserModel:(SHUserModel *)model;
@end

@class SHProfileBlogCountView;

@protocol SHProfileBlogCountViewDelegate <NSObject>

- (void)profileCountView:(SHProfileBlogCountView *)view didClickItem:(NSInteger)index;
@end

/************* 微博 关注 粉丝 ****************/
@interface SHProfileBlogCountView : UITableViewCell

@property (nonatomic, weak) id<SHProfileBlogCountViewDelegate> delegate;

- (void)configureProfileBlogCountViewWithUserModel:(SHUserModel *)model;
@end

