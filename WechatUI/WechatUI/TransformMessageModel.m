//
//  TransformMessageModel.m
//  WechatUI
//
//  Created by tanwenmeng on 2020/10/10.
//

#import "TransformMessageModel.h"
#import <objc/runtime.h>

@implementation TransformMessageModel
 

+(instancetype)chat_unarchiveObjectWithData:(NSData *)data {
    if ([self conformsToProtocol:@protocol(NSCoding)] && data) {
        if (class_respondsToSelector(self, @selector(initWithCoder:))) {
            return [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }
    return nil;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivarLists = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char* name = ivar_getName(ivarLists[i]);
        NSString* strName = [NSString stringWithUTF8String:name];
        [aCoder encodeObject:[self valueForKey:strName] forKey:strName];
    }
    free(ivarLists);
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivarLists = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            const char* name = ivar_getName(ivarLists[i]);
            NSString* strName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            id value = [aDecoder decodeObjectForKey:strName];
            if (value) {
                [self setValue:value forKey:strName];
            }
        }
        free(ivarLists);
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+(instancetype)modelWithDic:(NSDictionary *)dic {
    id model = [[self alloc] init];
    for (NSString *key in dic.allKeys) {
        [model setValue:[dic objectForKey:key] forKey:key];
    }
    return model;
}
 
-(NSDictionary *)transfromDictionary {
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    return [self transfromDictionary:dic class:[self class]];
}

-(NSDictionary *)transfromDictionary:(NSMutableDictionary *)dic class:(Class)class {
    Class superclass = [self _transfromDictionary:dic class:class];
    if ([superclass isSubclassOfClass:[TransformMessageModel class]]) {
        [self transfromDictionary:dic class:superclass];
    }
    return [dic copy];
}

-(Class)_transfromDictionary:(NSMutableDictionary *)dic class:(Class)class {
    unsigned int count = 0;
    objc_property_t *pros = class_copyPropertyList(class, &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t pro = pros[i];
        NSString *name = [NSString stringWithFormat:@"%s", property_getName(pro)] ;
        id value = [self valueForKey:name];
        
        if (value != nil) {
            [dic setValue:value forKey:name];
        }
    }
    free(pros);
    
    return [class superclass];
}
 
+(NSArray *)allPropertyName {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    return [self allPropertyName:arr class:[self class]];
}

+(NSArray *)allPropertyName:(NSMutableArray *)arr class:(Class)class {
    Class superclass = [self _allPropertyName:arr class:class];
    if ([superclass isSubclassOfClass:[TransformMessageModel class]]) {
        [self allPropertyName:arr class:superclass];
    }
    return [arr copy];
}

+(Class)_allPropertyName:(NSMutableArray *)arr class:(Class)class {
    unsigned int count;
    objc_property_t *pros = class_copyPropertyList(class, &count);
    for (int i = 0; i < count; i++) {
        objc_property_t pro = pros[i];
        NSString *name =[NSString stringWithFormat:@"%s",property_getName(pro)];
        NSString *type = [self attrValueWithName:@"T" InProperty:pros[i]];
        if ([type isEqualToString:@"q"]||[type isEqualToString:@"i"]||[type isEqualToString:@"I"]) {
            type = @"integer";
        } else if([type isEqualToString:@"f"] || [type isEqualToString:@"d"]) {
            type = @"real";
        } else if([type isEqualToString:@"B"]) {
            type = @"boolean";
        } else {
            type = @"text";
        }
        NSDictionary *dic = @{@"name":name,@"type":type};
        [arr addObject:dic];
    }
    free(pros);
    return [class superclass];
}

+(NSString*)attrValueWithName:(NSString*)name InProperty:(objc_property_t)pro {
    unsigned int count = 0;
    objc_property_attribute_t *attrs = property_copyAttributeList(pro, &count);
    for (int i = 0; i < count; i++) {
        objc_property_attribute_t attr = attrs[i];
        if (strcmp(attr.name, name.UTF8String) == 0) {
            return [NSString stringWithUTF8String:attr.value];
        }
    }
    free(attrs);
    return nil;
}

@end

@implementation NSData (TransformMessageModel)
/**NSKeyedArchiver
 *NSKeyedUnarchiver，NSKeyedArchiver将自定义的类转换成NSData实例，类里面每一个值对应一个Key；NSKeyedUnarchiver将NSData实例根据key值还原成自定义的类。
 */
+(NSData *)chat_archivedDataWithModel:(TransformMessageModel *)model {
    if ([model conformsToProtocol:@protocol(NSCoding)] && model) {
        if ([model respondsToSelector:@selector(encodeWithCoder:)]) {
            return [NSKeyedArchiver archivedDataWithRootObject:model];
        }
    }
    return nil;
}

@end
