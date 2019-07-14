//
//  LocationManager.h
//  Mush-Mush
//
//  Created by Дмитрий on 7/12/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocationManager, CLLocation;

NS_ASSUME_NONNULL_BEGIN

@interface LocationManager : NSObject
@property (strong, nonatomic) CLLocationManager *locationManager;
//@property (strong, nonatomic) CLLocation *location;
- (void)checkPermission;
@end

NS_ASSUME_NONNULL_END
