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

- (NSUInteger) totalMushroomWeightByYear:(NSString*) year {
    NSArray<Marker*>* markers = [self allMarkersByYear:year];
    return [[markers valueForKeyPath:@"@sum.mushroomsWeight"] unsignedIntegerValue];
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

- (void)deleteMarkerWithId:(NSString *)identifier year:(NSString *)year {
    NSData* unarchiveData = [self.userDefaults objectForKey:MARKERS];
    NSMutableDictionary<NSString*, NSMutableArray<Marker*>*>* markersByYears = [[NSMutableDictionary alloc] initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:unarchiveData]];
    NSMutableArray* markers = [markersByYears objectForKey:year];
    __block NSNumber* indexToRemove = nil;
    [markers enumerateObjectsUsingBlock:^(Marker *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([identifier isEqualToString:obj.identifier]) {
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

