//
//  CustomTableViewCell.m
//  Mush-Mush
//
//  Created by USER on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.infButton addTarget:self action:@selector(oushToInfo:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.infButton];
        self.infButton.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (IBAction)oushToInfo:(id)sender {
    if ([self.listener respondsToSelector:@selector(didTapOnCustomViewCell:)]) {
        [self.listener didTapOnCustomViewCell:self];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
