//
//  DataSourse.h
//  Mush-Mush
//
//  Created by Tatyana Shut on 14.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataSource : NSObject
@property(strong, nonatomic) NSArray *urlArray;
@property(strong, nonatomic) NSArray *nameMushroom;
@property(strong, nonatomic) NSArray *descriptionMushroom;
@end


NS_ASSUME_NONNULL_END
