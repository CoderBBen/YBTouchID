//
//  AppDelegate.m
//  YBTouchIDToolDemo
//
//  Created by idbeny on 16/3/11.
//  Copyright © 2016年 https://github.com/idbeny/YBTouchID.git. All rights reserved.
//

#import "AppDelegate.h"
#import "WebViewController.h"
#import "YBTouchIDTool.h"

@interface AppDelegate ()

@property (nonatomic, strong) YBTouchIDTool *touchIDTool;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.touchIDTool = [YBTouchIDTool sharedInstance];
    [self.touchIDTool show];
    
    [self setRootViewController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

//rootViewController for window
- (void)setRootViewController {
    WebViewController *webVC = [WebViewController new];
    UINavigationController *webNav = [[UINavigationController alloc] initWithRootViewController:webVC];
    self.window.rootViewController = webNav;
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
    [self.touchIDTool show];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
