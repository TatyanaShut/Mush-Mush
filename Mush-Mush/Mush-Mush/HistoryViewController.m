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

@interface HistoryViewController () <UITableViewDataSource, UITableViewDelegate, CustomHeaderViewListener, CustomTableViewCellListener>
@property (strong, nonatomic) MarkerRepository* markerRepository;
@property (weak, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* sectionsExpendedState;
@end

static NSString* const CELL_IDENTIFIER = @"cell";
static NSString* const HEADER_IDENTIFIER = @"header";

@implementation HistoryViewController

- (void)loadView {
    [super loadView];
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"History";
    self.markerRepository = [[MarkerRepository alloc] init];
    
    UINib* nib = [UINib nibWithNibName:@"CustomTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CELL_IDENTIFIER];
    [self.tableView registerClass:[CustomHeaderView class] forHeaderFooterViewReuseIdentifier:HEADER_IDENTIFIER];
    self.tableView.tableFooterView = [UIView new];
    self.sectionsExpendedState = [NSMutableArray array];
    for (int i = 0; i < [[self.markerRepository allYears] count]; i++) {
        [self.sectionsExpendedState addObject:@NO];
    }
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
                                              [customHeader.expandButon.trailingAnchor constraintEqualToAnchor:customHeader.trailingAnchor constant:-20],
                                              [customHeader.expandButon.centerYAnchor constraintEqualToAnchor:customHeader.centerYAnchor],
                                              [customHeader.expandButon.heightAnchor constraintEqualToConstant:50],
                                              [customHeader.expandButon.widthAnchor constraintEqualToConstant:50]
                                              ]];
    
    UILabel* yearLabel = [[UILabel alloc] init];
    [customHeader addSubview:yearLabel];
    yearLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [yearLabel.leadingAnchor constraintEqualToAnchor:customHeader.leadingAnchor constant:25],
                                              [yearLabel.centerYAnchor constraintEqualToAnchor:customHeader.centerYAnchor],
                                              [yearLabel.heightAnchor constraintEqualToConstant:30],
                                              [yearLabel.widthAnchor constraintEqualToConstant:65]
                                              ]];
    
    yearLabel.text = [NSString stringWithFormat:@"%@", sectionYearLabel];
    yearLabel.textColor = [UIColor blackColor];
    yearLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    customHeader.yearLabel = yearLabel;
    
    UILabel* mushroomWeight = [[UILabel alloc] init];
    [customHeader addSubview:mushroomWeight];
    mushroomWeight.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [mushroomWeight.leadingAnchor constraintEqualToAnchor:yearLabel.trailingAnchor constant:1],
                                              [mushroomWeight.centerYAnchor constraintEqualToAnchor:customHeader.centerYAnchor],
                                              [mushroomWeight.heightAnchor constraintEqualToConstant:35],
                                              [mushroomWeight.widthAnchor constraintEqualToConstant:250]
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






































