//
//  HMAppDelegate.m
//  Ham
//
//  Created by yinhaofrancis on 07/24/2019.
//  Copyright (c) 2019 yinhaofrancis. All rights reserved.
//

#import "HMAppDelegate.h"
#import "Ham.h"
#import "HMOCRunTimeTool.h"
#import "HMProtocol.h"
@implementation HMAppDelegate{
    NSMutableDictionary<NSString*,id> * componentInst;
    UIBackgroundTaskIdentifier _backgroundId;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.launchOption = launchOptions;
    
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    if (@available(iOS 13.0, *)) {
        Class cls = UIApplication.sharedApplication.openSessions.allObjects.firstObject.configuration.delegateClass;
        if(cls == nil){
            if(!self.windowManager){
                self.windowManager = InstantProtocol(HMWindowManager);
                self.windowManager.level = 0;
            }
            [self.windowManager showWindow:self withCurrentWindow:nil];
        }
    }else{
        if(!self.windowManager){
            self.windowManager = InstantProtocol(HMWindowManager);
            self.windowManager.level = 0;
        }
        [self.windowManager showWindow:self withCurrentWindow:nil];
    }
    id<HMBackgroundFetch> fetchConfig = InstantProtocol(HMBackgroundFetch);
    if(fetchConfig){
        [UIApplication.sharedApplication setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    }
    for (NSString* key in componentInst) {
        if([componentInst[key] respondsToSelector:_cmd]){
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [componentInst[key] performSelector:_cmd withObject:application withObject:launchOptions];
            #pragma clang diagnostic pop
        }
    }
    return YES;
}
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
//
//}
- (UIViewController *)rootVC{
    NSString* name = [HMEnv.shared readConfig:@"rootVC"];
    if(name.length == 0){
        name = @"rootVC";
    }
    UIViewController* v = HMGetController(name, nil, nil);
    if(v){
        return v;
    }else{
        return HMGetController(@"",nil,nil);
    }
}

- (UIWindow *)window{
    return self.windowManager.currentwindow;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    _backgroundId = [application beginBackgroundTaskWithExpirationHandler:^{
        
    }];
}
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [application endBackgroundTask:_backgroundId];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _components = [[HMAnotationStorage shared] getEnvConfigByName:@"HMComponent"];
        componentInst = [[NSMutableDictionary alloc] init];
        for (NSString * k in self.components) {
            componentInst[k] = [[NSClassFromString(self.components[k]) alloc] init];
        }
    }
    return self;
}
- (BOOL)respondsToSelector:(SEL)aSelector{
    for (NSString * v in componentInst) {
        BOOL b = [componentInst[v] respondsToSelector:aSelector];
        if(b){
            return b;
        }
    }
    return [super respondsToSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    for (NSString * v in componentInst) {
        BOOL b = [componentInst[v] respondsToSelector:anInvocation.selector];
        if(b){
            [anInvocation invokeWithTarget:componentInst[v]];
            if(strcmp(anInvocation.methodSignature.methodReturnType, "v") == 0){
                continue;
            }else{
                break;
            }
        }
    }
}
+ (HMAppDelegate *)runingDelegate{
    id delegate = UIApplication.sharedApplication.delegate;
    if([delegate isKindOfClass:HMAppDelegate.class]){
        return delegate;
    }
    return nil;
}
- (BOOL)showKeyWindow{
    return true;
}
@synthesize manager;

@end


