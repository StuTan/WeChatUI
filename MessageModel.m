//
//  User.m
//  Wechat
//
//  Created by tanwenmeng on 2020/10/1.
//

#import "MessageModel.h"
#import "timeInfoTableViewCell.h"
#import "sendInfoTableViewCell.h"
#import "receiveTableViewCell.h" 
#import "ChatModel.h"

@interface MessageModel ()

@end

@implementation MessageModel : ChatModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mid = [NSString stringWithFormat:@"%@",@([MessageModel getTimeNow])];
    }
    return self;
}

- (NSString *)cellIdentifier
{
    if (_showtype == userTimeInfo) {
        return NSStringFromClass([timeInfoTableViewCell class]);
    } else if (_showtype == userSendInfo){
        return NSStringFromClass([sendInfoTableViewCell class]);
    } else {
        return NSStringFromClass([receiveTableViewCell class]);
    }
}

//获取当前的时间
+(NSTimeInterval)getTimeNow {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970]*1000;
    return time;
}

+(NSString*)getCurrentTimes {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    // 设置想要的格式，hh与HH的区别:分别表示12小时制,24小时制

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];

    NSDate *dateNow = [NSDate date];

    //把NSDate按formatter格式转成NSString

    NSString *currentTime = [formatter stringFromDate:dateNow];

    return currentTime;

}

//获取指定日期
+ (NSDate *)dateFromTimeStamp:(NSString *)timeStamp {
    NSInteger scale = 1;
    if (timeStamp.floatValue > 999999999999) {
        scale = 1000;
    }
    NSTimeInterval time = [timeStamp integerValue]/scale;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return date;
}

//时间格式化
+ (NSString *)timeFromTimeStamp:(NSString *)timeStamp {
    NSDate *date = [self dateFromTimeStamp:timeStamp];
    return [self timeFromDate:date];
}

+ (NSMutableDictionary *)formatterCache {
    static dispatch_once_t onceToken;
    static NSMutableDictionary *cache;
    dispatch_once(&onceToken, ^{
        cache = [NSMutableDictionary dictionaryWithCapacity:0];
    });
    return cache;
}

+ (NSDateFormatter *)chat_defaultDateFormatter {
    NSString *f = @"yyyy-MM-dd HH:mm:ss";
    return [self chat_dateFormatter:f];
}

+ (NSDateFormatter *)chat_detailDateFormatter{
    NSString *f = @"yyyy-MM-dd HH:mm:ss.SSS EEEE";
    return [self chat_dateFormatter:f];
}

+ (NSString *)timeFromDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    // 当前时间的年月日
    NSDate *nowDate = [NSDate date];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:nowDate];
    
    // 指定日期的年月日
    NSDateComponents *sinceCmps = [calendar components:unit fromDate:date];
    
    NSDateFormatter *dateFormatter = [self chat_dateFormatter:@"HH:mm"];
    NSString *time = [dateFormatter stringFromDate:date];
    if ((sinceCmps.year == nowCmps.year) &&
        (sinceCmps.month == nowCmps.month)) {
        
        if ((sinceCmps.day == nowCmps.day)) {
            //今天
            return [NSString stringWithFormat:@"今天 %@",time];
        }
        if (nowCmps.day - sinceCmps.day == 1) {
            //昨天
            return [NSString stringWithFormat:@"昨天 %@",time];
        }
    }
    return [NSString stringWithFormat:@"%@/%@/%@ %@",@(sinceCmps.year),@(sinceCmps.month),@(sinceCmps.day),time];
}

+ (NSDateFormatter *)chat_dateFormatter:(NSString *)f {
    NSDateFormatter *formatter = [[self formatterCache] objectForKey:f];
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:f];
        [[self formatterCache] setObject:formatter forKey:f];
    }
    return formatter;
}

//+ (NSString*)compareTwoTime:(long long)time1 time2:(long long)time2{
//    NSTimeInterval balance = time2 /1000- time1 /1000;
//    NSString*timeString = [[NSString alloc]init];
//    timeString = [NSString stringWithFormat:@"%f",balance /60];
//    timeString = [timeString substringToIndex:timeString.length-7];
//    NSInteger timeInt = [timeString intValue];
//    NSInteger hour = timeInt /60;
//    NSInteger mint = timeInt %60;
//
//    if(hour == 0 ) {
//        timeString = [NSString stringWithFormat:@"%ld分钟",(long)mint];
//    } else{
//        if(mint ==0) {
//            timeString = [NSString stringWithFormat:@"%ld小时",(long)hour];
//        }
//        else{
//            timeString = [NSString stringWithFormat:@"%ld小时%ld分钟",(long)hour,(long)mint];
//        }
//
//    }
//    return timeString;
//}

+(BOOL)compareTwoTime:(long long)time1 time2:(long long)time2{
    NSTimeInterval balance = time2 /1000- time1 /1000;
    NSString*timeString = [[NSString alloc]init];
    timeString = [NSString stringWithFormat:@"%f",balance /60];
    timeString = [timeString substringToIndex:timeString.length-7];
    NSInteger timeInt = [timeString intValue];
    NSInteger hour = timeInt /60;
    NSInteger mint = timeInt %60;

    if(hour > 0 || mint > 3 ) {
        return YES;
    }
    return NO;
}

@end
