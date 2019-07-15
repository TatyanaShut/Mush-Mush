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
#import "UIColor+CustomColor.h"
#import "Annotation.h"
#import "MushroomAnnotationView.h"
#import "FieldClusterView.h"

@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) YearPickerView *pickerView;
@property (strong, nonatomic) LocationManager *locationManager;
@property (strong, nonatomic) MKAnnotationView *selectedAnnotationView;
@property (strong, nonatomic) CalendarManager *calendarManager;
@property (assign, nonatomic) BOOL isUserLocationUpdated;
@property (weak, nonatomic) MKUserTrackingButton *trackingButton;
@property (weak, nonatomic) MKScaleView *scaleView;
@property (strong, nonatomic) MarkerRepository *repository;
@end

@implementation MapViewController

static NSString *const kMessageTitle = @"Внимание";
static NSString *const kMessageBody = @"Вы действительно хотите удалить метку?";
static NSString *const kOkButtonTitle = @"Да";
static NSString *const kCancelButtonTitle = @"Отменить";

@synthesize mapView = _mapView;

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isUserLocationUpdated = NO;
        _repository = [[MarkerRepository alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Карта";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    [self createYearPickerView];
    [self setupPickerView];
    [self createMapView];
    [self setupMapView];
    [self registerAnnotationViewClasses];
    [self setupLocationManager];
    [self setupCalendarManager];
    [self setupTrackingButton];
    [self setupScaleView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isUserLocationUpdated = NO;
    NSString *text = [NSString stringWithFormat:@"%ld", (long)[self.calendarManager currentYear]];
    [self.pickerView setYearText:text];
    [self removeAnnotations];
    [self addAnnotations];
}

#pragma mark - Actions

- (void) addPointAction {
    AddPointViewController* addViewController = [[AddPointViewController alloc] initWithNibName:@"AddPointViewController" bundle:nil];
    CGFloat latitude = self.mapView.userLocation.coordinate.latitude;
    CGFloat longitude = self.mapView.userLocation.coordinate.longitude;
    addViewController.location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [self.navigationController pushViewController:addViewController animated:YES];
}


- (void)removeAnnotationsFromRepository:(NSArray <id<MKAnnotation>> *)array {
     __weak typeof(self) weakSelf = self;
    [array enumerateObjectsUsingBlock:^(Annotation *obj, NSUInteger idx, BOOL * _Nonnull stop){
        [weakSelf.repository deleteMarkerWithId:obj.Id year:obj.year];
    }];
}


- (void) deletePointAction {
    NSArray <id<MKAnnotation>> *array = self.mapView.selectedAnnotations;
    NSArray <id<MKAnnotation>> *annotationArray = [array filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSArray<id<MKAnnotation>> *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isMemberOfClass:[Annotation class]] ? YES : NO;
    }]];

    if (annotationArray > 0) {
        [self.mapView removeAnnotations:annotationArray];
        
        [self removeAnnotationsFromRepository:annotationArray];
    }
    
    NSArray <id<MKAnnotation>> *clusterArray = [array filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSArray<id<MKAnnotation>> *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isMemberOfClass:[MKClusterAnnotation class]] ? YES : NO;
    }]];
    if (clusterArray >0) {
        
        for (id<MKAnnotation> array in clusterArray) {
            NSArray <id<MKAnnotation>> *annotationArray = ((MKClusterAnnotation *)array).memberAnnotations;
            [self removeAnnotationsFromRepository:annotationArray];
            [self.mapView removeAnnotations:annotationArray];
        }
    }
}

- (void)nextButtonTapped:(id)sender {
    if (self.calendarManager) {
        NSString *text = [NSString stringWithFormat:@"%ld", (long)[self.calendarManager nextYear]];
        [self.pickerView setYearText:text animated:YES direction:kLeft];
        [self removeAnnotations];
        [self addAnnotations];
    }
}

- (void)prevButtonTapped:(id)sender {
    if (self.calendarManager) {
        NSString *text = [NSString stringWithFormat:@"%ld", (long)[self.calendarManager prevYear]];
        [self.pickerView setYearText:text animated:YES direction:kRight];
        [self removeAnnotations];
        [self addAnnotations];
    }
}

#pragma mark - Private

- (NSArray<Marker *> *)fetchAnnotations {
    NSArray<Marker *> *annotations = [self.repository allMarkersByYear:self.pickerView.yearLabel.text];
    return annotations;
}

