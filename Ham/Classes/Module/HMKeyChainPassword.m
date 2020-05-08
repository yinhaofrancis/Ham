//
//  HMKeyChainPassword.m
//  test
//
//  Created by hao yin on 2020/5/8.
//  Copyright © 2020 hao yin. All rights reserved.
//

#import "HMKeyChainPassword.h"

@implementation HMKeyChainPassword
- (instancetype)initWithService:(NSString *)service account:(NSString *)account group:(NSString *)group
{
    self = [super init];
    if (self) {
        _service = [service copy];
        _account = [account copy];
        _group = [group copy];
    }
    return self;
}
- (BOOL)savePassword{
    NSMutableDictionary* query = [self contentDictionary];
   
    if(self.hasPassword){
        NSMutableDictionary * data = [NSMutableDictionary new];
        data[(NSString *)kSecValueData] = self.password;
        OSStatus st = SecItemUpdate((CFDictionaryRef)query,(CFDictionaryRef)data);
        if(st == errSecSuccess){
            return true;
        }
        return false;
    }else{
        OSStatus st = SecItemAdd((CFDictionaryRef)query, nil);
        if(st == errSecSuccess){
            return true;
        }
        return false;
    }
}
- (void)queryPassword{
    NSMutableDictionary* query = [self contentDictionary];
    query[(NSString *)kSecMatchLimit] = (id)kSecMatchLimitOne;
    query[(NSString *)kSecReturnAttributes] = (id)kCFBooleanTrue;
    query[(NSString *)kSecReturnData] = (id)kCFBooleanTrue;
    CFDictionaryRef re;
    OSStatus st = SecItemCopyMatching((CFDictionaryRef)query, (CFTypeRef *)(&re));
    if(st == errSecSuccess){
        self.password = (__bridge NSData * _Nonnull)(CFDictionaryGetValue(re, kSecValueData));
    }
}
- (void)cleanPassword{
    NSMutableDictionary* query = [self contentDictionary];
     OSStatus st = SecItemDelete((CFDictionaryRef)query);
    if(st == errSecSuccess){
        
    }
}
- (BOOL)hasPassword{
    NSMutableDictionary* query = [self contentDictionary];
    query[(NSString *)kSecMatchLimit] = (id)kSecMatchLimitOne;
    query[(NSString *)kSecReturnAttributes] = (id)kCFBooleanTrue;
    CFDictionaryRef re;
    
    OSStatus st = SecItemCopyMatching((CFDictionaryRef)query, (CFTypeRef *)(&re));
    if(st == errSecItemNotFound){
        return false;
    }
    if(st == noErr){
        return true;
    }
    return false;
}
-(NSMutableDictionary *)contentDictionary{
    NSMutableDictionary* query = [NSMutableDictionary new];
    query[(NSString *)kSecClass] = (id)kSecClassGenericPassword;
    query[(NSString *)kSecAttrService] = _service;

    if (self.account.length > 0) {
        query[(NSString *)kSecAttrAccount] = _account;
    }

    if (self.group.length > 0) {
        query[(NSString *)kSecAttrAccessGroup] = _group;
    }
    if(self.password.length > 0){
        query[(NSString *)kSecValueData] = self.password;
    }
    return query;
}
@end
