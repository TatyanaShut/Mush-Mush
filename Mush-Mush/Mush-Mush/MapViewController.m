//
//  MapViewController.m
//  Mush-Mush
//
//  Created by Tatyana Shut on 12.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "MapViewController.h"
#import "AddPointViewController.h"
#import "LocationManager.h"
#import "CalendarManager.h"
#import "YearPickerView.h"
#import "Marker.h"
#import "MarkerRepository.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) YearPickerView *pickerView;
@property (strong, nonatomic) LocationManager *locationManager;
@property (strong, nonatomic) MKAnnotationView *selectedAnnotationView;
@property (strong, nonatomic) CalendarManager *calendarManager;
@property (assign, nonatomic) BOOL isUserLocationUpdated;
@property (weak, nonatomic) MKUserTrackingButton *trackingButton;
@property (weak, nonatomic) MKScaleView *scaleView;
@end

@implementation MapViewController

static NSString *const kMessageTitle = @"Warning";
static NSString *const kMessageBody = @"Do you want to delete the pin?";
static NSString *const kOkButtonTitle = @"Ok";
static NSString *const kCancelButtonTitle = @"Cancel";

@synthesize mapView = _mapView;

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isUserLocationUpdated = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [[[NSBundle mainBundle]infoDictionary] valueForKey:@"CFBundleName"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    [self createYearPickerView];
    [self setupPickerView];
    [self createMapView];
    [self setupMapView];
    [self setupLocationManager];
    [self setupCalendarManager];
    [self setupTrackingButton];
    [self setupScaleView];
    
    
    //load defaults
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isUserLocationUpdated = NO;
    NSString *text = [NSString stringWithFormat:@"%ld", (long)[self.calendarManager currentYear]];
    [self.pickerView setYearText:text];
    
    //reload annotations
}

#pragma mark - Actions

- (void) addPointAction {
    //[self addAnnotationToMapView];
    AddPointViewController* addViewController = [[AddPointViewController alloc] init];
    NSInteger latitude = self.mapView.userLocation.coordinate.latitude;
    NSInteger longitude = self.mapView.userLocation.coordinate.longitude;
    addViewController.location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [self.navigationController pushViewController:addViewController animated:YES];
}

- (void) deletePointAction {
    NSArray <id<MKAnnotation>> *array = self.mapView.selectedAnnotations;
    [self.mapView removeAnnotations:array];
    //remove from defaults
}

- (void)nextButtonTapped:(id)sender {
    if (self.calendarManager) {
         NSString *text = [NSString stringWithFormat:@"%ld", (long)[self.calendarManager nextYear]];
        [self.pickerView setYearText:text animated:YES direction:kLeft];
    }
}

- (void)prevButtonTapped:(id)sender {
    if (self.calendarManager) {
        NSString *text = [NSString stringWithFormat:@"%ld", (long)[self.calendarManager prevYear]];
        [self.pickerView setYearText:text animated:YES direction:kRight];
    }
}

#pragma mark - Private

- (void)setupCalendarManager {
    CalendarManager *calendarManager = [[CalendarManager alloc]init];
    self.calendarManager = calendarManager;
    
}

- (void)setupLocationManager {
    LocationManager *locationManager = [[LocationManager alloc]init];
    self.locationManager = locationManager;
    [self.locationManager checkPermission];
}

- (void)setupTrackingButton {
    MKUserTrackingButton *trackingButton = [MKUserTrackingButton userTrackingButtonWithMapView:self.mapView];
    [trackingButton.layer setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.8].CGColor];
    [trackingButton.layer setBorderColor:[UIColor colorWithWhite:1.0 alpha:0.8].CGColor];
    [trackingButton.layer setBorderWidth:1.0f];
    [trackingButton.layer setCornerRadius:6.0f];
    [self.view addSubview:trackingButton];
    self.trackingButton = trackingButton;
    [self setConstraintsForTrackingButton];
}

- (void)setConstraintsForTrackingButton {
    self.trackingButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.trackingButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-self.trackingButton.frame.size.height/2.0],
                                              [self.trackingButton.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant: -5.0f]
                                              ]];
}

