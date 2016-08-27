//
//  NSDate+MTCategory.m
//  MT_Guoke
//
//  Created by Austen on 16/2/17.
//  Copyright © 2016年 mlc. All rights reserved.
//

#import "NSDate+MTCategory.h"

@implementation NSDate (MTCategory)

- (BOOL)isThisYear {
    
    // 日历对象
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    // 当前时间
    NSDate * currentDate = [NSDate date];
    
    // 比较时间
    NSDateComponents * components = [calendar components:NSCalendarUnitYear
                                                fromDate:self
                                                  toDate:currentDate
                                                 options:0];
    return components.year == 0;
}

- (NSDateComponents *)compareDateByNow {
    
    // 日历对象
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    // 当前时间
    NSDate * currentDate = [NSDate date];
    
    // 比较时间
    NSDateComponents * components = [calendar components:unit
                                                fromDate:self
                                                  toDate:currentDate
                                                 options:0];
    return components;
}

@end
