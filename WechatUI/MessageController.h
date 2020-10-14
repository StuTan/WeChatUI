//
//  MessageController.h
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/10.
//
 

#import <Foundation/Foundation.h>
#import "MessageModel.h"

@interface MessageController : NSObject

+ (MessageModel *)createTextMessage:(NSString *)message messageType:(UserShowType *)type;   
 
@end