- (void)setupScaleView {
    MKScaleView *scaleView = [MKScaleView scaleViewWithMapView:self.mapView];
    scaleView.legendAlignment = MKScaleViewAlignmentLeading;
    scaleView.scaleVisibility = MKFeatureVisibilityVisible;
    [self.view addSubview:scaleView];
    self.scaleView = scaleView;
    [self setConstraintsForScaleView];
}

- (void)setConstraintsForScaleView {
    self.scaleView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.scaleView.topAnchor constraintEqualToAnchor:self.pickerView.bottomAnchor],
                                              [self.scaleView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:5.0f]
                                              ]];
}


- (void)setupNavigationBar {
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor lightGrayColor]];
    [self.navigationController.navigationBar setBarStyle: UIBarStyleBlack];
    [self.navigationController.navigationBar setTitleTextAttributes: @{
                                                                       NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                       NSFontAttributeName: [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold]
                                                                       }];
    [self createAddActionButton];
}

- (void)centerMapOnUserLoacation {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

- (void)createAddActionButton {
    NSUInteger itemsCount = self.navigationController.navigationBar.topItem.rightBarButtonItems.count;
    if (itemsCount==1) {
        return;
    }
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPointAction)];
    NSArray <UIBarButtonItem *> *array = [NSArray <UIBarButtonItem *> arrayWithObjects:addButton,nil];
    [self.navigationController.navigationBar.topItem setRightBarButtonItems:array animated:NO];
}

- (void)createAddAndDeleteActionButtons {
    NSUInteger itemsCount = self.navigationController.navigationBar.topItem.rightBarButtonItems.count;
    if (itemsCount==2) {
        return;
    }
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPointAction)];
    UIBarButtonItem *deleteButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deletePointAction)];
    NSArray <UIBarButtonItem *> *array = [NSArray <UIBarButtonItem *> arrayWithObjects:addButton,deleteButton, nil];
    [self.navigationController.navigationBar.topItem setRightBarButtonItems:array animated:NO];
}

- (void)createMapView {
    MKMapView *mapView = [[MKMapView alloc]init];
    [self.view addSubview:mapView];
    self.mapView = mapView;
}

- (void)createYearPickerView {
   YearPickerView *pickerView = (YearPickerView *)[[NSBundle mainBundle] loadNibNamed:@"YearPickerView" owner:self options:nil].firstObject;
    [self.view addSubview:pickerView];
    self.pickerView = pickerView;
}

- (void)setupPickerView {
    [self setConstraintsToPickerView];
    [self.pickerView setBackgroundColor:[UIColor lightGrayColor]];
    [self.pickerView.prevButton addTarget:self action:@selector(prevButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerView.nextButton addTarget:self action:@selector(nextButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupMapView {
     self.mapView.delegate = self;
    [self setConstraintsToMapView];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setZoomEnabled:YES];
    
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

- (void)showAlertViewController {
    UIAlertController *alertContoller = [UIAlertController alertControllerWithTitle:kMessageTitle message:kMessageBody preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:kOkButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf deletePointAction];
    }];
    [alertContoller addAction:okAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:kCancelButtonTitle style:UIAlertActionStyleCancel handler:nil];
    [alertContoller addAction:cancelAction];
    [self.parentViewController presentViewController:alertContoller animated:YES completion:nil];
}

#pragma mark - MapView Delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (!self.isUserLocationUpdated) {
        [self centerMapOnUserLoacation];
        self.isUserLocationUpdated = YES;
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view isMemberOfClass:[MKMarkerAnnotationView class]]) {
        self.selectedAnnotationView = view;
        [self createAddAndDeleteActionButtons];
    }
    else {
        self.selectedAnnotationView = nil;
        [self createAddActionButton];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    self.selectedAnnotationView = nil;
    [self createAddActionButton];
}


- (void)addAnnotationToMapView {
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = self.mapView.userLocation.coordinate;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    [self.mapView addAnnotation:point];
}
@end
