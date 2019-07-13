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
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[mapNc, historyNc];
    
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
    
    // for example. You can create marker using repository.
    Marker* marker = [[Marker alloc] initWithName:@"MarkerName" descript:@"MarkDesc" year:1998 x:10.0f y:10.0f];
    MarkerRepository* mr = [[MarkerRepository alloc] init];
    [mr saveMarker:marker];
    NSLog(@"allYEars %@", [mr allYears]);
    NSLog(@"allMarkers %@", [mr allMarkersByYear:@(1998)]);
}

@end
