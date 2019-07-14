//
//  AddPointViewController.m
//  Mush-Mush
//
//  Created by Tatyana Shut on 13.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "AddPointViewController.h"
#import "StyleApp.h"
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "MapViewController.h"


@interface AddPointViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) CLLocationManager* locationManager;

@end

@implementation AddPointViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    MKCoordinateSpan span; span.latitudeDelta = .01;
    span.longitudeDelta = .01;
    MKCoordinateRegion region;
    region.center = self.location.coordinate; region.span = span;
    [self.mapView setRegion:region animated:YES];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeTextInput)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];
    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager startUpdatingLocation];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePointAction)];
    
    
    [StyleApp styleLabel:self.currentYearLabel];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    self.currentYearLabel.text = yearString;
    
    [StyleApp styleTextField:self.namePointTextField andPlaceholder:@"Name"];
    
    [StyleApp styleTextField:self.massOfMushroomsTextField andPlaceholder:@"Mass of mushrooms"];
    self.massOfMushroomsTextField.keyboardType = UIKeyboardTypePhonePad;
    
    [StyleApp styleLabel:self.latitudeCoordinatesLabel];
    self.latitudeCoordinatesLabel.text = @"latitude";
    
    [StyleApp styleLabel:self.longitudeCoordinatesLabel];
    self.longitudeCoordinatesLabel.text = @"longitude";
    
    
    [StyleApp styleTextView:self.descriptionTextView];
    
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self addAnnotation];
        //self.latitudeCoordinatesLabel.text = self.location.coordinate.latitude
        self.latitudeCoordinatesLabel.text = [NSString stringWithFormat:@"%.7lf", self.location.coordinate.latitude];
        self.longitudeCoordinatesLabel.text = [NSString stringWithFormat:@"%.7lf", self.location.coordinate.longitude];
    });
    
}

- (void) donePointAction{
    
    if (self.massOfMushroomsTextField.text.length == 0 &&  self.namePointTextField.text.length == 0) {
        [self shakeAnimation:self.namePointTextField];
        [self shakeAnimation:self.massOfMushroomsTextField];
    }
    
    if (self.namePointTextField.text.length == 0 )
    {
        
        [self shakeAnimation:self.namePointTextField];
    }
    if  (self.massOfMushroomsTextField.text.length == 0 ){
        [self shakeAnimation:self.massOfMushroomsTextField];
    }
    else
    {
        MapViewController* mapVc = [[MapViewController alloc] init];
        [self.navigationController pushViewController:mapVc animated:YES];
        
    }
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *identifier = @"Annotation";
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!pin){
        pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
        pin.pinTintColor =[UIColor redColor];
        pin.animatesDrop = YES;
        pin.canShowCallout = YES;
        pin.draggable = YES;
    }
    else{
        pin.annotation = annotation;
    }
    return pin;
}

-(void)mapView:(MKMapView *)mapView annotationView:(nonnull MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState{
    
    if(newState == MKAnnotationViewDragStateEnding) {
        CLLocationCoordinate2D location = view.annotation.coordinate;
        
        self.latitudeCoordinatesLabel.text = [NSString stringWithFormat:@"%.7lf", location.latitude];
        self.longitudeCoordinatesLabel.text = [NSString stringWithFormat:@"%.7lf", location.longitude];
        
        
    }
}
- (void) closeTextInput {
    [[self view] endEditing:YES];
}

-(void) addAnnotation{
    
    Annotation *annotation = [[Annotation alloc]init];
    annotation.title = @"Test";
    annotation.subtitle = @"TestSubtitle";
    annotation.coordinate = self.location.coordinate;
    [self.mapView addAnnotation:annotation];
    
}
-(void)shakeAnimation:(UIView*) view {
    const int reset = 5;
    const int maxShakes = 6;
    static int shakes = 0;
    static int translate = reset;
    
    [UIView animateWithDuration:0.09-(shakes*.01)
                          delay:0.01f
                        options:(enum UIViewAnimationOptions) UIViewAnimationCurveEaseInOut
                     animations:^{view.transform = CGAffineTransformMakeTranslation(translate, 0);}
                     completion:^(BOOL finished){
                         if(shakes < maxShakes){
                             shakes++;
                             if (translate > 0)
                                 translate--;
                             translate*=-1;
                             [self shakeAnimation:view];
                         } else {
                             view.transform = CGAffineTransformIdentity;
                             shakes = 0;
                             translate = reset;
                             return;
                         }
                     }];
}


@end


