//
//  MessageController.h
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/10.
//
 

#import <Foundation/Foundation.h>
#import "MessageModel.h"

@interface MessageController : NSObject

 

///创建文本消息
+ (MessageModel *)createTextMessage:(NSString *)message messageType:(UserShowType *)type;
 

@end

