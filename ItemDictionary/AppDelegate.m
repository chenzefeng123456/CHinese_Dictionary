//
//  AppDelegate.m
//  ItemDictionary
//
//  Created by 3014 on 16/7/18.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <iflyMSC/IFlySpeechUtility.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
   
    ViewController *view = [ViewController new];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:view];
    self.window.rootViewController = navigation;
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"5796be53"];
    [IFlySpeechUtility createUtility:initString];
   
    
    [ShareSDK registerApp:@"158b47bff9cec" activePlatforms:@[ @(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType)
    {
        switch (platformType)
        {
                case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
                       default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType)
        {
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:@"2418170187"
                                          appSecret:@"1ce1b1f659b91ccbeb5c31119cfec3c4"
                                        redirectUri:@"http://www.sharesdk.cn"
                                           authType:SSDKAuthTypeBoth];
                break;
                                          default:
                break;
        }
        }];
    
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

@end
