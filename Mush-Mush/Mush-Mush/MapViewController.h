//
//  MapViewController.h
//  Mush-Mush
//
//  Created by Tatyana Shut on 12.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface MapViewController : UIViewController {
    MKMapView *mapView;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end


