//
//  SHGuideView.h
//  MicroBlog
//
//  Created by RenSihao on 16/3/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  App引导页设置View
 */
@class SHGuideScrollView;

@interface SHGuideView : UIView

@property (nonatomic, strong) SHGuideScrollView *scrollView;
@end


typedef void(^SHGuideCompleteBlock)(BOOL isOK);
typedef void(^SHPageControlBlock)(NSInteger index);

@interface SHGuideScrollView : UIScrollView

@property (nonatomic, copy) SHPageControlBlock pageControlBlock;
@property (nonatomic, copy) SHGuideCompleteBlock guideCompleteBlock;
@end