//
//  MarkerRepository.h
//  Mush-Mush
//
//  Created by USER on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Marker.h"

@interface MarkerRepository : NSObject
- (NSArray<NSString*>*) allYears;
- (NSArray<Marker*>*) allMarkersByYear:(NSString*) year;
- (void) saveMarker:(Marker*) marker;
- (void) deleteMarker:(Marker*) marker;
@end
