//
//  HMJSObject.m
//  chufeng
//
//  Created by KnowChat02 on 2019/7/1.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMJSObject.h"

@implementation HMJSObject
@synthesize functionName = _functionName;
- (instancetype)initWithNaiveFuntionName:(NSString *)name callback:(NaiveFunction)function {
    self = [super init];
    if (self) {
        _functionName = name;
        _naiveFuncCallBack = function;
    }
    return self;
}
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    if(_naiveFuncCallBack){
        _naiveFuncCallBack(userContentController,message);
    }
}

@end
