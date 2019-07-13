//
//  Marker.m
//  Mush-Mush
//
//  Created by USER on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "Marker.h"

@interface Marker ()

@end

static NSString* const NAME_KEY = @"name";
static NSString* const DESCRIPTION_KEY = @"description";
static NSString* const YEAR_KEY = @"year";
static NSString* const X_KEY = @"x";
static NSString* const Y_KEY = @"y";


@implementation Marker

- (instancetype)initWithName:(NSString*) name descript:(NSString*) description year:(NSUInteger) year x:(float) x y:(float) y
{
    self = [super init];
    if (self) {
        _name = name;
        _descript = description;
        _year = year;
        _coordinateX = x;
        _coordinateY = y;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:NAME_KEY];
    [aCoder encodeObject:self.descript forKey:DESCRIPTION_KEY];
    [aCoder encodeInteger:self.year forKey:YEAR_KEY];
    [aCoder encodeFloat:self.coordinateX forKey:X_KEY];
    [aCoder encodeFloat:self.coordinateY forKey:Y_KEY];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:NAME_KEY];
        self.descript = [aDecoder decodeObjectForKey:DESCRIPTION_KEY];
        self.year = [aDecoder decodeIntegerForKey:YEAR_KEY];
        self.coordinateX = [aDecoder decodeFloatForKey:X_KEY];
        self.coordinateY = [aDecoder decodeFloatForKey:Y_KEY];
    }
    return self;
}

@end
