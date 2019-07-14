//
//  MushroomAnnotationView.m
//  Mush-Mush
//
//  Created by Дмитрий on 7/14/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "MushroomAnnotationView.h"
#import "UIColor+CustomColor.h"

static NSString *const kMushroomClusterInentifier = @"Mushroom";

@implementation MushroomAnnotationView

#pragma mark - Lifecycle

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])) {
        self.clusteringIdentifier = kMushroomClusterInentifier;
        [self setCollisionMode:MKAnnotationViewCollisionModeCircle];
        [self setClusteringIdentifier:kMushroomClusterInentifier];
        [self setMarkerTintColor:[UIColor brown]];
        [self setGlyphImage:[UIImage imageNamed:@"mushroom3"]];
        [self setDisplayPriority:MKFeatureDisplayPriorityDefaultHigh];
        [self setCanShowCallout:YES];
        self.collisionMode = MKAnnotationViewCollisionModeCircle;
        [self setCalloutOffset:CGPointMake(0.0f, 5.0f)];
        UIImage *image = [UIImage imageNamed:@"mushroom1"];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        self.leftCalloutAccessoryView = imageView;
    }
    return self;
}

#pragma mark - Custom accessories

- (void)setAnnotation:(id<MKAnnotation>)annotation {
    if (self.annotation != annotation) {
        [super setAnnotation:annotation];
        [self setClusteringIdentifier:kMushroomClusterInentifier];
        [self setMarkerTintColor:[UIColor brown]];
        [self setGlyphImage:[UIImage imageNamed:@"mushroom3"]];
        [self setDisplayPriority:MKFeatureDisplayPriorityDefaultHigh];
        [self setCanShowCallout:YES];
        [self setCollisionMode:MKAnnotationViewCollisionModeCircle];
        [self setCalloutOffset:CGPointMake(0.0f, 5.0f)];
         UIImage *image = [UIImage imageNamed:@"mushroom1"];
         UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
         self.leftCalloutAccessoryView = imageView;
    }
}

@end
