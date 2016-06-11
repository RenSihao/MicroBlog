//
//  SHTabBarController.m
//  MicroBlog
//
//  Created by RenSihao on 15/11/4.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "SHTabBarController.h"
#import "SHHomeVC.h"
#import "SHMessageVC.h"
#import "SHDiscoverVC.h"
#import "SHProfileVC.h"
#import "SHTabBar.h"
#import "SHGuideView.h"
#import "SHPostWeiboVC.h"

static NSString * const kVersionToShowGuideView = @"1.0";

@interface SHTabBarController () <SHTabBarDelegate>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) SHTabBar *customTabBar;
@end

@implementation SHTabBarController

//APP程序启动立即加载（优先级高于main函数）
+ (void)load
{
    NSLog(@"%s", __func__);
}
//当这个类或者子类第一次使用，调用此方法，作用是初始化本类(优先级低于main，类跟对象一样都需要初始化)
+ (void)initialize
{
    NSLog(@"%s", __func__);
    UITabBarItem *item  = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    //通过富文本设置字体属性
    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
    attri[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:attri forState:UIControlStateSelected];
}

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNotifications];
    
    if ([self checkVersionNeedGuide])
    {
        [self initGuideView];
    }
    else
    {
        [self enterApp];
    }
}
- (void)dealloc
{
    [self removeNotifications];
}

#pragma mark - private method

/**
 *  是否需要引导页
 */
