//
//  StatisticCollectionViewController.m
//  Mush-Mush
//
//  Created by USER on 7/14/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "StatisticCollectionViewController.h"
#import "StatisticCollectionViewCell.h"
#import "MarkerRepository.h"

@interface StatisticCollectionViewController () <UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) MarkerRepository* markerRepository;
@property (strong, nonatomic) UILabel* informationLabel;
@end

@implementation StatisticCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Statistics";
    self.markerRepository = [[MarkerRepository alloc] init];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[StatisticCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.informationLabel = [[UILabel alloc] initWithFrame:CGRectMake(-300, self.view.frame.size.height / 2 + 120, 300, 100)];
    self.informationLabel.text = @"In this screen you can see the statistics of the collected mushrooms.";
    self.informationLabel.numberOfLines = 0;
    [self.collectionView addSubview:self.informationLabel];
    
    [UIView animateWithDuration:1 animations:^{
        self.informationLabel.frame = CGRectMake(self.informationLabel.frame.origin.x + 350, self.informationLabel.frame.origin.y, self.informationLabel.frame.size.width, self.informationLabel.frame.size.height);
    }];
    
}

#pragma mark <UICollectionViewDataSource>

-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(100, 100, 100, 100);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.markerRepository allYears] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StatisticCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString* currentYear = [[self.markerRepository allYears] objectAtIndex:indexPath.item];
    NSUInteger yearHeight = [self.markerRepository totalMushroomWeightByYear:currentYear];
    
    cell.statisticHeightConstraints.constant = yearHeight * 2;
    cell.totalWeightLabel.text = [NSString stringWithFormat:@"%@", @(yearHeight)];
    cell.yearLabel.text = currentYear;
    
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(45, self.view.frame.size.height / 2);
}

@end
