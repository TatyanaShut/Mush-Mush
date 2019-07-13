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
        [self setUp];
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

#pragma mark - setUpHeaderView

- (void) setUp {
    
    self.expandButon.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.expandButon.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20],
                                              [self.expandButon.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
                                              [self.expandButon.heightAnchor constraintEqualToConstant:35],
                                              [self.expandButon.widthAnchor constraintEqualToConstant:35]
                                              ]];
    
    UILabel* yearLabel = [[UILabel alloc] init];
    [self addSubview:yearLabel];
    yearLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [yearLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:25],
                                              [yearLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
                                              [yearLabel.heightAnchor constraintEqualToConstant:40],
                                              [yearLabel.widthAnchor constraintEqualToConstant:60]
                                              ]];
    
    yearLabel.textColor = [UIColor blackColor];
    yearLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    self.yearLabel = yearLabel;
    
    UILabel* mushroomWeight = [[UILabel alloc] init];
    [self addSubview:mushroomWeight];
    mushroomWeight.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [mushroomWeight.leadingAnchor constraintEqualToAnchor:self.yearLabel.trailingAnchor constant:10],
                                              [mushroomWeight.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
                                              [mushroomWeight.heightAnchor constraintEqualToConstant:35],
                                              [mushroomWeight.widthAnchor constraintEqualToConstant:150]
                                              ]];
    self.mushroomsWeight = mushroomWeight;
}


@end
