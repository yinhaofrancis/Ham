//
//  HMKeyChainPassword.h
//  test
//
//  Created by hao yin on 2020/5/8.
//  Copyright © 2020 hao yin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMKeyChainPassword : NSObject
@property (nonatomic,readonly) NSString *service;
@property (nonatomic,readonly) NSString *account;
@property (nonatomic,readonly) NSString *group;
@property (nonatomic,copy) NSData *password;
@property (nonatomic,readonly) BOOL hasPassword;
- (instancetype)initWithService:(NSString *)service account:(nullable NSString *)account group:(nullable NSString *)group;

- (BOOL)savePassword;
- (void)queryPassword;
- (void)cleanPassword;
@end

NS_ASSUME_NONNULL_END
