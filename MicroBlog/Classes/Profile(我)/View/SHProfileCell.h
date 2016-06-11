//
//  SHProfileCell.h
//  MicroBlog
//
//  Created by RenSihao on 16/2/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHProfileCellModel;
@interface SHProfileCell : UITableViewCell

+ (CGFloat)cellHeight;
- (void)updateWithProfileCellModel:(SHProfileCellModel *)model;
@end
