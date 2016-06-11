//
//  SHUnlimitedSlideViewController.m
//  MicroBlog
//
//  Created by RenSihao on 16/2/16.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHUnlimitedSlideViewController.h"

@interface SHUnlimitedSlideViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *leftImageView, *midImageView, *rightImageView; //三个轮播视图
@property (nonatomic, strong) UIScrollView *scrollerView; //整个滚动视图
@property (nonatomic, assign) NSInteger currentIndex; //当前滚动视图的下标
@property (nonatomic, strong) NSMutableArray *dataSource; //轮播视图的数据源
@property (nonatomic, assign) NSInteger scrollerViewWidth, scrollerViewHeight; //滚动视图的宽和高
@property (nonatomic, strong) UIPageControl *pageControl; //滚动下标指示器
@property (nonatomic, strong) NSTimer *timer; //定时器
@end

@implementation SHUnlimitedSlideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //是否实现数据源代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(backDataSourceArray)])
    {
        //是否实现滚动视图尺寸方法
        if ([self.delegate respondsToSelector:@selector(backScrollerViewOfSize)])
        {
            CGSize size = [self.delegate backScrollerViewOfSize];
            self.scrollerViewWidth = size.width;
            self.scrollerViewHeight = size.height;
        }
        
        //配置数据源(一定要先实现这一步，否则程序崩掉)
        self.dataSource = [self.delegate backDataSourceArray];
        
        //配置无限滚动视图属性
        [self configureScrollerView];
        
        //配置单个视图属性
        [self configureImageView];
        
        //是否需要滚动下标指示器
        if (self.hasPageControl)
        {
            [self configurePageControl];
        }
        
        //是否需要定时器
        if (self.isAutoRoll)
        {
            [self configureNSTimer];
        }
        
    }
    else
    {
        NSLog(@"没有设置delegate或者没有实现数据源方法");
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - private method
- (void)configureScrollerView
{
    [self scrollerView];
    [self.view addSubview:self.scrollerView];
}
- (void)configureImageView
{
    [self leftImageView];
    [self midImageView];
    [self rightImageView];
    [self.scrollerView addSubview:self.leftImageView];
    [self.scrollerView addSubview:self.midImageView];
    [self.scrollerView addSubview:self.rightImageView];
}
- (void)configurePageControl
{
    [self pageControl];
    [self.view addSubview:self.pageControl];
}
- (void)configureNSTimer
{
    [self timer];
}

#pragma mark - lazy load

- (UIImageView *)leftImageView
{
    if (!_leftImageView)
    {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrollerViewWidth, self.scrollerViewHeight)];
        _leftImageView.image = [UIImage imageNamed:self.dataSource.lastObject];
    }
    return _leftImageView;
}
- (UIImageView *)midImageView
{
    if (!_midImageView)
    {
        _midImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollerViewWidth, 0, self.scrollerViewWidth, self.scrollerViewHeight)];
        _midImageView.image = [UIImage imageNamed:self.dataSource.firstObject];
    }
    return _midImageView;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView)
    {
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollerViewWidth * 2, 0, self.scrollerViewWidth, self.scrollerViewHeight)];
        _rightImageView.image = [UIImage imageNamed:self.dataSource[1]];
    }
    return _rightImageView;
}
- (UIScrollView *)scrollerView
{
    if (!_scrollerView)
    {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.scrollerViewWidth, self.scrollerViewHeight)];
        _scrollerView.delegate = self;
        _scrollerView.backgroundColor = [UIColor blackColor];
        _scrollerView.contentSize = CGSizeMake(self.scrollerViewWidth * self.dataSource.count, self.scrollerViewHeight);
        _scrollerView.contentOffset = CGPointMake(self.scrollerViewWidth, 0);
        _scrollerView.pagingEnabled = YES;
        _scrollerView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollerView;
}
- (NSInteger)currentIndex
{
    if (!_currentIndex)
    {
        _currentIndex = 0;
    }
    return _currentIndex;
}
- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (NSInteger)scrollerViewWidth
{
    if (!_scrollerViewWidth)
    {
        _scrollerViewWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return _scrollerViewWidth;
}
- (NSInteger)scrollerViewHeight
{
    if (!_scrollerViewHeight)
    {
        _scrollerViewHeight = self.scrollerViewWidth / 16 * 9;
    }
    return _scrollerViewHeight;
}
- (UIPageControl *)pageControl
{
    if (!_pageControl)
    {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.scrollerViewHeight - 20, self.scrollerViewWidth, 20)];
        _pageControl.numberOfPages = self.dataSource.count;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.userInteractionEnabled = YES;
    }
    return _pageControl;
}
- (NSTimer *)timer
{
    if (!_timer)
    {
        _timer = [NSTimer timerWithTimeInterval:3.f target:self selector:@selector(timerToSlide:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

#pragma mark - UIScrollerViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    if (self.dataSource.count != 0)
    {
        if (offset >= 2*self.scrollerViewWidth)
        {
            scrollView.contentOffset = CGPointMake(self.scrollerViewWidth, 0);
            
            self.currentIndex++;
            NSLog(@"%ld", self.currentIndex);
            
            //滚动到最后一张
            if (self.currentIndex == self.dataSource.count -1)
            {
                self.leftImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex - 1]];
                self.midImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource.firstObject];
                self.pageControl.currentPage = self.currentIndex;
                self.currentIndex = -1;
            }
            //只有一张
            else if (self.currentIndex == self.dataSource.count)
            {
                
                self.leftImageView.image = [UIImage imageNamed:self.dataSource.lastObject];
                self.midImageView.image = [UIImage imageNamed:self.dataSource.firstObject];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource[1]];
                self.pageControl.currentPage = 0;
                self.currentIndex = 0;
            }
            else if(self.currentIndex == 0)
            {
                self.leftImageView.image = [UIImage imageNamed:self.dataSource.lastObject];
                self.midImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex+1]];
                self.pageControl.currentPage = self.currentIndex;
            }
            else
            {
                self.leftImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex-1]];
                self.midImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex+1]];
                self.pageControl.currentPage = self.currentIndex;
            }
            
        }
        if (offset <= 0)
        {
            scrollView.contentOffset = CGPointMake(self.scrollerViewWidth, 0);
            self.currentIndex--;
            if (self.currentIndex == -2)
            {
                self.currentIndex = self.dataSource.count-2;
                self.leftImageView.image = [UIImage imageNamed:self.dataSource[self.dataSource.count-1]];
                self.midImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource.lastObject];
                self.pageControl.currentPage = self.currentIndex;
            }
            else if (self.currentIndex == -1)
            {
                self.currentIndex = self.dataSource.count-1;
                self.leftImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex-1]];
                self.midImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource.firstObject];
                self.pageControl.currentPage = self.currentIndex;
            }
            else if (self.currentIndex == 0)
            {
                self.leftImageView.image = [UIImage imageNamed:self.dataSource.lastObject];
                self.midImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex+1]];
                self.pageControl.currentPage = self.currentIndex;
            }
            else
            {
                self.leftImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex-1]];
                self.midImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex+1]];
                self.pageControl.currentPage = self.currentIndex;
            }
            
        }
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

