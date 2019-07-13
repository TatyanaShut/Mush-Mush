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
- (NSArray<NSNumber*>*) allYears;
- (NSArray<Marker*>*) allMarkersByYear:(NSNumber*) year;
- (void) saveMarker:(Marker*) marker;
@end
