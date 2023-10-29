//
//  AppDelegate.m
//  example
//
//  Created by wenyang on 2023/10/30.
//

#import "AppDelegate.h"
#import "Constance.h"
@import Ham;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    //獲取VC
    self.window.rootViewController = HMGetController(NAVIGATOR, nil, nil);
    [self.window makeKeyAndVisible];
    //單純展示VC
    HMShowRoute(TESTVC, nil, nil);
    return YES;
}

@end
