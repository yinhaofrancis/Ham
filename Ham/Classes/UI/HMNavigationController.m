//
//  HMNavigationViewController.m
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/15.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMNavigationController.h"
#import "HMViewController.h"
#import "HMProtocol.h"

@interface HMNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic,nonnull)HMNavigationAnimationTransitioningObject *pushAnimation;
@property (nonatomic,nonnull)HMNavigationAnimationTransitioningObject *popAnimation;
@property (nonatomic,copy) void(^call)(void);
@end

@implementation HMNavigationController

@synthesize param = _param;

#pragma mark - init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.delegate = self;
    }
    return self;
}
- (instancetype)initWithParam:(NSDictionary *)param{
    self = [super init];
    if(self){
        _param = param;
        [self handleParam:param];
    }
    return self;
}
#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    if (@available(iOS 11.0, *)) {
        self.navigationBar.prefersLargeTitles = false;
    } else {
        // Fallback on earlier versions
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadNavigationPropertyAtDid:(UIViewController<HMNavigationDisplay> *)self.topViewController];
    [self loadNavigationPropertyAtWill:(UIViewController<HMNavigationDisplay> *)self.topViewController animation:animated];
}


#pragma mark - process navigation
-(void)loadNavigationPropertyAtDid:(UIViewController<HMNavigationDisplay> *)display{
    display.navigationItem.backBarButtonItem = self.backButton;
    if([display respondsToSelector:@selector(needSysPanback)]){
        
        if(self.childViewControllers.count > 1){
            self.interactivePopGestureRecognizer.delegate = (id)display;
            self.interactivePopGestureRecognizer.enabled = display.needSysPanback;
        }else{
            self.interactivePopGestureRecognizer.delegate = nil;
            self.interactivePopGestureRecognizer.enabled = false;
        }
    }
    if([display respondsToSelector:@selector(navigationBarBackgroundImage)]){
        UIImage *img = display.navigationBarBackgroundImage;
        if(img != nil){
            [self.navigationBar setBackgroundImage:img  forBarMetrics:UIBarMetricsDefault];
            [self.navigationBar setBackgroundImage:img  forBarMetrics:UIBarMetricsCompact];
            [self.navigationBar setBackgroundImage:img  forBarMetrics:UIBarMetricsCompactPrompt];
            [self.navigationBar setBackgroundImage:img  forBarMetrics:UIBarMetricsDefaultPrompt];
        }
        
    }
    if([display respondsToSelector:@selector(navigationBarShadowImage)]){
        UIImage *img = display.navigationBarShadowImage;
        if(img != nil){
            self.navigationBar.shadowImage = img;
        }
        
    }
    if([display respondsToSelector:@selector(navigationBarTintColor)]){
        UIColor *img = display.navigationBarTintColor;
        if(img != nil){
            self.navigationBar.tintColor = img;
        }
        
        
    }
    if([display respondsToSelector:@selector(navigationBarBackgoundColor)]){
        UIColor *img = display.navigationBarBackgoundColor;
        if(img != nil){
            self.navigationBar.barTintColor = img;
        }
        
    }
    if([display respondsToSelector:@selector(isTranslucent)]){
        self.navigationBar.translucent = [display isTranslucent];
    }
}
-(void)loadNavigationPropertyAtWill:(UIViewController<HMNavigationDisplay> *)display animation:(BOOL)animated{
    if([display respondsToSelector:@selector(showNavigationBar)]){
        [self setNavigationBarHidden:!display.showNavigationBar animated:animated];
    }
}
- (id<UIViewControllerAnimatedTransitioning>)pushVCNavibarManager:(UIViewController *)toVC{
    if([toVC conformsToProtocol:@protocol(HMNavigationDisplay)]){
        HMViewController* showVC = (HMViewController *)toVC;
        
        if ([showVC needSysPanback]){
            return nil;
        }
        if([showVC respondsToSelector:@selector(pushAnimation)]){
            self.pushAnimation.animationObject = showVC.pushAnimation;
        }
        if([showVC respondsToSelector:@selector(popAnimation)]){
            [showVC.popAnimation loadInteactiveAtViewController:showVC];
        }
        if(self.pushAnimation.animationObject && showVC.pushAnimation.isAnimation){
            return self.pushAnimation;
        }
    }
    return nil;
}
- (id<UIViewControllerAnimatedTransitioning>)popVCNavibarManager:(UIViewController *)fromVC{
    if([fromVC conformsToProtocol:@protocol(HMNavigationDisplay)]){
        HMViewController* showVC = (HMViewController *)fromVC;
        if ([showVC needSysPanback]){
            return nil;
        }
        self.popAnimation.animationObject = showVC.popAnimation;
        if(self.popAnimation.animationObject && showVC.popAnimation.isAnimation){
            return self.popAnimation;
        }
    }
    return nil;
}
- (void)handleParam:(NSDictionary *)param{
    
}
- (nonnull UIViewController *)viewController {
    return self;
}

@synthesize manager;

- (nonnull UIViewController *)rootVC {
    return self;
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    switch (operation) {
        case UINavigationControllerOperationPush:
            [self pushVCNavibarManager:toVC];
            break;
        case UINavigationControllerOperationPop:
            [self popVCNavibarManager:fromVC];
            break;
        default:
            break;
    }
    return nil;
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController<HMNavigationDisplay> *display = (id)viewController;
    [self loadNavigationPropertyAtDid:display];
    if(self.call){
        self.call();
    }
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController<HMNavigationDisplay> *display = (id)viewController;
    [self loadNavigationPropertyAtWill:display animation:animated];
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if(_popAnimation.animationObject.isInteractive && _popAnimation.animationObject.interactive){
        return _popAnimation.animationObject.interactive;
    }
    return nil;
}
#pragma mark - set get
- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate{
    if(delegate == self){
        super.delegate = delegate;
    }
}
@end

@implementation HMNavigationAnimationTransitioningObject
- (void)setAnimationObject:(id<HMNavigationAnimation>)animationObject{
    if([animationObject respondsToSelector:@selector(animationfromView:toView:container:complete:)]){
        _animationObject = animationObject;
    }
}
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return self.animationObject.animationDuring;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView* toview = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView* fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [transitionContext.containerView addSubview:fromView];
    [transitionContext.containerView addSubview:toview];
    [self.animationObject animationfromView:fromView
                                     toView:toview
                                  container:transitionContext.containerView 
                                   complete:^(BOOL flag) {
                                       toview.transform = CGAffineTransformIdentity;
                                       fromView.transform = CGAffineTransformIdentity;
                                    [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
