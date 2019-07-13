//
//  Marker.h
//  Mush-Mush
//
//  Created by USER on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Marker : NSObject <NSCoding>
@property (assign, nonatomic) NSUInteger year;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* descript;
@property (assign, nonatomic) float coordinateX;
@property (assign, nonatomic) float coordinateY;

- (instancetype)initWithName:(NSString*) name descript:(NSString*) description year:(NSUInteger) year x:(float) x y:(float) y;
@end
