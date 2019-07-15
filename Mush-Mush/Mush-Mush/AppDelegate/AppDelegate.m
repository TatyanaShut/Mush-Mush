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

@interface AppDelegate () <CAAnimationDelegate>
@property (strong, nonatomic) UIView* maskBgView;
@property (strong, nonatomic) CAKeyframeAnimation* transformAnimation;
@property (strong, nonatomic) Reachability* checker;


@end

static NSString* const MARKERS = @"markers";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UINavigationBar appearance].shadowImage = [[UIImage alloc]init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   // self.window.backgroundColor = [UIColor colorWithRed:241/255 green:196/255 blue:15/255 alpha:1];
     [self.window setBackgroundColor:[UIColor backgroundHeader]];
    
    MapViewController *vc = [[MapViewController alloc]init];
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController: vc];
    
    
    nc.view.layer.mask = [[CALayer alloc]init];
    nc.view.layer.mask.contents = (id)[UIImage imageNamed:@"mushroomss"].CGImage;
    nc.view.layer.mask.bounds = CGRectMake(0, 0, 60, 60);
    nc.view.layer.mask.anchorPoint = CGPointMake(0.5, 0.5);
    nc.view.layer.mask.position = CGPointMake(nc.view.frame.size.width /2.0, nc.view.frame.size.height/2.0);
    
    UIView *maskBgView = [[UIView alloc]initWithFrame:nc.view.frame];
    [maskBgView setBackgroundColor:[UIColor whiteColor]];
    [nc.view addSubview:maskBgView];
    [nc.view bringSubviewToFront:maskBgView];
    
    CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"bounds"];
    transformAnimation.delegate = self;
    transformAnimation.duration = 1.5;
    transformAnimation.beginTime = CACurrentMediaTime();
    NSValue *initialBounds = [NSValue valueWithCGRect:nc.view.layer.mask.bounds];
    NSValue *secondBounds =[NSValue valueWithCGRect:CGRectMake(0, 0, 50, 50)];
    NSValue *finalBounds =[NSValue valueWithCGRect:CGRectMake(0, 0, 2000, 2000)];
    transformAnimation.values = @[initialBounds, secondBounds, finalBounds];
    transformAnimation.keyTimes = @[@0, @0.5, @1];
    transformAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    transformAnimation.removedOnCompletion = NO;
    transformAnimation.fillMode = kCAFillModeForwards;
    [nc.view.layer.mask addAnimation:transformAnimation forKey:@"maskAnimation"];
    
    [UIView animateWithDuration:0.1 delay:1.35 options:UIViewAnimationOptionCurveEaseIn animations:^{
        maskBgView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [maskBgView removeFromSuperview];
        }
    }];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 delay:1.3 options:UIViewAnimationOptionTransitionNone animations:^{
        [weakSelf.window.rootViewController.view setTransform: CGAffineTransformMakeScale(1.05, 1.05)];
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [weakSelf.window.rootViewController.view setTransform: CGAffineTransformIdentity];
            } completion:nil];
        }
    }];
    

    HistoryViewController *historyVc = [[HistoryViewController alloc] init];
    UINavigationController *historyNc = [[UINavigationController alloc] initWithRootViewController:historyVc];
        
    DirectoryViewController *directoryVc = [[DirectoryViewController alloc]init];
    UINavigationController *directoryNc = [[UINavigationController alloc]initWithRootViewController:directoryVc];
        
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[ nc, historyNc, directoryNc];
    tabBarController.tabBar.barTintColor=[UIColor green];
    tabBarController.tabBar.tintColor = [UIColor greenDark];
    
    UITabBarItem *itemMap = [[UITabBarItem alloc] initWithTitle:@"Карта" image:[UIImage imageNamed:@"map"] tag:0];
    UITabBarItem *itemHistory = [[UITabBarItem alloc] initWithTitle:@"История" image:[UIImage imageNamed:@"history"] tag:1];
    UITabBarItem *itemDirectory = [[UITabBarItem alloc] initWithTitle:@"Справочник" image:[UIImage imageNamed:@"news"] tag:2];

    directoryNc.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    historyNc.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    directoryNc.navigationBar.barTintColor = [UIColor green];
    historyNc.navigationBar.barTintColor = [UIColor green];
    
    vc.tabBarItem = itemMap;
    historyVc.tabBarItem = itemHistory;
    directoryNc.tabBarItem = itemDirectory;
    
    [self.window setRootViewController: tabBarController];
    [self.window makeKeyAndVisible];
    
//    Marker* marker = [[Marker alloc] initWithName:@"Berestovica" descript:@"super" year:@"2018" mushroomsWeight:@"30" x:@"302" y:@"22"];
//    Marker* marker2 = [[Marker alloc] initWithName:@"Bereza" descript:@"klassno" year:@"2017" mushroomsWeight:@"43" x:@"38" y:@"42"];
//    MarkerRepository* m = [[MarkerRepository alloc] init];
//    [m saveMarker:marker];
//    [m saveMarker:marker2];
    
    [self initUserDefaults];
    return YES;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.window.rootViewController.view.layer.mask = nil;
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

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NetworkStatus status = [_checker currentReachabilityStatus];
    if (status == NotReachable) {
        NSLog(@"not reachable");
    } else {
        NSLog(@"reachable");
    }

}

@end
