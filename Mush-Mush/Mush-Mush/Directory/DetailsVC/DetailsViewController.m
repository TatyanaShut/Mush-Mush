//
//  DetailsViewController.m
//  Mush-Mush
//
//  Created by Tatyana Shut on 14.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIColor+CustomColor.h"

@interface DetailsViewController ()

@property (nonatomic, strong) UILabel *descriptionMush;
@property(nonatomic, strong) UIImageView *customView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor backgroundHeader];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.imageFull];
    [self.view addSubview:imageView];
    self.customView = imageView;
    [self checkImageSize:self.customView];
    
    self.title =  self.titleDetailsVc;
    self.descriptionMush = [[UILabel alloc] init];
    self.descriptionMush .lineBreakMode = NSLineBreakByWordWrapping;
    self.descriptionMush .numberOfLines = 0;
    self.descriptionMush.textAlignment = NSTextAlignmentCenter;
    self.descriptionMush.textColor = [UIColor lightGrayColor];
    self.descriptionMush.text = self.descriptionMushroom;
    
    [self.view addSubview:self.descriptionMush];
    [self addConsctraint];
    
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backButtonnImage = [UIImage imageNamed:@"arrow_left"];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self creatBarButton:backButton :backButtonnImage :backBarButtonItem];
}

- (void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatBarButton:(UIButton *)button :(UIImage *)image :(UIBarButtonItem *)buttonItem {
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = buttonItem;
}

- (void)checkImageSize:(UIImageView *)imageView {
    
    if(imageView.frame.size.width > self.view.frame.size.width ||  imageView.frame.size.height > self.view.frame.size.height) {
        
        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, imageView.frame.size.height);
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
                                                  [imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:-50],
                                                  [imageView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:30],
                                                  [imageView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-30]
                                                  ]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    else{
        imageView.center = imageView.superview.center;
    }
}

- (void)addConsctraint {
    self.descriptionMush.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.descriptionMush.topAnchor constraintEqualToAnchor:self.customView.bottomAnchor constant:-125],
                                              [self.descriptionMush.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-30],
                                              [self.descriptionMush.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:30],
                                              ]];
}

@end
