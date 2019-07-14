//
//  StatisticCollectionViewCell.h
//  Mush-Mush
//
//  Created by USER on 7/14/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) NSLayoutConstraint* statisticHeightConstraints;
@property (strong, nonatomic) UILabel* totalWeightLabel;
@property (strong, nonatomic) UILabel* yearLabel;
@end
