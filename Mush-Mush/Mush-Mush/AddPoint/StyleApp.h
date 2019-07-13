//
//  StyleApp.h
//  Mush-Mush
//
//  Created by Tatyana Shut on 12.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <MapKit/MKAnnotation.h>
#import <UIKit/UIKit.h>

@interface StyleApp : NSObject //<MKAnnotation>

//@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *subtitle;

+ (void) styleLabel:(UILabel *)label;
+ (void) styleTextField:(UITextField *) textField  andPlaceholder:(NSString *)placeholder;
+ (void) styleTextView:(UITextView *)  textView;

@end


