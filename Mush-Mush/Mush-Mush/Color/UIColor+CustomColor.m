//
//  UIColor+CustomColor.m
//  WeekCalendar
//
//  Created by Tatyana Shut on 29.06.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//
#import "UIColor+CustomColor.h"

@implementation UIColor (CustomColor)

+(UIColor *) backgroundColon {
    return [UIColor colorWithRed:0xEB/255.0f
                           green:0xCF/255.0f
                            blue:0x8D/255.0f alpha:1];

}
+(UIColor *) backgroundHeader {
    return [UIColor colorWithRed:0xF2/255.0f
                           green:0xF2/255.0f
                            blue:0xE6/255.0f alpha:1];
    
}
+ (UIColor *) brownLight {
    return [UIColor colorWithRed:0xBA/255.0f
                           green:0xAD/255.0f
                            blue:0x7A/255.0f alpha:1];
}

+ (UIColor *) brown {
    
    return [UIColor colorWithRed:0xCD/255.0f
                           green:0x85/255.0f
                            blue:0x3F/255.0f alpha:1];
}

+ (UIColor *) greenTransparent {
    return [UIColor colorWithRed:0xF2/255.0f
                           green:0xFF/255.0f
                            blue:0xF7/255.0f alpha:1];
}

+ (UIColor *) greenLight {
    return [UIColor colorWithRed:0xD6/255.0f
                           green:0xE4/255.0f
                         blue:0xD4/255.0f alpha:1];
}

+ (UIColor *) greenDark {
    return [UIColor colorWithRed:0x00/255.0f
                           green:0x80/255.0f
                            blue:0x00/255.0f alpha:1];
}

+ (UIColor *) green {
    return [UIColor colorWithRed:0x8F/255.0f
                           green:0xBC/255.0f
                            blue:0x8F/255.0f alpha:1];
}

@end
