//
//  YearPickerView.m
//  Mush-Mush
//
//  Created by Дмитрий on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "YearPickerView.h"



@implementation YearPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setYearText:(NSString *)text {
    if ([self.yearLabel.text isEqualToString:text]) {
        return;
    }
     self.yearLabel.text = text;
}

- (void)setYearText:(NSString *)text animated:(BOOL)animated direction:(Direction)direction {
    if (animated) {
        [self animateLabelWithDirection:direction];
    }
    [self setYearText:text];
}

- (void)animateLabelWithDirection:(Direction)direction {
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.25;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    switch (direction) {
        case kLeft:
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromLeft;
            break;
        case kRight:
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromRight;
            break;
        default:
            animation.type = kCATransitionFade;
            break;
    }
    [self.yearLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
}

@end
