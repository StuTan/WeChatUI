//
//  User.h
//  Wechat
//
//  Created by tanwenmeng on 2020/10/1.
//

#import <Foundation/Foundation.h>
#import "ChatModel.h"
 
 
 
typedef NS_ENUM(NSInteger, UserShowType){
    userTimeInfo,
    userSendInfo,
    userReceiveInfo,
    userText
};

 

@interface MessageModel : ChatModel

///消息id
@property (nonatomic, strong) NSString *mid;

//@property (nonatomic, assign) NSString *name;

//消息类型
@property (nonatomic, assign) UserShowType showtype;

//文本消息内容
//@property (nonatomic, copy) NSString *textInfo;

//消息类对应不同的消息类型
@property (nonatomic, strong) NSString *cellIdentifier;

///文本内容
@property (nonatomic, strong) NSString *message;

///消息发送时间
//@property (nonatomic, assign) NSString *time;

@property (nonatomic, assign) NSInteger timestmp;

//@property (nonatomic, assign) NSDate *dataTime;

//得到当前时间
+(NSTimeInterval)getTimeNow;
+(NSString*)getCurrentTimes;
+ (NSString *)timeFromDate:(NSDate *)date;
+ (NSDate *)dateFromTimeStamp:(NSString *)timeStamp;

+(BOOL)compareTwoTime:(long long)time1 time2:(long long)time2;

@end

 
