//
//  HMJSConfigure.m
//  chufeng
//
//  Created by KnowChat02 on 2019/7/1.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMJSConfigure.h"

@implementation HMJSConfigure{
    NSMutableDictionary<NSString*, HMJSObject *> *jso;
}
@synthesize configure = _configure;
@dynamic JSObjects;

- (instancetype)initWithConfigure:(WKWebViewConfiguration *)configure{
    self = [super init];
    if (self) {
        _configure = configure;
        jso = [[NSMutableDictionary alloc] init];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _configure = [[WKWebViewConfiguration alloc] init];
        jso = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addJSObject:(HMJSObject *)object{
    jso[object.functionName] = object;
    [_configure.userContentController addScriptMessageHandler:object name:object.functionName];
}
- (void)removeJSObject:(HMJSObject *)object{
    [jso removeObjectForKey:object.functionName];
    [_configure.userContentController removeScriptMessageHandlerForName:object.functionName];
}
- (void)injectJSCode:(WKUserScript *)jsCode{
    [_configure.userContentController addUserScript:jsCode];
}
-(NSArray<HMJSObject *> *)JSObjects{
    return jso.allValues;
}
@end
