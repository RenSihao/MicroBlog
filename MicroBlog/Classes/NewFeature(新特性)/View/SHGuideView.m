//
//  SHGuideView.m
//  MicroBlog
//
//  Created by RenSihao on 16/3/18.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHGuideView.h"

@interface SHGuideView ()

@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation SHGuideView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-24);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(10);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
}
- (SHGuideScrollView *)scrollView
{
    if(!_scrollView)
    {
        _scrollView = [[SHGuideScrollView alloc] initWithFrame:self.frame];
        
        weakSelf(self);
        [_scrollView setPageControlBlock:^(NSInteger index){
            weakSelf.pageControl.currentPage = index;
        }];
    }
    return _scrollView;
}
- (UIPageControl *)pageControl
{
    if (!_pageControl)
    {
        _pageControl = [UIPageControl new];
        _pageControl.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds) * 0.5 , 30);
        _pageControl.center = CGPointMake(CGRectGetMidX(self.bounds),
                                          CGRectGetMaxY(self.bounds) - CGRectGetMidY(_pageControl.bounds));
        _pageControl.numberOfPages = 4;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

@end


// ////////////////////////////////////////////////////////

@interface SHGuideScrollView () <UIScrollViewDelegate>

@property (nonatomic, copy) NSArray *imagesNameArray; //图片名字数组
@property (nonatomic, strong) NSMutableArray *imageView; //用于存放一组播放的图片视图
@end

@implementation SHGuideScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        if(WINDOW_3_5_INCH) {
            _imagesNameArray = @[@"new_feature_1", @"new_feature_2", @"new_feature_3", @"new_feature_4"];
        }
        else if(WINDOW_4_INCH) {
            _imagesNameArray = @[@"new_feature_1", @"new_feature_2", @"new_feature_3", @"new_feature_4"];
        }
        else if (WINDOW_4_7_INCH) {
            _imagesNameArray = @[@"new_feature_1", @"new_feature_2", @"new_feature_3", @"new_feature_4"];
        }
        else if (WINDOW_5_5_INCH) {
            _imagesNameArray = @[@"new_feature_1", @"new_feature_2", @"new_feature_3", @"new_feature_4"];
        }
        
        [self config];
        [self addImagesToScrollView];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
/**
 *  默认配置
 */
- (void)config
{
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = NO;
    self.userInteractionEnabled = YES;
    self.contentSize = CGSizeMake(self.imagesNameArray.count * self.bounds.size.width, self.bounds.size.height);
    self.pagingEnabled = YES;
    self.contentOffset = CGPointMake(0, 0);
}

/**
 *  分别添加图片到 scrollView 上
 */
- (void)addImagesToScrollView {
    
    for ( NSUInteger i = 0; i < _imagesNameArray.count; i++ ) {
        
        //逐个添加图片视图
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [imageView setFrame:CGRectMake(i*self.bounds.size.width,
                                       0,
                                       self.bounds.size.width,
                                       self.bounds.size.height)];
        
        [imageView setImage:[UIImage imageNamed:_imagesNameArray[i]]];
        
        [self.imageView addObject:imageView];
        
        [self addSubview:imageView];
        
        //最后一张 添加 "进入按钮"
        if (i == _imagesNameArray.count - 1) {
            
            UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            if (WINDOW_4_7_INCH || WINDOW_5_5_INCH)
            {
                goBtn.frame = CGRectMake(i*self.bounds.size.width + 50,
                                         self.bounds.size.height - 24 - 10 - 88,
                                         self.bounds.size.width - 50*2,
                                         44);
                [goBtn.titleLabel setFont:[UIFont systemFontOfSize:25.f]];
            }
            else if (WINDOW_4_INCH)
            {
                goBtn.frame = CGRectMake(i*self.bounds.size.width + 50,
                                         self.bounds.size.height - 24 - 10 - 64,
                                         self.bounds.size.width - 50*2,
                                         44);
                [goBtn.titleLabel setFont:[UIFont systemFontOfSize:23.f]];
            }
            else if (WINDOW_3_5_INCH)
            {
                goBtn.frame = CGRectMake(i*self.bounds.size.width + 100,
                                         self.bounds.size.height - 24 - 10 - 32,
                                         self.bounds.size.width - 100*2,
                                         22);
                [goBtn.titleLabel setFont:[UIFont systemFontOfSize:17.f]];
            }
            
            goBtn.backgroundColor = kColorBgMain;
            [goBtn.layer setCornerRadius:2.f];
            [goBtn.layer setMasksToBounds:YES];
            [goBtn setTitle:@"开始体验吧" forState:UIControlStateNormal];
            [goBtn setTitleColor:UIColorFromRGB_0x(0xff613c) forState:UIControlStateNormal];
            
            [goBtn addTarget:self action:@selector(goBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:goBtn];
        }
        
    }
}
/**
 *  点击进入
 */
- (void)goBtnDidClick:(UIButton *)sender
{
    [self.superview removeFromSuperview];
    //回调 完成引导
    if(self.guideCompleteBlock)
    {
        self.guideCompleteBlock(YES);
    }
}

#pragma marks - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = self.contentOffset.x / self.bounds.size.width;
    if(self.pageControlBlock)
    {
        self.pageControlBlock(page);
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{    
    
}

@end
