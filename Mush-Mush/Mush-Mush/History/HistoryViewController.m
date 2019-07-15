//
//  HistoryViewController.m
//  Mush-Mush
//
//  Created by Tatyana Shut on 12.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "HistoryViewController.h"
#import "MarkerRepository.h"
#import "CustomHeaderView.h"
#import "CustomTableViewCell.h"
#import "MarkerInfoViewController.h"
#import "StatisticCollectionViewController.h"

@interface HistoryViewController () <UITableViewDataSource, UITableViewDelegate, CustomHeaderViewListener, CustomTableViewCellListener>
@property (strong, nonatomic) MarkerRepository* markerRepository;
@property (weak, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* sectionsExpendedState;
@property (strong, nonatomic) UIButton* statisticsButton;
@end

static NSString* const CELL_IDENTIFIER = @"cell";
static NSString* const HEADER_IDENTIFIER = @"header";

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableViewSetUp];
    
    self.markerRepository = [[MarkerRepository alloc] init];
    
    UINib* nib = [UINib nibWithNibName:@"CustomTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CELL_IDENTIFIER];
    [self.tableView registerClass:[CustomHeaderView class] forHeaderFooterViewReuseIdentifier:HEADER_IDENTIFIER];
    self.tableView.tableFooterView = [UIView new];
    self.sectionsExpendedState = [NSMutableArray array];
    for (int i = 0; i < [[self.markerRepository allYears] count]; i++) {
        [self.sectionsExpendedState addObject:@NO];
    }
    self.title = @"История";
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.markerRepository allYears] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSNumber* state = self.sectionsExpendedState[section];
    return [state boolValue] ? 0 : [[self.markerRepository allMarkersByYear:[[self.markerRepository allYears] objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell* cell = (CustomTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    cell.listener = self;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSString* currentYear = [[self.markerRepository allYears] objectAtIndex:indexPath.section];
    NSArray<Marker*>* markers = [self.markerRepository allMarkersByYear:currentYear];
    NSString* name = [markers objectAtIndex:indexPath.row].name;
    cell.infLabel.text = [NSString stringWithFormat:@"%@", name];
    return cell;
}

#pragma mark - UITableViewDelegate

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString* sectionYearLabel = [[self.markerRepository allYears] objectAtIndex:section];
    
    CustomHeaderView* customHeader = (CustomHeaderView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:HEADER_IDENTIFIER];
    
    customHeader.layer.borderWidth = 0.5f;
    customHeader.layer.borderColor = [UIColor colorWithRed:(223/255.0) green:(223/255.0) blue:(223/255.0) alpha:1].CGColor;
    customHeader.expandButon.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [customHeader.expandButon.trailingAnchor constraintEqualToAnchor:customHeader.trailingAnchor constant:-15],
                                              [customHeader.expandButon.centerYAnchor constraintEqualToAnchor:customHeader.centerYAnchor],
                                              [customHeader.expandButon.heightAnchor constraintEqualToConstant:40],
                                              [customHeader.expandButon.widthAnchor constraintEqualToConstant:40]
                                              ]];
    
    UILabel* yearLabel = [[UILabel alloc] init];
    [customHeader addSubview:yearLabel];
    yearLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [yearLabel.leadingAnchor constraintEqualToAnchor:customHeader.leadingAnchor constant:25],
                                              [yearLabel.centerYAnchor constraintEqualToAnchor:customHeader.centerYAnchor],
                                              [yearLabel.heightAnchor constraintEqualToConstant:30],
                                              [yearLabel.widthAnchor constraintEqualToConstant:45]
                                              ]];
    
    yearLabel.text = [NSString stringWithFormat:@"%@", sectionYearLabel];
    yearLabel.textColor = [UIColor blackColor];
    yearLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    customHeader.yearLabel = yearLabel;
    
    NSLog(@"dasdas = %@", @(self.view.frame.size.width));
    UILabel* mushroomWeight = [[UILabel alloc] init];
    [customHeader addSubview:mushroomWeight];
    if (self.view.frame.size.width <= 320) {
        mushroomWeight.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    } else {
        mushroomWeight.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    }
    mushroomWeight.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [mushroomWeight.leadingAnchor constraintEqualToAnchor:yearLabel.trailingAnchor constant:1],
                                              [mushroomWeight.centerYAnchor constraintEqualToAnchor:customHeader.centerYAnchor],
                                              [mushroomWeight.heightAnchor constraintEqualToConstant:35],
                                              [mushroomWeight.widthAnchor constraintEqualToConstant:255]
                                              ]];
    
    mushroomWeight.text = [NSString stringWithFormat:@"Total mushrooms weignt: %@", @([self.markerRepository totalMushroomWeightByYear:sectionYearLabel])];
    mushroomWeight.textColor= [UIColor colorWithRed:(153/255.0) green:(153/255.0) blue:(153/255.0) alpha:1];
    customHeader.mushroomsWeight = mushroomWeight;
    
    customHeader.section = section;
    customHeader.listener = self;
    
    return customHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 65;
}

