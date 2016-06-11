//
//  SHPhotoContainerView.m
//  MicroBlog
//
//  Created by RenSihao on 16/2/29.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "SHPhotoContainerView.h"

@interface SHPhotoContainerView () <SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imagesArray;
@end


@implementation SHPhotoContainerView

#pragma mark - public method

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addAllSubViews];
    }
    return self;
}
- (void)setPicturesPathStringArray:(NSArray *)picturesPathStringArray
{
    _picturesPathStringArray = picturesPathStringArray;
    
    for(long i=_picturesPathStringArray.count; i<self.imagesArray.count; i++)
    {
        UIImageView *imageView = [self.imagesArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_picturesPathStringArray.count == 0)
    {
        self.hidden = YES;
        self.fixedHeight = @(0);
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:_picturesPathStringArray];
    CGFloat itemH = 0;
    if (_picturesPathStringArray.count == 1)
    {
        UIImage *image = [UIImage imageNamed:_picturesPathStringArray.firstObject];
        if (image.size.width)
        {
            itemH = image.size.height / image.size.width * itemW;
        }
    }
    else
    {
        itemH = itemW;
    }
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picturesPathStringArray];
    CGFloat margin = 10;
    
    [_picturesPathStringArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [self.imagesArray objectAtIndex:idx];
        imageView.hidden = NO;
        
        //本地图片
//        imageView.image = [UIImage imageNamed:obj];
        
        //网络图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj]
                     placeholderImage:[UIImage imageNamed:@"0"]
                            completed:nil];
        
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
    }];
    
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_picturesPathStringArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    self.width = w;
    self.height = h;
    
    self.fixedHeight = @(h);
    self.fixedWith = @(w);
}



#pragma mark - private method

- (void)addAllSubViews
{
    NSMutableArray *tempArray = [NSMutableArray new];
    for (int i=0; i<9; i++)
    {
        UIImageView *imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [imageView addGestureRecognizer:tap];
        [tempArray addObject:imageView];
        [self addSubview:imageView];
    }
    self.imagesArray = [tempArray copy];
}


- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picturesPathStringArray.count;
    browser.delegate = self;
    [browser show];
}
- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1)
    {
        return 120;
    }
    else
    {
        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 100 : 70;
        return w;
    }
}
- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count < 4)
    {
        return array.count;
    }
    else if (array.count <=6)
    {
        return 3;
    }
    else
    {
        return 3;
    }
}

#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.picturesPathStringArray[index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}




@end
