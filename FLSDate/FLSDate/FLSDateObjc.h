//
//  FLSDateObjc.h
//  FLSDate
//
//  Created by fls on 2019/9/2.
//  Copyright © 2019年 fls. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLSDateObjc : NSObject
@property (nonatomic,strong) NSArray  *weeks;
@property (nonatomic,copy) NSString *firstDayDeteOfWeek;
@property (nonatomic,copy) NSString *nowDayDeteOfWeek;
@property (nonatomic,copy) NSString *lastDayDeteOfWeek;
+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
