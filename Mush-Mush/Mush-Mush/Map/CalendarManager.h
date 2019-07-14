//
//  CalendarManager.h
//  Mush-Mush
//
//  Created by Дмитрий on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarManager : NSObject
- (NSInteger)nextYear;
- (NSInteger)prevYear;
- (NSInteger)currentYear;
@end

NS_ASSUME_NONNULL_END
