//
//  Marker.h
//  Mush-Mush
//
//  Created by USER on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Marker : NSObject <NSCoding>
@property (strong, nonatomic) NSString* identifier;
@property (strong, nonatomic) NSString* year;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* descript;
@property (strong, nonatomic) NSString* mushroomsWeight;
@property (strong, nonatomic) NSString* coordinateX;
@property (strong, nonatomic) NSString* coordinateY;

- (instancetype)initWithName:(NSString*) name descript:(NSString*) description year:(NSString*) year mushroomsWeight:(NSString*) mushroomsWeight x:(NSString*) x y:(NSString*) y;
@end
