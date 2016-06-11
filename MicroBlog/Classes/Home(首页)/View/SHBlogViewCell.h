//
//  SHBlogViewCell.h
//  MicroBlog
//
//  Created by RenSihao on 16/2/24.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHBlogDetailModel;
@class SHStatusModel;

typedef NS_ENUM(NSUInteger, BlogType){
    
    BlogTypeText,
    BlogTypePicture,
    BlogTypeVideo,
};

@protocol SHBlogViewCellDelegate <NSObject>

- (void)didClickFunctionBtn:(UIButton *)functionBtn info:(SHStatusModel *)model;
@end


@interface SHBlogViewCell : UITableViewCell


@property (nonatomic, weak) id<SHBlogViewCellDelegate> delegate;
@property (nonatomic, strong) SHStatusModel *model;

@end