#pragma mark - SHUnlimitedSlideViewControllerDelegate

- (NSInteger)didClickCurrentImageIndex
{
    return self.pageControl.currentPage;
}


#pragma mark - NSTimer

- (void)timerToSlide:(NSTimer *)timer
{
    self.scrollerView.contentOffset = CGPointMake((self.currentIndex+1) * self.scrollerViewWidth, 0);
    
    CGFloat offset = self.scrollerView.contentOffset.x;
    if (self.dataSource.count != 0)
    {
        if (offset >= 2*self.scrollerViewWidth)
        {
            self.scrollerView.contentOffset = CGPointMake(self.scrollerViewWidth, 0);
            
            self.currentIndex++;
            NSLog(@"%ld", self.currentIndex);
            
            //滚动到最后一张
            if (self.currentIndex == self.dataSource.count -1)
            {
                self.leftImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex - 1]];
                self.midImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource.firstObject];
                self.pageControl.currentPage = self.currentIndex;
                self.currentIndex = -1;
            }
            //只有一张
            else if (self.currentIndex == self.dataSource.count)
            {
                
                self.leftImageView.image = [UIImage imageNamed:self.dataSource.lastObject];
                self.midImageView.image = [UIImage imageNamed:self.dataSource.firstObject];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource[1]];
                self.pageControl.currentPage = 0;
                self.currentIndex = 0;
            }
            else if(self.currentIndex == 0)
            {
                self.leftImageView.image = [UIImage imageNamed:self.dataSource.lastObject];
                self.midImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex+1]];
                self.pageControl.currentPage = self.currentIndex;
            }
            else
            {
                self.leftImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex-1]];
                self.midImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex+1]];
                self.pageControl.currentPage = self.currentIndex;
            }
            
        }
        if (offset <= 0)
        {
            self.scrollerView.contentOffset = CGPointMake(self.scrollerViewWidth, 0);
            self.currentIndex--;
            if (self.currentIndex == -2)
            {
                self.currentIndex = self.dataSource.count-2;
                self.leftImageView.image = [UIImage imageNamed:self.dataSource[self.dataSource.count-1]];
                self.midImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource.lastObject];
                self.pageControl.currentPage = self.currentIndex;
            }
            else if (self.currentIndex == -1)
            {
                self.currentIndex = self.dataSource.count-1;
                self.leftImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex-1]];
                self.midImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource.firstObject];
                self.pageControl.currentPage = self.currentIndex;
            }
            else if (self.currentIndex == 0)
            {
                self.leftImageView.image = [UIImage imageNamed:self.dataSource.lastObject];
                self.midImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex+1]];
                self.pageControl.currentPage = self.currentIndex;
            }
            else
            {
                self.leftImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex-1]];
                self.midImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex]];
                self.rightImageView.image = [UIImage imageNamed:self.dataSource[self.currentIndex+1]];
                self.pageControl.currentPage = self.currentIndex;
            }
            
        }
    }

}
- (void)stopTimer
{
    [self.timer invalidate];
}
- (void)startTimer
{
    self.timer = nil;
    [self timer];
}



@end
