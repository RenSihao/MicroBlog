//
//  SHProfilePageHeadSectionView.h
//  MicroBlog
//
//  Created by RenSihao on 16/4/13.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "BaseTableViewCell.h"

@class SHProfilePageHeadSectionView;

@protocol SHProfilePageHeadSectionViewDelegate <NSObject>

- (void)profileHeadSectionView:(SHProfilePageHeadSectionView *)sectionView didClickIndex:(NSInteger)index;

@end

@interface SHProfilePageHeadSectionView : BaseTableViewCell

@property (nonatomic, weak) id<SHProfilePageHeadSectionViewDelegate> delegate;
@end
