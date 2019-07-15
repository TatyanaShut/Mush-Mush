//
//  CustomTableViewCell.h
//  Mush-Mush
//
//  Created by USER on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTableViewCell;

@protocol CustomTableViewCellListener <NSObject>
- (void) didTapOnCustomViewCell:(CustomTableViewCell*) header;
@end

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) id<CustomTableViewCellListener> listener;
@property (weak, nonatomic) IBOutlet UIButton *infButton;


@property (strong, nonatomic) IBOutlet UILabel *infLabel;

@end
