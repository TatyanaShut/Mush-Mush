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

- (NSArray<NSString*>*) allYears {
    NSData* unarchiveData = [self.userDefaults objectForKey:MARKERS];
    NSMutableDictionary<NSString*, NSMutableArray<Marker*>*>* markersByYears = [NSKeyedUnarchiver unarchiveObjectWithData:unarchiveData];
    return [markersByYears allKeys];
}

- (NSArray<Marker*>*) allMarkersByYear:(NSString*) year {
    NSData* unarchiveData = [self.userDefaults objectForKey:MARKERS];
    NSMutableDictionary<NSString*, NSMutableArray<Marker*>*>* markersByYears = [NSKeyedUnarchiver unarchiveObjectWithData:unarchiveData];
    return [markersByYears objectForKey:year];
}

- (void) saveMarker:(Marker*) marker {
    NSData* unarchiveData = [self.userDefaults objectForKey:MARKERS];
    NSMutableDictionary<NSString*, NSMutableArray<Marker*>*>* markersByYears = [[NSMutableDictionary alloc] initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:unarchiveData]];
    NSMutableArray* markers = [markersByYears objectForKey:marker.year];
    if (!markers) {
        markers = [NSMutableArray new];
        [markersByYears setObject:markers forKey:marker.year];
    }
    [markers addObject:marker];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:markersByYears];
    
    [self.userDefaults setObject:data forKey:MARKERS];
    [self.userDefaults synchronize];
}

- (void) deleteMarker:(Marker*) marker {
    NSData* unarchiveData = [self.userDefaults objectForKey:MARKERS];
    NSMutableDictionary<NSString*, NSMutableArray<Marker*>*>* markersByYears = [[NSMutableDictionary alloc] initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:unarchiveData]];
    NSMutableArray* markers = [markersByYears objectForKey:marker.year];
    __block NSNumber* indexToRemove = nil;
    [markers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Marker* object = (Marker*)obj;
        if ([marker.identifier isEqualToString:object.identifier]) {
            indexToRemove = @(idx);
            *stop = YES;
        }
    }];
    
    if (indexToRemove) {
        [markers removeObjectAtIndex:[indexToRemove unsignedIntegerValue]];
        NSData* data = [NSKeyedArchiver archivedDataWithRootObject:markersByYears];
        [self.userDefaults setObject:data forKey:MARKERS];
        [self.userDefaults synchronize];
    }
}

@end



























