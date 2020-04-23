//
//  HMViewController.h
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/14.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HMNavigationController.h"
#import "HMContentController.h"
#import "HMProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface HMViewController : UIViewController<HMNavigationDisplay,HMParamController>
@property (nonatomic,nullable) id<HMNavigationAnimation> pushAnimation;
@property (nonatomic,nullable) id<HMNavigationAnimation> popAnimation;
@end

@interface HMNavigationPushAnimationObject : NSObject<HMNavigationAnimation>
@property (nonatomic, nullable) UIPercentDrivenInteractiveTransition *interactive;
@end

@interface HMNavigationPopAnimationObject : NSObject<HMNavigationAnimation>
@property (nonatomic, nullable) UIPercentDrivenInteractiveTransition *interactive;
@property (nonatomic, nullable) UIPanGestureRecognizer *pan;
@end

NS_ASSUME_NONNULL_END
