//
//  HMProtocol.m
//  Ham
//
//  Created by hao yin on 2020/4/30.
//

#import <Foundation/Foundation.h>
#import "HMProtocol.h"
#import <Ham/Ham.h>
UIViewController* HMGetController(NSString * name,NSDictionary * param,handleControllerCallback callback) {
    return [InstantProtocol(HMControllerManager) dequeueViewController:name param:param handle:callback];
}


BOOL HMShowRoute(NSString * name,NSDictionary  * _Nullable  param,handleControllerCallback _Nullable callback){
    return [InstantProtocol(HMRouterController) showRoute:name withParam:param callback:callback];
}

UIViewController* HMGetControllerWithContext(NSString * name,NSDictionary  * _Nullable  param,id<HMControllerCallback> context){
    return [InstantProtocol(HMControllerManager) dequeueViewController:name param:param context:context];
}