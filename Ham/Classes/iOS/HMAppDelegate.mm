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

@implementation HMAppDelegate{
    NSMutableDictionary<NSString*,id> * componentInst;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.launchOption = launchOptions;
    
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    if([HMModuleManager.shared getInstanceByProtocol:@protocol(HMRemoteNotification)]){
        [InstantProtocol(HMRemoteNotification) config];
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
    return YES;
}

- (UIViewController *)rootVC{
    NSString* name = [HMEnv.shared readConfig:@"rootVC"];
    if(name.length == 0){
        name = @"rootVC";
    }
    UIViewController* v = HMGetController(name);
    if(v){
        return v;
    }else{
        return HMGetController(@"");
    }
}

- (UIWindow *)window{
    return self.windowManager.currentwindow;
}

//+ (void)initialize {
//    if([InstantProtocol(HMOpenUrl) respondsToSelector:@selector(openURL:option:)]){
//        [HMOCRunTimeTool classImplamentProtocol:@protocol(UIApplicationDelegate) selector:@selector(application:openURL:options:) toClass:self imp:^(id a,UIApplication* app,NSURL* url,NSDictionary<UIApplicationOpenURLOptionsKey,id> *options){
//            return [InstantProtocol(HMOpenUrl) openURL:url option:options];
//        }];
//    }
//    id<HMBackgroundFetch> a = InstantProtocol(HMBackgroundFetch);
//    if([a respondsToSelector:@selector(handleFetch:)]){
//        [HMOCRunTimeTool classImplamentProtocol:@protocol(UIApplicationDelegate) selector:@selector(application:performFetchWithCompletionHandler:) toClass:self imp:^(id s, UIApplication* app,void (^completionHandler)(UIBackgroundFetchResult) ){
//            [InstantProtocol(HMBackgroundFetch) handleFetch:completionHandler];
//        }];
//    }
//    if([InstantProtocol(HMRemoteNotification) respondsToSelector:@selector(handleToken:)]){
//        [HMOCRunTimeTool classImplamentProtocol:@protocol(UIApplicationDelegate) selector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:) toClass:self imp:^(id s, UIApplication* app,NSData* deviceToken){
//            [InstantProtocol(HMRemoteNotification) handleToken:deviceToken];
//        }];
//    }
//    if([InstantProtocol(HMRemoteNotification) respondsToSelector:@selector(handleRemoteNotification:)]){
//        [HMOCRunTimeTool classImplamentProtocol:@protocol(UIApplicationDelegate) selector:@selector(application:didReceiveRemoteNotification:) toClass:self imp:^(id s,UIApplication* app ,NSDictionary* userInfo){
//            [InstantProtocol(HMRemoteNotification) handleRemoteNotification:userInfo];
//        }];
//    }
//    if([InstantProtocol(HMRemoteNotification) respondsToSelector:@selector(handleLocalNotification:)]){
//        [HMOCRunTimeTool classImplamentProtocol:@protocol(UIApplicationDelegate) selector:@selector(application:didReceiveLocalNotification:) toClass:self imp:^(id s,UIApplication *app,UILocalNotification *notification){
//            [InstantProtocol(HMRemoteNotification) handleLocalNotification:notification];
//        }];
//    }
//    if([InstantProtocol(HMRemoteNotification) respondsToSelector:@selector(didFailToRegisterForRemoteNotificationsWithError:)]){
//        [HMOCRunTimeTool classImplamentProtocol:@protocol(UIApplicationDelegate) selector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:) toClass:self imp:^(id s,UIApplication *app,NSError * e){
//            [InstantProtocol(HMRemoteNotification) didFailToRegisterForRemoteNotificationsWithError:e];
//        }];
//    }
////    didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//    if (@available(iOS 10.0, *)) {
//        if([InstantProtocol(HMRemoteNotification) respondsToSelector:@selector(willPresentNotification:withCompletionHandler:)]){
//            [HMOCRunTimeTool classImplamentProtocol:@protocol(UNUserNotificationCenterDelegate) selector:@selector(userNotificationCenter:willPresentNotification:withCompletionHandler:) toClass:self imp:^(id self,UNUserNotificationCenter* center,void (^completionHandler)(UNNotificationPresentationOptions)){
//
//            }];
//        }
//        if([InstantProtocol(HMRemoteNotification) respondsToSelector:@selector(didReceiveNotificationResponse:withCompletionHandler:)]){
//
//            [HMOCRunTimeTool classImplamentProtocol:@protocol(UNUserNotificationCenterDelegate) selector:@selector(userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:) toClass:self imp:^(id s,UNUserNotificationCenter* center,UNNotificationResponse * response,void (^completionHandler)(void)){
//                [InstantProtocol(HMRemoteNotification) didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
//            }];
//        }
//    }
//    if (@available(iOS 13.0, *)) {
//        if([InstantProtocol(HMSceneProtocol) respondsToSelector:@selector(configurationForConnectingSceneSession:options:)]){
//            [HMOCRunTimeTool classImplamentProtocol:@protocol(UIApplicationDelegate) selector:@selector(application:configurationForConnectingSceneSession:options:) toClass:self imp:^(id s,UIApplication *app,UISceneSession * connectingSceneSession,UISceneConnectionOptions * option){
//                [InstantProtocol(HMSceneProtocol) configurationForConnectingSceneSession:connectingSceneSession options:option];
//            }];
//        }
//        if([InstantProtocol(HMSceneProtocol) respondsToSelector:@selector(didDiscardSceneSessions:)]){
//            [HMOCRunTimeTool classImplamentProtocol:@protocol(UIApplicationDelegate) selector:@selector(application:didDiscardSceneSessions:) toClass:self imp:^(id s,UIApplication *app,NSSet<UISceneSession *> * sessions){
//                [InstantProtocol(HMSceneProtocol) didDiscardSceneSessions:sessions];
//            }];
//        }
//    }
    
    
//}【【。；。；

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


