//
//  ChatModel.h
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatModel : NSObject

///将字典转化为model
+ (instancetype)modelWithDic:(NSDictionary *)dic;

///将model转化为字典
- (NSDictionary *)transfromDictionary;

///获取类的所有属性名称与类型
+ (NSArray *)allPropertyName;

///解档
+ (instancetype)chat_unarchiveObjectWithData:(NSData *)data;

@end

@interface NSData (ChatModel)

///归档
+ (NSData *)chat_archivedDataWithModel:(ChatModel *)model;
@end

NS_ASSUME_NONNULL_END
