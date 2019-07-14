//
//  DirectoryTableViewCell.h
//  Mush-Mush
//
//  Created by Tatyana Shut on 14.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DirectoryTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView* imageFromUrlView;
@property(nonatomic,retain) UILabel *urlLabel;
@end

NS_ASSUME_NONNULL_END
