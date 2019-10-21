//
//  FLSDateObjc.m
//  FLSDate
//
//  Created by fls on 2019/9/2.
//  Copyright © 2019年 fls. All rights reserved.
//

#import "FLSDateObjc.h"

@interface FLSDateObjc()


@end
@implementation FLSDateObjc
+ (instancetype)shareInstance {
    static FLSDateObjc *weekCalendarUitility = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weekCalendarUitility = [[FLSDateObjc alloc] init];
        [weekCalendarUitility getDateWeeksDuraingToday];
        [weekCalendarUitility getDateWeeksFromToday];
    });
    return weekCalendarUitility;
}
-(NSString *)transWeekName:(NSString *)orrignWeekName
{
    NSString *targetWeekName = @"";
    
    //转换文案
    if ([orrignWeekName isEqualToString:@"Sunday"]) {
        targetWeekName = @"周日";
    }
    else if ([orrignWeekName isEqualToString:@"Monday"]) {
        targetWeekName = @"周一";
    }
    else if ([orrignWeekName isEqualToString:@"Tuesday"]) {
        targetWeekName = @"周二";
    }
    else if ([orrignWeekName isEqualToString:@"Wednesday"]) {
        targetWeekName = @"周三";
    }
    else if ([orrignWeekName isEqualToString:@"Thursday"]) {
        targetWeekName = @"周四";
    }
    else if ([orrignWeekName isEqualToString:@"Friday"]) {
        targetWeekName = @"周五";
    }else{
        targetWeekName = @"周六";
    }
    
//    if ([orrignWeekName isEqualToString:@"星期日"]) {
//        targetWeekName = @"周日";
//    }
//    else if ([orrignWeekName isEqualToString:@"星期一"]) {
//        targetWeekName = @"周一";
//    }
//    else if ([orrignWeekName isEqualToString:@"星期二"]) {
//        targetWeekName = @"周二";
//    }
//    else if ([orrignWeekName isEqualToString:@"星期三"]) {
//        targetWeekName = @"周三";
//    }
//    else if ([orrignWeekName isEqualToString:@"星期四"]) {
//        targetWeekName = @"周四";
//    }
//    else if ([orrignWeekName isEqualToString:@"星期五"]) {
//        targetWeekName = @"周五";
//    }else{
//        targetWeekName = @"周六";
//    }
//
    return targetWeekName;
}
/**
 *  模式一
 *  获取当前时间开始的一周日期
 *  注意：当天作为起点往后顺延的一周
 */
-(void)getDateWeeksFromToday{
    
    //日历格式
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    
    NSMutableArray *dateWeeks = [NSMutableArray array];
    for (int i=0; i<7; i++) {
        //这一天
        NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:[NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * i]];
        NSDate *date = [calendar dateFromComponents:components];
        
        //年月日
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];//几月几号
        
        //星期
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        [weekFormatter setDateFormat:@"EEEE"];
        NSString *weekString = [self transWeekName:[weekFormatter stringFromDate:date]];//周几
        
        NSString *date_weekStr = [NSString stringWithFormat:@"%@-%@",dateString,weekString];
        [dateWeeks addObject:date_weekStr];
        
        //赋值
        if (i==0) {
            self.firstDayDeteOfWeek = [formater stringFromDate:date];
            self.nowDayDeteOfWeek = [formater stringFromDate:date];
        }else if (i==6) {
            self.lastDayDeteOfWeek = [formater stringFromDate:date];
        }
    }
    
    self.weeks = dateWeeks;
    NSLog(@"----dateWeeks:%@------",dateWeeks);
}
/**
 *  模式二
 *  获取当前时间所在一周的第一天和最后一天, 也即一周的日期
 *  注意：当天在这一周内，不是作为起点往后顺延
 */
- (void)getDateWeeksDuraingToday
{
    //日历格式
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                                         fromDate:now];
    // 得到：今天是星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday];
    // 得到：今天是几号
    NSInteger day = [comp day];
    
    NSLog(@"weekDay:%ld  day:%ld",weekDay,day);
    
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 7 - weekDay;
    }
    NSLog(@"firstDiff:%ld   lastDiff:%ld",firstDiff,lastDiff);
    
    // 一周日期
    NSArray *dateWeeks = [self getCurrentWeeksWithFirstDiff:firstDiff lastDiff:lastDiff];
    
    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"一周开始 %@",[formater stringFromDate:firstDayOfWeek]);
    NSLog(@"当前 %@",[formater stringFromDate:now]);
    NSLog(@"一周结束 %@",[formater stringFromDate:lastDayOfWeek]);
    
    NSLog(@"%@",dateWeeks);
    
    self.firstDayDeteOfWeek = [formater stringFromDate:firstDayOfWeek];
    self.nowDayDeteOfWeek = [formater stringFromDate:now];
    self.lastDayDeteOfWeek = [formater stringFromDate:lastDayOfWeek];
    self.weeks = dateWeeks;
}

//获取一周时间 数组
- (NSMutableArray *)getCurrentWeeksWithFirstDiff:(NSInteger)first lastDiff:(NSInteger)last{
    
    NSMutableArray *eightArr = [[NSMutableArray alloc] init];
    for (NSInteger i = first; i < last + 1; i ++) {
        //从现在开始的24小时
        NSTimeInterval secondsPerDay = i * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
        //NSString *dateStr = @"5月31日";
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
        NSString *weekStr = [weekFormatter stringFromDate:curDate];
        
        //转换文案
        weekStr = [self transWeekName:weekStr];
        
        //组合时间
        NSString *strTime = [NSString stringWithFormat:@"%@-%@",dateStr,weekStr];
        [eightArr addObject:strTime];
        
    }
    return eightArr;
}
@end
