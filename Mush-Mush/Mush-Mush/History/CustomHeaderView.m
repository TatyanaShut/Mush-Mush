//
//  CustomHeaderView.m
//  Mush-Mush
//
//  Created by USER on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "CustomHeaderView.h"
#import "UIColor+CustomColor.h"

@interface CustomHeaderView ()
@end

@implementation CustomHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView.backgroundColor = [UIColor brownLight];
        self.expandButon = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.expandButon setImage:[UIImage imageNamed:@"arrow_down"]forState:UIControlStateNormal];
        self.expandButon.backgroundColor = [UIColor clearColor];
        [self.expandButon addTarget:self action:@selector(expandRows:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.expandButon];
        
        self.yearLabel = [UILabel new];
        [self.contentView addSubview:self.yearLabel];
        
        self.mushroomsWeight = [UILabel new];
        [self.contentView addSubview:self.mushroomsWeight];
        
    }
    return self;
}

- (void) expandRows:(id) sender {
    if ([self.listener respondsToSelector:@selector(didTapOnHeaderView:)]) {
        [self.listener didTapOnHeaderView:self];
    }
}


@end
