//
//  AddPointViewController.m
//  Mush-Mush
//
//  Created by Tatyana Shut on 13.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "AddPointViewController.h"
#include "StyleApp.h"

@interface AddPointViewController ()

@property (nonatomic, strong) CLLocationManager* locationManager;
@property (strong, nonatomic) CLLocation *location;
@end

@implementation AddPointViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
//    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width,self.scrollView.bounds.size.height);
//    [self.view addSubview:scrollView];
    
    self.locationManager = [[CLLocationManager alloc] init];
    //self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePointAction)];
//
//    self.currentYearLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/10, self.view.frame.size.height/10, self.view.frame.size.width-65.f, 70.f)];
    [StyleApp styleLabel:self.currentYearLabel];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    self.currentYearLabel.text = yearString;
    //[self.scrollView addSubview:currentYearLabel];
    
//    self.namePointTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/10, self.view.frame.size.height/5, self.view.frame.size.width-65.f, 70.f)];
    [StyleApp styleTextField:self.namePointTextField andPlaceholder:@"Name"];
    //[self.scrollView addSubview:namePointTextField];
    
    //self.massOfMushroomsTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/10, self.view.frame.size.height/3.35, self.view.frame.size.width-65.f, 70.f)];
    [StyleApp styleTextField:self.massOfMushroomsTextField andPlaceholder:@"Mass of mushrooms"];
    self.massOfMushroomsTextField.keyboardType = UIKeyboardTypePhonePad;
    //[self.scrollView addSubview:massOfMushroomsTextField];
    
//    self.positionCoordinatesLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/10, self.view.frame.size.height/2.5, self.view.frame.size.width-65.f, 70.f)];
    [StyleApp styleLabel:self.positionCoordinatesLabel];
    self.positionCoordinatesLabel.text = @"positionСoordinatesLabel";
   // [self.scrollView addSubview:positionСoordinatesLabel];
    
  //  self.descriptionTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/10, self.view.frame.size.height/2, self.view.frame.size.width-65.f, 200.f)];
    [StyleApp styleTextView:self.descriptionTextView];
    //[self.scrollView addSubview:descriptionTextField];
    
    //self.mapView = [[MKMapView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/10, self.view.frame.size.height/1.3, self.view.frame.size.width-65.f, 200.f)];
    
    //[self.scrollView addSubview:self.mapView];
    
    
    
}
- (void) donePointAction{
    
    NSLog(@"hello");
    
}
- (void) hideKeyboard:(NSNotification *)notification {
    //CGRect keyboardFtame =  ((NSValue*) notification.userInfo[UIKeyboardFrameBeginUserInfoKey]).CGRectValue;
    // self.scrollView.constraints = keyboardFtame.size.height;
    //[self.view endEditing:YES];
}

//
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
//    if([annotation isKindOfClass:[MKUserLocation class]]) {
//        return nil;
//    }
//    static NSString *identifier = @"Annotation";
//
//    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//    if (!pin){
//        pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
//    pin.pinTintColor =[UIColor redColor];
//    pin.animatesDrop = YES;
//    pin.canShowCallout = YES;
//        pin.draggable = YES;
//    }
//    else{
//        pin.annotation = annotation;
//    }
//    return pin;
//}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.count > 0) {
        [self.locationManager startUpdatingLocation];
        self.
        location = locations.lastObject;
        [self.locationManager stopUpdatingLocation];
        NSLog(@"%@", locations);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
