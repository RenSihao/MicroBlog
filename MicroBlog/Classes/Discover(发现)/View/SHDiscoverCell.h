//
//  SHDiscoverCell.h
//  MicroBlog
//
//  Created by RenSihao on 16/2/17.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHDiscoverCellModel;

@interface SHDiscoverCell : UITableViewCell


+ (CGFloat)cellHeight;
- (void)updateWithDiscoverCellModel:(SHDiscoverCellModel *)model;
@end
