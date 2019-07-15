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
#import "UIColor+CustomColor.h"
#import "Reachability.h"

@interface AppDelegate ()
@property (strong, nonatomic) UIView* maskBgView;
@property (strong, nonatomic) CAKeyframeAnimation* transformAnimation;
@property (strong, nonatomic) NSValue* initialBounds;
@property (strong, nonatomic) NSValue* secondBounds;
@property (strong, nonatomic) NSValue* finalBounds;
@property (strong, nonatomic) Re
@end

static NSString* const MARKERS = @"markers";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UINavigationBar appearance].shadowImage = [[UIImage alloc]init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor colorWithRed:241/255 green:196/255 blue:15/255 alpha:1];
    
    
    MapViewController *mapVc = [[MapViewController alloc] init];
    UINavigationController *mapNc = [[UINavigationController alloc] initWithRootViewController:mapVc];
   
    HistoryViewController *historyVc = [[HistoryViewController alloc] init];
    UINavigationController *historyNc = [[UINavigationController alloc] initWithRootViewController:historyVc];
        
    DirectoryViewController *directoryVc = [[DirectoryViewController alloc]init];
    UINavigationController *directoryNc = [[UINavigationController alloc]initWithRootViewController:directoryVc];
        
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[ mapNc, historyNc, directoryNc];
    tabBarController.tabBar.barTintColor=[UIColor green];
    tabBarController.tabBar.tintColor = [UIColor greenDark];
    
    UITabBarItem *itemMap = [[UITabBarItem alloc] initWithTitle:@"Карта" image:[UIImage imageNamed:@"map"] tag:0];
    UITabBarItem *itemHistory = [[UITabBarItem alloc] initWithTitle:@"История" image:[UIImage imageNamed:@"history"] tag:1];
    UITabBarItem *itemDirectory = [[UITabBarItem alloc] initWithTitle:@"Справочник" image:[UIImage imageNamed:@"news"] tag:2];

    directoryNc.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    historyNc.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    directoryNc.navigationBar.barTintColor = [UIColor green];
    historyNc.navigationBar.barTintColor = [UIColor green];
    
    mapNc.tabBarItem = itemMap;
    historyVc.tabBarItem = itemHistory;
    directoryNc.tabBarItem = itemDirectory;
    
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];
    
//    Marker* marker = [[Marker alloc] initWithName:@"mark276" descript:@"descs2" year:@"2016" mushroomsWeight:@"100" x:@"302" y:@"22"];
//    Marker* marker2 = [[Marker alloc] initWithName:@"mark2" descript:@"descs2" year:@"2017" mushroomsWeight:@"43" x:@"38" y:@"32"];
 //   MarkerRepository* m = [[MarkerRepository alloc] init];
//    [m saveMarker:marker];
    //[m saveMarker:marker2];
    
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
