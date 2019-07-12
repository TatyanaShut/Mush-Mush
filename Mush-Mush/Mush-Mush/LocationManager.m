//
//  LocationManager.m
//  Mush-Mush
//
//  Created by Дмитрий on 7/12/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "LocationManager.h"
#import <MapKit/MapKit.h>

@interface LocationManager() <CLLocationManagerDelegate>

@end

@implementation LocationManager

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _location = [[CLLocation alloc]init];
    }
    return self;
}

- (void)checkPermission {
    CLAuthorizationStatus status =  [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined){
        [self.locationManager requestWhenInUseAuthorization];
    }
    else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
       
        [self.locationManager stopUpdatingLocation];
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
       
        [self.locationManager stopUpdatingLocation];
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.count > 0) {
        [self.locationManager startUpdatingLocation];
        self.location = locations.lastObject;
        [self.locationManager stopUpdatingLocation];
    }
}

@end
