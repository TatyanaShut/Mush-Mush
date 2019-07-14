//
//  DetailsViewController.m
//  Mush-Mush
//
//  Created by Tatyana Shut on 14.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@property (nonatomic, strong) UILabel *descriptionMush;
//@property(nonatomic, strong) UIView *customView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title =  self.titleDetailsVc;
    self.descriptionMush =[[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, 400.f)];
    self.descriptionMush .lineBreakMode = NSLineBreakByWordWrapping;
    self.descriptionMush .numberOfLines = 0;
    self.descriptionMush.text = self.descriptionMushroom;
    self.descriptionMush.translatesAutoresizingMaskIntoConstraints = NO;
    //[self addConsctraint];
    [self.view addSubview:self.descriptionMush];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.imageFull];
    [self.view addSubview:imageView];
    
    [self checkImageSize:imageView];
    
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
                                                  [imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                                  // [imageView.heightAnchor constraintEqualToConstant:44.0f],
                                                  [imageView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                                  [imageView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor]
                                                  ]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    else{
        imageView.center = imageView.superview.center;
    }
}

- (void)addConsctraint {
    
    
    //    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.descriptionMush attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:100];
    //    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.descriptionMush attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:200];
    //
    //    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.descriptionMush attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
    //    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.descriptionMush attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
    //
    //    [self.view addConstraints:@[left, top]];
    //    [self.descriptionMush addConstraints:@[height, width]];
    //    [NSLayoutConstraint activateConstraints:@[
    //                                              [self.descriptionMush .topAnchor constraintEqualToAnchor:self.customView.topAnchor],
    //                                              // [imageView.heightAnchor constraintEqualToConstant:44.0f],
    //                                              [self.descriptionMush .leadingAnchor constraintEqualToAnchor:self.customView.safeAreaLayoutGuide.leadingAnchor],
    //                                              [self.descriptionMush .trailingAnchor constraintEqualToAnchor:self.customView.safeAreaLayoutGuide.trailingAnchor]
    //                                              ]];
    
    [NSLayoutConstraint activateConstraints:@[
                                              [self.descriptionMush.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor]
                                              // [self.descriptionMush.widthAnchor constraintEqualToConstant:((DSHCustomView*)view).image.size.width],
                                              //[self.descriptionMush.heightAnchor constraintEqualToConstant:((DSHCustomView*)view).image.size.height],
                                              //[self.descriptionMush.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor constant:100]
                                              ]];
    [self.descriptionMush layoutIfNeeded];
}

@end
