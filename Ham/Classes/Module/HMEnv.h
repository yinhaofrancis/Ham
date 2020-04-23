//
//  HMEnv.h
//  Ham
//
//  Created by hao yin on 2020/3/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


//#define HMSectEnv "HMSectEnv"
//
//#define HMDefaultConfig "HMDefaultConfig"


#define HMRegEnvConfig(key,plist) \
HMCustomAnnotationString(HMEnv, key, plist)

@interface HMEnv : NSObject

+(instancetype)shared;

-(NSString *)readConfig:(NSString *)configKey;

@end




NS_ASSUME_NONNULL_END
