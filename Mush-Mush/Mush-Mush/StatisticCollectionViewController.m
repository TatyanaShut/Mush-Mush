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
@end

@implementation StatisticCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Statistics";
    self.markerRepository = [[MarkerRepository alloc] init];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[StatisticCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}

#pragma mark <UICollectionViewDataSource>

-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
//    collectionViewLayout.minimumInteritemSpacing=100;
//    collectionViewLayout.minimumLineSpacing =2;
//    return UIEdgeInsetsMake(1, CGRectGetMidX(self.view.bounds), 1, 1);
    return UIEdgeInsetsMake(100, 100, 100, 100);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[self.markerRepository allYears] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StatisticCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString* currentYear = [[self.markerRepository allYears] objectAtIndex:indexPath.item];
    NSUInteger yearHeight = [self.markerRepository totalMushroomWeightByYear:currentYear];
    
    cell.statisticHeightConstraints.constant = yearHeight * 3;
    cell.totalWeightLabel.text = [NSString stringWithFormat:@"%@", @(yearHeight)];
    cell.yearLabel.text = currentYear;
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(45, self.view.frame.size.height / 2);
}

@end
