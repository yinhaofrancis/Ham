//
//  HMAppDelegate.h
//  Ham
//
//  Created by yinhaofrancis on 07/24/2019.
//  Copyright (c) 2019 yinhaofrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMWindowManager.h"
#import "HMWindow.h"
#import "HMComponent.h"
#import <UserNotifications/UserNotifications.h>
NS_ASSUME_NONNULL_BEGIN
@interface HMAppDelegate : UIResponder <UIApplicationDelegate,HMWindowObject,UNUserNotificationCenterDelegate>

@property (strong, nonatomic ,nonnull) UIWindow *window;

@property(nonatomic,copy) NSDictionary* launchOption;

@property (strong, nonatomic) id<HMWindowManager> windowManager;

@property (nonatomic,readonly) NSDictionary *components;

+(nullable HMAppDelegate *)runingDelegate;

@end
NS_ASSUME_NONNULL_END
