//
//  AppDelegate.m
//  MicroBlog
//
//  Created by RenSihao on 15/11/4.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "AppDelegate.h"
#import "SHTabBarController.h"

@interface AppDelegate () 

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /* 配置窗口根视图 */
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.tabBarController = [[SHTabBarController alloc] init];
    self.window.rootViewController = self.tabBarController;
    
    /* 初始化网络请求类 */
    [SHNetworkClient updateBaseURL:@"http://penkrapi.shopex.cn/index.php?"];
    [SHNetworkClient enableInterfaceDebug:YES];
    [SHNetworkClient cacheGetRequest:YES shoulCachePost:NO];
    
    /* 注册微博SDK */
    [WeiboSDK registerApp:Weibo_App_Key];
    [WeiboSDK enableDebugMode:YES];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:[UserManager shareInstance]];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:[UserManager shareInstance]];
}

@end


