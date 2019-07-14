//
//  CalendarManager.m
//  Mush-Mush
//
//  Created by Дмитрий on 7/13/19.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "CalendarManager.h"

@interface CalendarManager()
@property (strong, nonatomic) NSCalendar *calendar;
@property (strong, nonatomic) NSDate *date;
@end

@implementation CalendarManager

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _date = [NSDate date];
        [self.calendar setFirstWeekday:2];
        [self.calendar setTimeZone:[NSTimeZone localTimeZone]];
    }
    return self;
}

#pragma mark - Public

- (NSInteger)nextYear {
    NSDateComponents* components = [self.calendar components: NSCalendarUnitYear fromDate:self.date];
    [components setTimeZone:[NSTimeZone localTimeZone]];
    [components setYear:components.year + 1];
    self.date = [self.calendar dateFromComponents:components];
    return components.year;
}
- (NSInteger)prevYear {
    NSDateComponents* components = [self.calendar components: NSCalendarUnitYear fromDate:self.date];
    [components setTimeZone:[NSTimeZone localTimeZone]];
    [components setYear:components.year - 1];
    self.date = [self.calendar dateFromComponents:components];
    return components.year;
}

- (NSInteger)currentYear {
    NSDateComponents* components = [self.calendar components: NSCalendarUnitYear fromDate:[NSDate date]];
    [components setTimeZone:[NSTimeZone localTimeZone]];
    return components.year;
}

@end
