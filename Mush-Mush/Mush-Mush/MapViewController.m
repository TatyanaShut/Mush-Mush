//
//  MapViewController.m
//  Mush-Mush
//
//  Created by Tatyana Shut on 12.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "MapViewController.h"
#import "AddPointViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) UIView *pickerView;
@end

@implementation MapViewController

@synthesize mapView = _mapView;

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setupNavigationBar];
    [self createYearPickerView];
    [self setupPickerView];
    [self createMapView];
    [self setupMapView];
    self.title = [[[NSBundle mainBundle]infoDictionary] valueForKey:@"CFBundleName"];
    
    //load defaults
    
}

#pragma mark - Actions

- (void) addPointAction {
    AddPointViewController* addViewController = [[AddPointViewController alloc] init];
    [self.navigationController pushViewController:addViewController animated:YES];
}

#pragma mark - Private

- (void)setupNavigationBar {
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor lightGrayColor]];
    [self.navigationController.navigationBar setBarStyle: UIBarStyleBlack];
    [self.navigationController.navigationBar setTitleTextAttributes: @{
                                                                       NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                       NSFontAttributeName: [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold]
                                                                       }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPointAction)];
}

- (void)createMapView {
    MKMapView *mapView = [[MKMapView alloc]init];
    [self.view addSubview:mapView];
    self.mapView = mapView;
}

- (void)createYearPickerView {
    UIView *pickerView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 64.0f)];
    [self.view addSubview:pickerView];
    self.pickerView = pickerView;
    [self.pickerView setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)setupPickerView {
    [self setConstraintsToPickerView];
}

- (void)setupMapView {
     self.mapView.delegate = self;
    [self setConstraintsToMapView];
    [self.mapView setShowsUserLocation:YES];
    
}

- (void)setConstraintsToPickerView {
    self.pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.pickerView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                              [self.pickerView.heightAnchor constraintEqualToConstant:44.0f],
                                              [self.pickerView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                              [self.pickerView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor]
                                              ]];
}

- (void)setConstraintsToMapView {
    self.mapView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.mapView.topAnchor constraintEqualToAnchor:self.pickerView.bottomAnchor],
                                              [self.mapView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                              [self.mapView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                              [self.mapView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor]
                                              ]];
}



@end
