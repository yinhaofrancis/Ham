//
//  HMBundle.h
//  Himalaya-core
//
//  Created by hao yin on 2019/7/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle(HMBundle)
-(nullable NSBundle *)resourceBundleWithName:(NSString *)name;
-(BOOL) nibExistWithName:(NSString *)name bundle:(NSBundle *)bundle;
@end

#define CurrentBundle \
[NSBundle bundleForClass:self.class] \

#define ResourceBundle(name) \
[CurrentBundle resourceBundleWithName:name] \

#define DefaultResourceBundle \
[CurrentBundle resourceBundleWithName:NSStringFromClass(self.class)] \

NS_ASSUME_NONNULL_END
