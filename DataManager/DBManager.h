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

//返回消息列表
- (NSMutableArray *)messagesWithChat;

///插入消息
- (void)insertMessage:(MessageModel *)message  ;

///更新消息
- (void)updateMessageModel:(MessageModel *)message ;
 
@end

NS_ASSUME_NONNULL_END
