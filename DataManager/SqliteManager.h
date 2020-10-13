//
//  SqliteManager.h
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SqliteManager : NSObject

+ (instancetype)defaultManager;
- (BOOL)createTableName:(NSString *)tableName modelClass:(Class)modelClass;
- (BOOL)insertModel:(id)model tableName:(NSString *)tableName; 
 
- (NSMutableArray *)selectWithSql:(NSString *)sql;

@end

NS_ASSUME_NONNULL_END