#pragma mark - TableViewSetUp

- (void) tableViewSetUp {
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                              [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                              [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor]
                                              ]];
    
    UIButton* statisticsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:statisticsButton];
    self.statisticsButton = statisticsButton;
    [self.statisticsButton addTarget:self action:@selector(checkStatistick:) forControlEvents:UIControlEventTouchUpInside];
    [self.statisticsButton setTitle:@"Statistics" forState:UIControlStateNormal];
    self.statisticsButton.backgroundColor = [UIColor lightGrayColor];
    self.statisticsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.statisticsButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                              [self.statisticsButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                              [self.statisticsButton.topAnchor constraintEqualToAnchor:self.tableView.bottomAnchor],
                                              [self.statisticsButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                              [self.statisticsButton.heightAnchor constraintEqualToConstant:60]
                                              ]];
}

#pragma mark - Statistick button

- (void) checkStatistick:(id) sender {
    if ([[self.markerRepository allYears] count] != 0) {
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    StatisticCollectionViewController* svc = [[StatisticCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    [self.navigationController pushViewController:svc animated:YES];
} else {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"You don't have markers"
                                                                   message:@"You must add marker to see statistics"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}
}

#pragma mark - CustomHeaderViewDelegate

- (void) didTapOnHeaderView:(CustomHeaderView *)header {
        BOOL state = [self.sectionsExpendedState[header.section] boolValue];
        self.sectionsExpendedState[header.section] = @(!state);
        header.isExpanded = !state;
        [self setUpHeaderExpanding:header];
        [self setUpHeaderCollor:header];
    
}

- (void) setUpHeaderExpanding:(CustomHeaderView*) header {
    
    NSString* currentYear = [[self.markerRepository allYears] objectAtIndex:header.section];
    NSUInteger markersInYear = [[self.markerRepository allMarkersByYear:currentYear] count];
    
    NSMutableArray* paths = [NSMutableArray array];
    
    for (int i = 0; i < markersInYear; i++) {
        NSIndexPath* path = [NSIndexPath indexPathForRow:i inSection:header.section];
        [paths addObject:path];
    }
    
    if (header.isExpanded) {
        [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
        [header.expandButon setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
    } else {
        [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
        [header.expandButon setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    }
}

- (void) setUpHeaderCollor:(CustomHeaderView*) header {
    if (header.isExpanded) {
        header.yearLabel.textColor = [UIColor colorWithRed:(217/255.0) green:(145/255.0) blue:(0/255.0) alpha:1];
        header.mushroomsWeight.textColor = [UIColor colorWithRed:(217/255.0) green:(145/255.0) blue:(0/255.0) alpha:1];
    } else {
        header.yearLabel.textColor = [UIColor blackColor];
        header.mushroomsWeight.textColor = [UIColor colorWithRed:(153/255.0) green:(153/255.0) blue:(153/255.0) alpha:1];
    }
}

#pragma mark - CustomTableViewCellListener

- (void) didTapOnCustomViewCell:(CustomTableViewCell *)header {
    
    NSIndexPath* path = [self.tableView indexPathForCell:header];
    NSString* currentYear = [[self.markerRepository allYears] objectAtIndex:path.section];
    NSArray<Marker*>* markers = [self.markerRepository allMarkersByYear:currentYear];
    Marker* marker = [markers objectAtIndex:path.row];
    
    MarkerInfoViewController* markerInfo = [[MarkerInfoViewController alloc] initWithNibName:@"MarkerInfoViewController" bundle:nil];
    markerInfo.identifier = marker.identifier;
    markerInfo.name = marker.name;
    markerInfo.year = marker.year;
    markerInfo.mushroomsWeight = marker.mushroomsWeight;
    markerInfo.descript = marker.descript;
    markerInfo.coordinateX = marker.coordinateX;
    markerInfo.coordinateY = marker.coordinateY;
    [self.navigationController pushViewController:markerInfo animated:YES];
}


@end







































