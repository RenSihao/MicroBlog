//
//  SHSearchView.h
//  MicroBlog
//
//  Created by RenSihao on 16/3/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHSearchView;

@protocol SHSearchViewDelegate <NSObject>

- (void)didClickSearchView:(SHSearchView *)searchView;

@end

@interface SHSearchView : UIView

@property (nonatomic, weak) id<SHSearchViewDelegate> delegate;
@end
