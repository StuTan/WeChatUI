//
//  User.h
//  Wechat
//
//  Created by tanwenmeng on 2020/10/1.
//

#import <Foundation/Foundation.h>
#import "TransformMessageModel.h"
 
 
 
typedef NS_ENUM(NSInteger, UserShowType){
    userTimeInfo,
    userSendInfo,
    userReceiveInfo,
    userText
};

 

@interface MessageModel : TransformMessageModel

@property (nonatomic, strong) NSString *mid;             //消息id
@property (nonatomic, assign) UserShowType showtype;     //消息类型
@property (nonatomic, strong) NSString *cellIdentifier;  //消息类对应不同的消息类型
@property (nonatomic, strong) NSString *message;         //文本内容
@property (nonatomic, assign) NSInteger timestmp;

+ (NSTimeInterval)getTimeNow;
+ (NSString*)getCurrentTimes;
+ (NSString *)timeFromDate:(NSDate *)date;
+ (NSDate *)dateFromTimeStamp:(NSString *)timeStamp;
+ (BOOL)compareTwoTime:(long long)time1 time2:(long long)time2;

@end

 
