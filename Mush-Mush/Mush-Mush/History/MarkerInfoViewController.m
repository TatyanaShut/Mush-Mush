//
//  MarkerInfoViewController.m
//  Mush-Mush
//
//  Created by USER on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "MarkerInfoViewController.h"

@interface MarkerInfoViewController ()
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
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
    
    [UIView animateWithDuration:0.5 animations:^{
        self.stackView.frame = CGRectMake(self.stackView.frame.origin.x + 350, self.stackView.frame.origin.y, self.stackView.frame.size.width, self.stackView.frame.size.height);
    }];
    
    if ([self.descript isEqualToString:@""]) {
        self.descriptionLabel.text = @"Описание:";
    } else {
        self.descriptionLabel.text = [NSString stringWithFormat:@"Описание  %@", self.descript];
    }
    
    self.yearLabel.text = [NSString stringWithFormat:@"Год:  %@", self.year];
    self.weightLabel.text = [NSString stringWithFormat:@"Масса  грибов:  %@кг", self.mushroomsWeight];
    self.yLabel.text = [NSString stringWithFormat:@"Ширинна:  %@", self.coordinateY];
    self.xLabel.text = [NSString stringWithFormat:@"Долгота:  %@", self.coordinateX];
    //self.view.backgroundColor = [UIColor whiteColor];
    self.yearLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.descriptionLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.weightLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.xLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
     self.yLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:18];
    
}


@end
