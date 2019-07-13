//
//  AddPointViewController.h
//  Mush-Mush
//
//  Created by Tatyana Shut on 13.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddPointViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *currentYearLabel;
@property (weak, nonatomic) IBOutlet UITextField *namePointTextField;
@property (weak, nonatomic) IBOutlet UITextField *massOfMushroomsTextField;
@property (weak, nonatomic) IBOutlet UILabel *positionCoordinatesLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

NS_ASSUME_NONNULL_END
