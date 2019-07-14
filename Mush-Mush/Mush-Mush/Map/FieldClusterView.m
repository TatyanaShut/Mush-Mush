//
//  FieldClusterView.m
//  Mush-Mush
//
//  Created by Дмитрий on 7/14/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "FieldClusterView.h"
#import "UIColor+CustomColor.h"

#pragma mark - Lifecycle

@implementation FieldClusterView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.displayPriority = MKFeatureDisplayPriorityDefaultHigh;
        self.collisionMode = MKAnnotationViewCollisionModeCircle;
        self.centerOffset = CGPointMake(0, 5.0f);
        self.canShowCallout = YES;
    }
    return self;
}


- (void)setAnnotation:(id<MKAnnotation>)annotation {
    [super setAnnotation:annotation];
    if ([annotation isMemberOfClass:[MKClusterAnnotation class]]) {
        UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc]initWithSize:CGSizeMake(40, 40)];
        NSUInteger count = ((MKClusterAnnotation *)annotation).memberAnnotations.count;
        self.image = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
            [[UIColor brown] setFill];
            [[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 40, 40)] fill];
            
            [[UIColor whiteColor] setFill];
            [[UIBezierPath bezierPathWithOvalInRect:CGRectMake(8, 8, 24, 24)] fill];
            
            NSString *value = [NSString stringWithFormat:@"%lu", (unsigned long)count];
           
            UIFont *font = [UIFont systemFontOfSize:20.0f weight:UIFontWeightBold];
            UIColor *color = [UIColor blackColor];
            
            NSDictionary<NSAttributedStringKey, id> *attributes =  @{NSFontAttributeName:font, NSForegroundColorAttributeName:color};
        
            CGSize size = [value sizeWithAttributes:attributes];
            CGRect rect = CGRectMake(20 - size.width /2.0, 20 - size.height / 2.0, size.width, size.height);
            [value drawInRect:rect withAttributes:attributes];
        }];
        
    }
}



@end
