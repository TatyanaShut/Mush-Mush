//
//  StyleApp.m
//  Mush-Mush
//
//  Created by Tatyana Shut on 12.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "StyleApp.h"
#import <UIKit/UIKit.h>
#import "UIColor+CustomColor.h"

@implementation StyleApp

+ (void)styleLabel:(UILabel *) label{
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 10.f;
    label.layer.borderColor = [UIColor brownColor].CGColor;
    label.layer.borderWidth = 1;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15.f];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor greenLight];
   
    
}
+ (void) styleTextField:(UITextField *)textField andPlaceholder:(NSString *)placeholder {
    textField.textAlignment = NSTextAlignmentCenter;
    textField.layer.cornerRadius = 10.f;
    textField.layer.borderColor = [UIColor brownColor].CGColor;
    textField.layer.borderWidth = 1;
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:15.f];
    textField.placeholder = placeholder;
    textField.backgroundColor = [UIColor greenLight];

}
+ (void) styleTextView:(UITextView *)textView {
    textView.textAlignment = NSTextAlignmentCenter;
    textView.layer.cornerRadius = 10.f;
    textView.layer.borderColor = [UIColor brownColor].CGColor;
    textView.layer.borderWidth = 1;
    textView.textColor = [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:15.f];
    textView.backgroundColor = [UIColor greenLight];
    
}
@end
