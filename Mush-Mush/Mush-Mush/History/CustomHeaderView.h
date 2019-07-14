//
//  CustomHeaderView.h
//  Mush-Mush
//
//  Created by USER on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomHeaderView;

@protocol CustomHeaderViewListener <NSObject>
- (void) didTapOnHeaderView:(CustomHeaderView*) header;
@end

@interface CustomHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) id<CustomHeaderViewListener> listener;
@property (assign, nonatomic) NSInteger section;
@property (strong, nonatomic) UIButton* expandButon;
@property (assign, nonatomic) BOOL isTapped;
@property (assign, nonatomic) BOOL isExpanded;
@property (strong, nonatomic) UILabel* yearLabel;
@property (strong, nonatomic) UILabel* mushroomsWeight;
@end
