//
//  DBManager.m
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/10.
//

#import "DBManager.h"
#import "SqliteManager.h"
#import "TransformMessageModel.h"

@implementation DBManager

+ (instancetype)DBManagerr {
    static DBManager *DBmanager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DBmanager = [[DBManager alloc] init];
    });
    return DBmanager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //建表 <Message>
        [[SqliteManager defaultManager] createTableName:@"Message" modelClass:[MessageModel class]];
    }
    return self;
}

//消息列表
- (NSMutableArray *)messagesWithChat {
    NSString *tableName =  @"Message";
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY timestmp DESC LIMIT 100",tableName];
    NSArray *list = [[SqliteManager defaultManager] selectWithSql:sql];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:list.count];
    for (NSDictionary *dic in list) {
        MessageModel *model = [MessageModel modelWithDic:dic];
        [arr insertObject:model atIndex:0];
    }
    return arr;
}

//插入消息
- (void)insertMessage:( MessageModel *)message {
    NSString *tableName = @"Message";
    [[SqliteManager defaultManager] createTableName:tableName modelClass:[message class]];
    [[SqliteManager defaultManager] insertModel:message tableName:tableName];
}
 

@end
