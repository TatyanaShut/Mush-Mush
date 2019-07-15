//
//  MarkerInfoViewController.m
//  Mush-Mush
//
//  Created by USER on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "MarkerInfoViewController.h"

@interface MarkerInfoViewController ()
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;
@property (strong, nonatomic) IBOutlet UILabel *xLabel;
@property (strong, nonatomic) IBOutlet UILabel *yLabel;

@end

@implementation MarkerInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.name;
    
    if ([self.descript isEqualToString:@""]) {
        self.descriptionLabel.text = @"Description:  without description.";
    } else {
        self.descriptionLabel.text = [NSString stringWithFormat:@"Description:  %@", self.descript];
    }
    
    self.yearLabel.text = [NSString stringWithFormat:@"Year:  %@", self.year];
    self.weightLabel.text = [NSString stringWithFormat:@"Total weight:  %@kg", self.mushroomsWeight];
    self.yLabel.text = [NSString stringWithFormat:@"Coordinate Y:  %@", self.coordinateY];
    self.xLabel.text = [NSString stringWithFormat:@"Coordinate X:  %@", self.coordinateX];
    //self.view.backgroundColor = [UIColor whiteColor];
    self.yearLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.descriptionLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.weightLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.xLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
     self.yLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
    
}


@end
