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

static NSString* const ID_KEY = @"id";
static NSString* const NAME_KEY = @"name";
static NSString* const DESCRIPTION_KEY = @"description";
static NSString* const YEAR_KEY = @"year";
static NSString* const WEIGHT_KEY = @"mushroomsWeight";
static NSString* const X_KEY = @"x";
static NSString* const Y_KEY = @"y";


@implementation Marker

- (instancetype)initWithName:(NSString*) name descript:(NSString*) description year:(NSString*) year mushroomsWeight:(NSString*) mushroomsWeight x:(NSString*) x y:(NSString*) y
{
    self = [super init];
    if (self) {
        _identifier = [[NSUUID UUID] UUIDString];
        _name = name;
        _descript = description;
        _year = year;
        _mushroomsWeight = mushroomsWeight;
        _coordinateX = x;
        _coordinateY = y;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.identifier forKey:ID_KEY];
    [aCoder encodeObject:self.name forKey:NAME_KEY];
    [aCoder encodeObject:self.descript forKey:DESCRIPTION_KEY];
    [aCoder encodeObject:self.year forKey:YEAR_KEY];
    [aCoder encodeObject:self.mushroomsWeight forKey:WEIGHT_KEY];
    [aCoder encodeObject:self.coordinateX forKey:X_KEY];
    [aCoder encodeObject:self.coordinateY forKey:Y_KEY];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.identifier = [aDecoder decodeObjectForKey:ID_KEY];
        self.name = [aDecoder decodeObjectForKey:NAME_KEY];
        self.descript = [aDecoder decodeObjectForKey:DESCRIPTION_KEY];
        self.year = [aDecoder decodeObjectForKey:YEAR_KEY];
        self.mushroomsWeight = [aDecoder decodeObjectForKey:WEIGHT_KEY];
        self.coordinateX = [aDecoder decodeObjectForKey:X_KEY];
        self.coordinateY = [aDecoder decodeObjectForKey:Y_KEY];
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    Marker* obj = (Marker*)(object);
    if (self == obj) {
        return YES;
    }
    if (![obj isKindOfClass:[Marker class]]) {
        return NO;
    }
    return  [self.identifier isEqualToString:obj.identifier] &&
            [self.name isEqualToString:obj.name] &&
            [self.descript isEqualToString:self.descript] &&
            [self.year isEqualToString:self.year] &&
            [self.mushroomsWeight isEqualToString:self.mushroomsWeight] &&
            [self.coordinateX isEqualToString:self.coordinateX] &&
            [self.coordinateY isEqualToString:self.coordinateY];
}

- (NSUInteger)hash {
    NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [self.identifier hash];
    result = prime * result + [self.name hash];
    result = prime * result + [self.descript hash];
    result = prime * result + [self.year hash];
    result = prime * result + [self.coordinateX hash];
    result = prime * result + [self.coordinateY hash];
    return result;
}

@end
