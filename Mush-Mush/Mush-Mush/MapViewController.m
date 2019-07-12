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

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"mush-mush";
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPointAction)];
}



- (void) addPointAction {
    AddPointViewController* addVc = [[AddPointViewController alloc] init];
    [self.navigationController pushViewController:addVc animated:YES];
}

@end
