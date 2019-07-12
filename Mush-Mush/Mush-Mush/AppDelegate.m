//
//  AppDelegate.m
//  Mush-Mush
//
//  Created by Tatyana Shut on 12.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"
#import "HistoryViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UINavigationBar appearance].shadowImage = [[UIImage alloc]init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MapViewController *mapVc = [[MapViewController alloc] init];
    UINavigationController *mapNc = [[UINavigationController alloc] initWithRootViewController:mapVc];
    
    HistoryViewController *historyVc = [[HistoryViewController alloc] init];
    UINavigationController *historyNc = [[UINavigationController alloc] initWithRootViewController:historyVc];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[mapNc, historyNc];
    
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
