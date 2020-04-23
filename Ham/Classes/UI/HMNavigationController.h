//
//  HMNavigationViewController.h
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/15.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMWindowManager.h"
#import "HMProtocol.h"
NS_ASSUME_NONNULL_BEGIN
@protocol HMNavigationAnimation <NSObject>

- (void)animationfromView:(UIView *)fromView
                   toView:(UIView*)toView
                container:(UIView *)containerView
                 complete:(void(^)(BOOL))handle;

- (NSTimeInterval)animationDuring;

-(void)loadInteactiveAtViewController:(UIViewController *)viewController;

@property (nonatomic, assign)BOOL isInteractive;

@property (nonatomic, strong)id<UIViewControllerInteractiveTransitioning> interactive;

@property (nonatomic, assign)BOOL isAnimation;


@end


@protocol HMNavigationDisplay <NSObject>

-(BOOL)showNavigationBar;

-(BOOL)needSysPanback;

@optional
- (nullable UIImage *)navigationBarBackgroundImage;

- (nullable UIImage *)navigationBarShadowImage;

- (nullable UIColor *)navigationBarTintColor;

- (nullable UIColor *)navigationBarBackgoundColor;

- (nullable UIBarButtonItem *)backItem;

- (BOOL) isTranslucent;

@end

@interface HMNavigationAnimationTransitioningObject : NSObject<UIViewControllerAnimatedTransitioning>

@property (nullable,nonatomic) id<HMNavigationAnimation> animationObject;


@end

@interface HMNavigationController : UINavigationController<HMWindowObject,HMParamController>

- (void)loadNavigationPropertyAtWill:(UIViewController<HMNavigationDisplay> *)display animation:(BOOL)animated;

- (void)loadNavigationPropertyAtDid:(UIViewController<HMNavigationDisplay> *)display;

@property (nonatomic,nullable) UIBarButtonItem* backButton;
@end

NS_ASSUME_NONNULL_END