- (Annotation *)getAnnotattionFromMarker:(Marker *)marker {
    Annotation *point = [[Annotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake([marker.coordinateX floatValue], [marker.coordinateY floatValue]);
    point.Id = marker.identifier;
    point.weight = marker.descript;
    point.title = marker.name;
    point.subtitle = [NSString stringWithFormat:@"%@ кг.", marker.mushroomsWeight];
    point.year = marker.year;
    return point;
}


- (void)addAnnotations {
    __weak typeof (self) weakSelf = self;
    NSArray<Marker *> *array = [self fetchAnnotations];
    [array enumerateObjectsUsingBlock:^(Marker * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Annotation *point = [weakSelf getAnnotattionFromMarker:obj];
        [weakSelf.mapView addAnnotation:point];
    }];
    
    //    dispatch_queue_global_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    //    __weak typeof (self) weakSelf = self;
    //    dispatch_async(queue, ^{
    //        NSArray<Marker *> *array = [self fetchAnnotations];
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [array enumerateObjectsUsingBlock:^(Marker * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //                MKPointAnnotation *point = [weakSelf getAnnotattionFromMarker:obj];
    //                [weakSelf.mapView addAnnotation:point];
    //            }];
    //        });
    //    });
}


- (void)removeAnnotations {
    NSArray <id<MKAnnotation>> *array = self.mapView.annotations;
    NSArray <id<MKAnnotation>> *newArray = [array filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSArray<id<MKAnnotation>> *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isMemberOfClass:[Annotation class]] ? YES : NO;
    }]];
    [self.mapView removeAnnotations:newArray];
}

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
    trackingButton.tintColor = [UIColor greenDark];
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
    [self.navigationController.navigationBar setBarTintColor:[UIColor green]];
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
    addButton.tintColor = [UIColor greenDark];
    NSArray <UIBarButtonItem *> *array = [NSArray <UIBarButtonItem *> arrayWithObjects:addButton,nil];
    [self.navigationController.navigationBar.topItem setRightBarButtonItems:array animated:NO];
}

- (void)createAddAndDeleteActionButtons {
    NSUInteger itemsCount = self.navigationController.navigationBar.topItem.rightBarButtonItems.count;
    if (itemsCount==2) {
        return;
    }
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPointAction)];
    addButton.tintColor = [UIColor greenDark];
    UIBarButtonItem *deleteButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(showAlertViewController)];
    deleteButton.tintColor = [UIColor greenDark];
    NSArray <UIBarButtonItem *> *array = [NSArray <UIBarButtonItem *> arrayWithObjects:addButton,deleteButton, nil];
    [self.navigationController.navigationBar.topItem setRightBarButtonItems:array animated:NO];
}

- (void)createShareActionButton {
    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(showActivityViewController:)];
    actionButton.tintColor = [UIColor greenDark];
    [self.navigationController.navigationBar.topItem setLeftBarButtonItem:actionButton animated:NO];
}

- (void)removeShareActionButton {
    [self.navigationController.navigationBar.topItem setLeftBarButtonItem:nil animated:NO];
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
    [self.pickerView setBackgroundColor:[UIColor green]];
    [self.pickerView.prevButton addTarget:self action:@selector(prevButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerView.nextButton addTarget:self action:@selector(nextButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupMapView {
    self.mapView.delegate = self;
    [self setConstraintsToMapView];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setShowsCompass:YES];
    [self.mapView.userLocation setTitle:@"Я здесь"];
    
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

- (void)showActivityViewController:(id)sender {
    
    NSMutableArray *array = [NSMutableArray array];
    NSString *activity = [NSString stringWithFormat:@"Я нашел грибные места, координаты - "];
    [array addObject:activity];
    for (MKPointAnnotation *point in self.mapView.selectedAnnotations) {
        NSString *latitude = [NSString stringWithFormat:@"%f", point.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f", point.coordinate.longitude];
        NSString *result = [NSString stringWithFormat: @"широта:%@ долгота %@ ", latitude, longitude];
        [array addObject:result];
    }
    
    UIActivityViewController *moreViewController = [[UIActivityViewController alloc] initWithActivityItems:array applicationActivities:nil];
    moreViewController.popoverPresentationController.barButtonItem = (UIBarButtonItem*)sender;
    [self presentViewController:moreViewController animated:YES completion:nil];
}

//-(NSString *)activityViewController:(UIActivityViewController *)activityViewController subjectForActivityType:(UIActivityType)activityType
//{
//    NSLog(@"DELEGATE METHOD CALLED");
//
//    if (activityType == UIActivityTypeMessage) {
//        return @"My message";
//    } else if (activityType == UIActivityTypeMail) {
//        return @"My email text";
//    }
//    else {
//        return @"My default text";
//    }
//}


#pragma mark - MapView Delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (!self.isUserLocationUpdated) {
        [self centerMapOnUserLoacation];
        self.isUserLocationUpdated = YES;
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view isMemberOfClass:[MushroomAnnotationView class]]||[view isMemberOfClass:[FieldClusterView class]]) {
        self.selectedAnnotationView = view;
        [self createAddAndDeleteActionButtons];
        [self createShareActionButton];
    }
    else {
        self.selectedAnnotationView = nil;
        [self createAddActionButton];
        [self removeShareActionButton];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    self.selectedAnnotationView = nil;
    [self createAddActionButton];
    [self removeShareActionButton];
}


- (void)registerAnnotationViewClasses {
    [self.mapView registerClass:[MushroomAnnotationView class] forAnnotationViewWithReuseIdentifier:MKMapViewDefaultAnnotationViewReuseIdentifier];
    [self.mapView registerClass:[FieldClusterView class] forAnnotationViewWithReuseIdentifier:MKMapViewDefaultClusterAnnotationViewReuseIdentifier];
}

@end
