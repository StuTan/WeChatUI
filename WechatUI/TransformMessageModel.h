//
//  TransformMessageModel.h
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransformMessageModel : NSObject

+ (instancetype)modelWithDic:(NSDictionary *)dic; //将字典转化为model
- (NSDictionary *)transfromDictionary;           //将model转化为字典
+ (NSArray *)allPropertyName;                    //获取类的所有属性名称与类型
+ (instancetype)chat_unarchiveObjectWithData:(NSData *)data;

@end

@interface NSData (TransformMessageModel)

+(NSData *)chat_archivedDataWithModel:(TransformMessageModel *)model;

@end

NS_ASSUME_NONNULL_END
