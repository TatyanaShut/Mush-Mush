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
#import "Marker.h"
#import "MarkerRepository.h"
#import "DirectoryViewController.h"

@interface AppDelegate ()

@end

static NSString* const MARKERS = @"markers";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        [UINavigationBar appearance].shadowImage = [[UIImage alloc]init];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        MapViewController *mapVc = [[MapViewController alloc] init];
        UINavigationController *mapNc = [[UINavigationController alloc] initWithRootViewController:mapVc];
        
        HistoryViewController *historyVc = [[HistoryViewController alloc] init];
        UINavigationController *historyNc = [[UINavigationController alloc] initWithRootViewController:historyVc];
        
        DirectoryViewController *directoryVc = [[DirectoryViewController alloc]init];
        UINavigationController *directoryNc = [[UINavigationController alloc]initWithRootViewController:directoryVc];
        
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        tabBarController.viewControllers = @[mapNc, historyNc, directoryNc];
        tabBarController.tabBar.barTintColor=[UIColor lightGrayColor];
    
    UITabBarItem *itemMap = [[UITabBarItem alloc] initWithTitle:@"Карта" image:[UIImage imageNamed:@"map"] tag:0];
    UITabBarItem *itemHistory = [[UITabBarItem alloc] initWithTitle:@"История" image:[UIImage imageNamed:@"history"] tag:1];
    UITabBarItem *itemDirectory = [[UITabBarItem alloc] initWithTitle:@"Справочник" image:[UIImage imageNamed:@"news"] tag:2];

    
    mapNc.tabBarItem = itemMap;
    historyVc.tabBarItem = itemHistory;
    directoryNc.tabBarItem = itemDirectory;
    
        
        [self.window setRootViewController:tabBarController];
        [self.window makeKeyAndVisible];
        
        [self initUserDefaults];
        
        return YES;
}

- (void) initUserDefaults {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    //[userDefaults removeObjectForKey:MARKERS];
    
    if (![userDefaults objectForKey:MARKERS]) {
        NSData* initialState = [NSKeyedArchiver archivedDataWithRootObject:[NSMutableDictionary new]];
        [userDefaults setObject:initialState forKey:MARKERS];
        [userDefaults synchronize];
    }

}

@end
