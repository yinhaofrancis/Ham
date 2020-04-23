//
//  HMSceneDelegate.h
//  Ham
//
//  Created by hao yin on 2020/3/23.
//

#import <UIKit/UIKit.h>
#import <Ham/Ham.h>
NS_ASSUME_NONNULL_BEGIN

@interface HMSceneDelegate : NSObject<UIWindowSceneDelegate,HMWindowObject>
@property (strong, nonatomic) id<HMWindowManager> windowManager;
@property (strong, nonatomic ,nonnull) UIWindow *window;

@end

NS_ASSUME_NONNULL_END
