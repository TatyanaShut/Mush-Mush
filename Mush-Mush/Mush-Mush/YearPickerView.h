//
//  YearPickerView.h
//  Mush-Mush
//
//  Created by Дмитрий on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum Direction {
    kLeft, kRight
} Direction;

@interface YearPickerView : UIView
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
- (void)setYearText:(NSString *)text animated:(BOOL)animated direction:(Direction)direction;
- (void)setYearText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
