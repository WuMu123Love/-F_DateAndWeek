//
//  ViewController.m
//  FLSDate
//
//  Created by fls on 2019/9/2.
//  Copyright © 2019年 fls. All rights reserved.
//

#import "ViewController.h"
#import "FLSDateObjc.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FLSDateObjc * dateObj = [FLSDateObjc shareInstance];
//    NSLog(@"%@",dateObj.weeks);
    for (NSString * str in dateObj.weeks) {
        NSLog(@"%@",str);
    }
    
    
}
//-(NSMutableArray *)latelyEightTime{
//    NSMutableArray *weekArr = [[NSMutableArray alloc] init];
//    NSDate *nowDate = [NSDate date];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday  fromDate:nowDate];
//    // 获取今天是周几
//    NSInteger weekDay = [comp weekday];
//    // 获取几天是几号
//    NSInteger day = [comp day];
//    // 计算当前日期和本周的星期一和星期天相差天数
//    long first,last;
//    if (weekDay == 1){
//        first = -6;
//        last = 0;
//    }
//    else{
//        first = [calendar firstWeekday] - weekDay + 1;
//        last = 8 - weekDay;
//    }
//    NSDateComponents *baseDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:nowDate];
//    //获取周一日期
//    [baseDayComp setDay:day + first];
//    NSDate *firstDayOfWeek = [calendar dateFromComponents:baseDayComp];
//    //计算从周一开始的七天日期
//    for (int i = 0; i < 7; i ++) {
//        //从现在开始的24小时
//        NSTimeInterval secondsPerDay = i * 24*60*60;
//        NSDate *curDate = [NSDate dateWithTimeInterval:secondsPerDay sinceDate:firstDayOfWeek];
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"M.d"];
//        NSString *dateStr = [dateFormatter stringFromDate:curDate];//几月几号
//        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
//        [weekFormatter setDateFormat:@"EEEE"];//星期几 @"HH:mm 'on' EEEE MMMM d"];
//        NSString *weekStr = [weekFormatter stringFromDate:dateStr];
//        NSString *chinaStr = [self theWeek:weekStr];
//        NSString *strTime = [NSString stringWithFormat:@"%@%@",dateStr，chinaStr];
//        NSLog(@"%@",strTime);
//        [weekArr addObject:strTime];
//    }
//    return weekArr;
//}
//
////转换英文为中文
//-(NSString *)theWeek:(NSString *)theWeek{
//    NSString *Str;
//    if(theWeek){
//        if([theWeek isEqualToString:@"Monday"]){
//            Str = @"星期一";
//        }else if([theWeek isEqualToString:@"Tuesday"]){
//            Str = @"星期二";
//        }else if([theWeek isEqualToString:@"Wednesday"]){
//            Str = @"星期三";
//        }else if([theWeek isEqualToString:@"Thursday"]){
//            Str = @"星期四";
//        }else if([theWeek isEqualToString:@"Friday"]){
//            Str = @"星期五";
//        }else if([theWeek isEqualToString:@"Saturday"]){
//            Str = @"星期六";
//        }else if([theWeek isEqualToString:@"Sunday"]){
//            Str = @"星期日";
//        }
//    }
//    return Str;
//}

@end
