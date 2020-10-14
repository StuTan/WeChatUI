//
//  DBManager.h
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/10.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject

+ (instancetype)DBManagerr;

- (NSMutableArray *)messagesWithChat;                //返回消息列表
- (void)insertMessage:(MessageModel *)message;       //插入消息
 
@end

NS_ASSUME_NONNULL_END
