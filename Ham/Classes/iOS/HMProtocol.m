//
//  HMProtocol.m
//  Ham
//
//  Created by hao yin on 2020/4/30.
//

#import <Foundation/Foundation.h>
#import "HMProtocol.h"
#import <Ham/Ham.h>
inline UIViewController* HMGetController(NSString * name,NSDictionary * param,handleControllerCallback callback) {
    return [InstantProtocol(HMControllerManager) dequeueViewController:name param:param handle:callback];
}


inline BOOL HMShowRoute(NSString * name,NSDictionary  * _Nullable  param,handleControllerCallback _Nullable callback){
    return [InstantProtocol(HMControllerManager) showRoute:name withParam:param callback:callback];
}

inline UIViewController* HMGetControllerWithContext(NSString * name,NSDictionary  * _Nullable  param,id<HMControllerCallback> context){
    return [InstantProtocol(HMControllerManager) dequeueViewController:name param:param context:context];
}

inline BOOL HMShowRoutePresent(NSString * name,NSDictionary  * _Nullable  param,UIWindow* window ,handleControllerCallback _Nullable callback){
    return [InstantProtocol(HMControllerManager) showRoutePresent:name withParam:param inWindow:window callback:callback];
}
inline BOOL HMShowRoutePresentMainWindow(NSString * name,NSDictionary  * _Nullable  param,handleControllerCallback _Nullable callback) {
    return [InstantProtocol(HMControllerManager) showRoutePresent:name withParam:param inWindow:UIApplication.sharedApplication.windows.firstObject callback:callback];
}
