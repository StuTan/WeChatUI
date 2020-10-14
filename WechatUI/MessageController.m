//
//  MessageController.m
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/10.
//

#import "MessageController.h"
#import "MessageModel.h"

@implementation MessageController

+ (MessageModel *)createTextMessage:(NSString *)message messageType:(UserShowType * )type {
    MessageModel *msgModel = [[MessageModel alloc] init];
    msgModel.showtype = type;
    msgModel.message = message;
    [self setConfig:msgModel];
    return msgModel;
}
 
 

+ (void)setConfig:(MessageModel *)msgModel {
       
    msgModel.timestmp = [MessageModel getTimeNow];
    if (msgModel.showtype == userTimeInfo) {
        msgModel.cellIdentifier = @"TimeCellTableViewCell";
    } else if (msgModel.showtype == userSendInfo) {
        msgModel.cellIdentifier = @"SendInfoTableViewCell";
    } else {
        msgModel.cellIdentifier = @"receiveTableViewCell";
    } 
}

@end
