//
//  HMAnotationStorage.m
//  Himalaya
//
//  Created by hao yin on 2019/7/5.
//

#import "HMAnotationStorage.h"
#import <Ham/Ham-Swift.h>

@implementation HMAnotationStorage{
    NSMutableDictionary<NSString *,RouterTree *> * storage;
}
+(instancetype)shared{
    static HMAnotationStorage* storage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        storage = [[HMAnotationStorage alloc] init];
    });
    return storage;
}
-(instancetype)init{
    self = [super init];
    if(self){
        storage = [[NSMutableDictionary alloc] init];
    }
    return self;
}
- (void)addName:(NSString *)name key:(NSString *)key value:(NSString *)value{
    if(!storage[name]){
        storage[name] = [[RouterTree alloc] init];
    }
    Class cls = NSClassFromString(value);
    if(cls){
        [storage[name] registerWithRoute:key cls: cls];
    }
    
}
- (RouterTree *)getEnvConfigByName:(NSString *)name{
    return storage[name];
}
@end

@implementation HMBlockAnotationStorage{
    NSMutableDictionary* dic;
}
@dynamic map;
+ (instancetype)shared{
    static HMBlockAnotationStorage* storage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        storage = [[HMBlockAnotationStorage alloc] init];
    });
    return storage;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        dic = [[NSMutableDictionary alloc] init];
    }
    return self;
}
- (void)addkey:(NSString *)key value:(id)value{
    dic[key] = value;
}
- (void)addDictionary:(NSDictionary *)dic{
    [self->dic addEntriesFromDictionary:dic];
}
- (NSDictionary *)map{
    return dic.copy;
}
@end
