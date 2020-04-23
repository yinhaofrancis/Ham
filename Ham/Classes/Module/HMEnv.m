//
//  HMEnv.m
//  Ham
//
//  Created by hao yin on 2020/3/19.
//

#import "HMEnv.h"
#import "HMAnotationStorage.h"
@implementation HMEnv

- (NSString *)readConfig:(NSString *)configKey{
    return [HMAnotationStorage.shared getEnvConfigByName:@"HMEnv"][configKey];
}

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    static HMEnv *env;
    dispatch_once(&onceToken, ^{
        env = [HMEnv new];
    });
    return env;
}

@end
