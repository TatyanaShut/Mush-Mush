//
//  StatisticCollectionViewCell.m
//  Mush-Mush
//
//  Created by USER on 7/14/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "StatisticCollectionViewCell.h"

#import "StatisticCollectionViewCell.h"

@interface StatisticCollectionViewCell ()
@property (strong, nonatomic) UIView* statisticView;
@end

@implementation StatisticCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [UIView animateWithDuration:1 animations:^{
            self.statisticView = [UIView new];
            self.statisticView.backgroundColor = [UIColor lightGrayColor];
            [self.contentView addSubview:self.statisticView];
            
            self.statisticHeightConstraints = [[NSLayoutConstraint alloc] init];
            self.statisticHeightConstraints = [self.statisticView.heightAnchor constraintEqualToConstant:300];
            self.statisticHeightConstraints.constant = 0;
            
            self.yearLabel = [UILabel new];
            [self.contentView addSubview:self.yearLabel];
            
            self.statisticView.translatesAutoresizingMaskIntoConstraints = NO;
            [NSLayoutConstraint activateConstraints:@[
                                                      [self.statisticView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
                                                      [self.statisticView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
                                                      [self.statisticView.bottomAnchor constraintEqualToAnchor:self.yearLabel.topAnchor],
                                                      self.statisticHeightConstraints
                                                      ]];
            
            self.totalWeightLabel = [UILabel new];
            [self.contentView addSubview:self.totalWeightLabel];
            self.totalWeightLabel.textAlignment = NSTextAlignmentCenter;
            self.totalWeightLabel.translatesAutoresizingMaskIntoConstraints = NO;
            [NSLayoutConstraint activateConstraints:@[
                                                      [self.totalWeightLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
                                                      [self.totalWeightLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
                                                      [self.totalWeightLabel.bottomAnchor constraintEqualToAnchor:self.statisticView.topAnchor],
                                                      [self.totalWeightLabel.heightAnchor constraintEqualToConstant:30],
                                                      ]];
            
            
            self.yearLabel.textAlignment = NSTextAlignmentCenter;
            self.yearLabel.translatesAutoresizingMaskIntoConstraints = NO;
            [NSLayoutConstraint activateConstraints:@[
                                                      [self.yearLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
                                                      [self.yearLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
                                                      [self.yearLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
                                                      [self.yearLabel.heightAnchor constraintEqualToConstant:30],
                                                      ]];
        }];
        
    }
    return self;
}

@end
