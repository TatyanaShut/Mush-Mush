//
//  CustomHeaderView.m
//  Mush-Mush
//
//  Created by USER on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "CustomHeaderView.h"

@interface CustomHeaderView ()
@end

@implementation CustomHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView.backgroundColor = [UIColor colorWithRed:223 green:223 blue:223 alpha:1];
        self.expandButon = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.expandButon setImage:[UIImage imageNamed:@"arrow_down"]forState:UIControlStateNormal];
        self.expandButon.backgroundColor = [UIColor clearColor];
        [self.expandButon addTarget:self action:@selector(expandRows:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.expandButon];
    }
    return self;
}

- (void) expandRows:(id) sender {
    if ([self.listener respondsToSelector:@selector(didTapOnHeaderView:)]) {
        [self.listener didTapOnHeaderView:self];
    }
}



@end
