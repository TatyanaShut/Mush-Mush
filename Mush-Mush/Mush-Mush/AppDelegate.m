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

//     for example. You can create marker using repository.
//    Marker* marker = [[Marker alloc] initWithName:@"Name" descript:@"desct" year:@"2019" mushroomsWeight:@"30" x:@"2" y:@"1"];
//    Marker* marker2 = [[Marker alloc] initWithName:@"Name2" descript:@"desct2" year:@"2016" mushroomsWeight:@"34" x:@"10" y:@"3"];
//    MarkerRepository* mr = [[MarkerRepository alloc] init];
//    [mr saveMarker:marker];
//    [mr saveMarker:marker2];
//    NSLog(@"allYEars %@", [mr allYears]);
//    Marker* toDelete = [[mr allMarkersByYear:@"2019"] firstObject];
//    NSLog(@"allMarkers %@", [mr allMarkersByYear:@"2019"]);
//    [mr deleteMarker:toDelete];
//    NSLog(@"allMarkers %@", [mr allMarkersByYear:@"2019"]);
//    [mr deleteMarker:toDelete];
//    NSLog(@"allMarkers %@", [mr allMarkersByYear:@"2019"]);
//    
}

@end
