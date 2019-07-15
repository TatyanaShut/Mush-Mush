//
//  AddPointViewController.h
//  Mush-Mush
//
//  Created by Tatyana Shut on 13.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView, CLLocationManager, CLLocation;


@interface AddPointViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *currentYearLabel;
@property (weak, nonatomic) IBOutlet UITextField *namePointTextField;
@property (weak, nonatomic) IBOutlet UITextField *massOfMushroomsTextField;
@property (weak, nonatomic) IBOutlet UILabel *latitudeCoordinatesLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *longitudeCoordinatesLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong) CLLocation *location;


@end