- (BOOL)checkVersionNeedGuide
{
    NSString *versionToShowGuideView = [[NSUserDefaults standardUserDefaults] objectForKey:@"appVersion"];
    if(versionToShowGuideView == nil || ![versionToShowGuideView isEqualToString:kVersionToShowGuideView])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
/**
 *  加载引导页
 */
- (void)initGuideView
{
    SHGuideView *guideView = [[SHGuideView alloc] initWithFrame:self.view.bounds];
    weakSelf(self);
    [guideView.scrollView setGuideCompleteBlock:^(BOOL isOk){
        
        if(isOk)
        {
            [[NSUserDefaults standardUserDefaults] setObject:kVersionToShowGuideView forKey:@"appVersion"];
            [[NSUserDefaults standardUserDefaults] synchronize];
         
            [weakSelf enterApp];
        }
    }];
    [self.view addSubview:guideView];
}
/**
 *  进入APP
 */
- (void)enterApp
{
    if ([UserManager shareInstance].isAutoLogin)
    {
        if ([UserManager shareInstance].isTokenExpired)
        {
            //过期就更新token
            [[UserManager shareInstance] updateAccessToken];
        }
        else
        {
            [self initMain];
        }
    }
    else
    {
        //此处应该去授权登录 但是有问题...
//        [self initMain];
//        [[UserManager shareInstance] updateAccessToken];
        [[UserManager shareInstance] requestSSOLogin];
    }
}
/**
 *  初始化并加载主界面
 */
- (void)initMain
{
    //1、子控制器群
    [self addAllChildControllers];
    
    //2、自定义tabbar
    [self initTabBar];
}
- (void)initTabBar
{
    [self.tabBar addSubview:self.customTabBar];
}

/**
 添加子控制器群组
 */
- (void)addAllChildControllers
{
    //1、首页
    SHHomeVC *homeVC = [[SHHomeVC alloc] init];
    [self initWithViewController:homeVC norImage:[UIImage imageNamed:@"tabbar_home"] selImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页" tag:SHTabTagHome];
    
    
    //2、消息
    SHMessageVC *messageVC = [[SHMessageVC alloc] init];
    [self initWithViewController:messageVC norImage:[UIImage imageNamed:@"tabbar_message_center"] selImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息" tag:SHTabTagMessage];
    
    
    //3、+
//    [self initWithViewController:nil norImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] selImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] title:@"ss" tag:SHTabTagAdd];
    
    //4、发现
    SHDiscoverVC *discoverVC = [[SHDiscoverVC alloc] init];
    [self initWithViewController:discoverVC norImage:[UIImage imageNamed:@"tabbar_discover"] selImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现" tag:SHTabTagDiscover];
    
    
    //5、我
    SHProfileVC *profileVC = [[SHProfileVC alloc] init];
    [self initWithViewController:profileVC norImage:[UIImage imageNamed:@"tabbar_profile"] selImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我" tag:SHTabTagProfile];
    
    //设置tabBaritem 字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kColorTabBarSelItem, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}

/**
 *  初始化单个控制器的属性
 *
 *  @param vc       视图控制器
 *  @param image    正常图片
 *  @param selImage 被选中后图片
 *  @param title    title
 */
- (void)initWithViewController:(UIViewController *)vc
                      norImage:(UIImage *)image
                      selImage:(UIImage *)selImage
                         title:(NSString *)title
                           tag:(SHTabTag)tag
{
    
    
//    vc.tabBarItem = [UITabBarItem tabBarItemWithTitle:title normalName:image selectedName:selImage tag:tag];

    vc.title = title;
    
    //设置item属性
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selImage;
    
    //把tabBarItem模型保存到数组
    [self.items addObject:vc.tabBarItem];
   
    //给控制器包装导航控制器
    GestureNavController *NC = [[GestureNavController alloc] initWithRootViewController:vc];
    
    //给TabBarController添加子控制器
    [self addChildViewController:NC];
}

#pragma mark -  lazyload

- (NSMutableArray *)items
{
    if(!_items)
    {
        _items = [NSMutableArray array];
    }
    return _items;
}
- (SHTabBar *)customTabBar
{
    if(!_customTabBar)
    {
        _customTabBar = [[SHTabBar alloc] initWithFrame:self.tabBar.frame];
        _customTabBar.backgroundColor = [UIColor whiteColor];
        _customTabBar.delegate = self;
        
        CGRect frame = _customTabBar.frame;
        frame.origin.y = 0;
        
        _customTabBar.frame = frame;
        
        //给tabBar添加item模型数组
        _customTabBar.items = self.items;
    }
    return _customTabBar;
}

#pragma mark - SHTabBarDelegate

- (void)tabBar:(SHTabBar *)tabBar didClickItem:(NSInteger)index
{
    self.selectedIndex = index;
}
- (void)tabBarDidClickAddButton:(SHTabBar *)tabBar
{
    BHBItem * item0 = [[BHBItem alloc]initWithTitle:@"文字" Icon:@"images.bundle/tabbar_compose_idea"];
    BHBItem * item1 = [[BHBItem alloc]initWithTitle:@"照片/视频" Icon:@"images.bundle/tabbar_compose_photo"];
    BHBItem * item2 = [[BHBItem alloc]initWithTitle:@"头条文章" Icon:@"images.bundle/tabbar_compose_headlines"];
    BHBItem * item3 = [[BHBItem alloc]initWithTitle:@"签到" Icon:@"images.bundle/tabbar_compose_lbs"];
    BHBItem * item4 = [[BHBItem alloc]initWithTitle:@"点评" Icon:@"images.bundle/tabbar_compose_review"];
    BHBItem * item5 = [[BHBItem alloc]initWithTitle:@"更多" Icon:@"images.bundle/tabbar_compose_more"];
    //第六个按钮是more按钮
    item5.isMore = YES;
    BHBItem * item6 = [[BHBItem alloc]initWithTitle:@"好友圈" Icon:@"images.bundle/tabbar_compose_friend"];
    BHBItem * item7 = [[BHBItem alloc]initWithTitle:@"微博相机" Icon:@"images.bundle/tabbar_compose_wbcamera"];
    BHBItem * item8 = [[BHBItem alloc]initWithTitle:@"音乐" Icon:@"images.bundle/tabbar_compose_music"];
    BHBItem * item9 = [[BHBItem alloc]initWithTitle:@"红包" Icon:@"images.bundle/tabbar_compose_envelope@2x"];
    BHBItem * item10 = [[BHBItem alloc]initWithTitle:@"商品" Icon:@"images.bundle/tabbar_compose_productrelease"];
    
    //添加popview
    [BHBPopView showToView:self.view withItems:@[item0,item1,item2,item3,item4,item5,item6,item7,item8,item9,item10]andSelectBlock:^(BHBItem *item, NSInteger index) {
        NSLog(@"%ld,选中%@",index,item.title);
        if (index == 0)
        {
            SHPostWeiboVC *postVC = [[SHPostWeiboVC alloc] initWithStyle:UITableViewStylePlain];
            [self presentViewController:postVC animated:YES completion:nil];
        }
    }];
    
}

#pragma mark - 通知相关
/**
 *  添加通知
 */
- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotifacationNeedLogin:) name:kNotificationNeedLogin object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotifacationDidLogin:) name:kNotificationDidLogin object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotificationLogout:) name:kNotificationDidLogout object:nil];
}
/**
 *  移除通知
 */
- (void)removeNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  已经登录
 *
 */
- (void)didReceiveNotifacationDidLogin:(NSNotification *)notification
{
    [self initMain];
}
/**
 *  需要登录
 *
 */
- (void)didReceiveNotifacationNeedLogin:(NSNotification *)notification
{
    [[UserManager shareInstance] requestSSOLogin];
}
/**
 *  已经退出登录
 *
 */
- (void)didReceiveNotificationLogout:(NSNotification *)notification
{
    
    //popToRootVC
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController *)obj popToRootViewControllerAnimated:NO];
        }
    }];
    
    //需要登录
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNeedLogin object:nil];
}














@end
