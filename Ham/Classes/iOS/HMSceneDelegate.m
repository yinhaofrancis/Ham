//
//  HMSceneDelegate.m
//  Ham
//
//  Created by hao yin on 2020/3/23.
//

#import "HMSceneDelegate.h"

@implementation HMSceneDelegate
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions API_AVAILABLE(ios(13.0)){
    if(!self.windowManager){
        self.windowManager = InstantProtocol(HMWindowManager);
    }
    if([scene isKindOfClass:UIWindowScene.class]){
        [self.windowManager showWindow:self withUIWindowScene:(UIWindowScene *)scene];
    }
    self.window = self.windowManager.currentwindow;
}
- (UIViewController *)rootVC{
    NSString* name = [HMEnv.shared readConfig:@"rootVC"];
    if(name.length == 0){
        name = @"rootVC";
    }
    UIViewController* v = HMGetController(name,nil,nil);
    if(v){
        return v;
    }else{
        return HMGetController(@"",nil,nil);
    }
}
- (BOOL)showKeyWindow{
    return true;
}

@synthesize manager;

@end
