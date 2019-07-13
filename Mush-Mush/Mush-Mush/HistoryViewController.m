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

@interface HistoryViewController () <UITableViewDataSource, UITableViewDelegate, CustomHeaderViewListener>
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
    [self.tableView registerClass:[CustomHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
    self.tableView.tableFooterView = [UIView new];
    self.sectionsExpendedState = [NSMutableArray array];
    for (int i = 0; i < [[self.markerRepository allYears] count]; i++) {
        [self.sectionsExpendedState addObject:@NO];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"numberOfSectionsInTableView = %@", @([[self.markerRepository allYears] count]));
    return [[self.markerRepository allYears] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSNumber* state = self.sectionsExpendedState[section];
    NSLog(@"numberOfRowsInSection = %@", @([[self.markerRepository allMarkersByYear:[[self.markerRepository allYears] objectAtIndex:section]] count]));
    return [state boolValue] ? 0 : [[self.markerRepository allMarkersByYear:[[self.markerRepository allYears] objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"str %@", @(indexPath.row)];
    return cell;
}

#pragma mark - UITableViewDelegate

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString* sectionYearLabel = [[self.markerRepository allYears] objectAtIndex:section];
    CustomHeaderView* customHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    customHeader.yearLabel.text = [NSString stringWithFormat:@"%@", sectionYearLabel];
    customHeader.mushroomsWeight.text = [NSString stringWithFormat:@"mushrooms weignt:%@", @(section)];
    customHeader.section = section;
    customHeader.listener = self;
    return customHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
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
    
    NSNumber* rowsAmount = [[self.markerRepository allYears] objectAtIndex:header.section];
    
    NSMutableArray* paths = [NSMutableArray array];
    
    for (int i = 0; i < [rowsAmount intValue]; i++) {
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


@end






































