//
//  MarkerRepository.m
//  Mush-Mush
//
//  Created by USER on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "MarkerRepository.h"

@interface MarkerRepository ()
@property (strong, nonatomic) NSUserDefaults* userDefaults;
@end

static NSString* const MARKERS = @"markers";

@implementation MarkerRepository

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (NSArray<NSNumber*>*) allYears {
    NSData* unarchiveData = [self.userDefaults objectForKey:MARKERS];
    NSMutableDictionary<NSNumber*, NSMutableArray<Marker*>*>* markersByYears = [NSKeyedUnarchiver unarchiveObjectWithData:unarchiveData];
    return [markersByYears allKeys];
}

- (NSArray<Marker*>*) allMarkersByYear:(NSNumber*) year {
    NSData* unarchiveData = [self.userDefaults objectForKey:MARKERS];
    NSMutableDictionary<NSNumber*, NSMutableArray<Marker*>*>* markersByYears = [NSKeyedUnarchiver unarchiveObjectWithData:unarchiveData];
    return [markersByYears objectForKey:year];
}

- (void) saveMarker:(Marker*) marker {
    NSData* unarchiveData = [self.userDefaults objectForKey:MARKERS];
    //    NSMutableDictionary<NSNumber*, NSMutableArray<Marker*>*>* markersByYears = [NSKeyedUnarchiver unarchiveObjectWithData:unarchiveData];
    NSMutableDictionary<NSNumber*, NSMutableArray<Marker*>*>* markersByYears = [[NSMutableDictionary alloc] initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:unarchiveData]];
    NSMutableArray* markers = [markersByYears objectForKey:@(marker.year)];
    if (!markers) {
        markers = [NSMutableArray new];
        [markersByYears setObject:markers forKey:@(marker.year)];
    }
    [markers addObject:marker];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:markersByYears];
    
    [self.userDefaults setObject:data forKey:MARKERS];
    [self.userDefaults synchronize];
}

@end
