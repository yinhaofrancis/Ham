//
//  HMAlertViewController.m
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/13.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMPopupController.h"


@implementation  HMPopupController{
    id<HMPopupConfigure> config;
    id<HMPopupModel> infomation;
}

- (instancetype)initWithConfigure:(id<HMPopupConfigure>)configure infomation:(id<HMPopupModel>)info {
    self = [super init];
    if (self) {
        config = configure;
        infomation = info;
        config.viewController = self;
    }
    return self;
}
- (void)loadView{
    if([config respondsToSelector:@selector(container)]){
        self.view = [config container];
    }else{
        self.view = [[UIView alloc] init];
    }
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [config displayDialog:self.view infomation:config.infoObject];
}
- (void)hideAnimation:(nonnull HMWindow *)window complete:(nonnull void (^)(BOOL))handle {
    [config hideAnimationComplete:handle];
}

- (void)showAnimation:(nonnull HMWindow *)window complete:(nonnull void (^)(BOOL))handle {
    [self.view layoutIfNeeded];
    [config showAnimationComplete:handle];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{

    HMPopupPresentAnimation* animation = [[HMPopupPresentAnimation alloc] init];
    animation.isPresnet = true;
    animation.configure = config;
    return animation;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    HMPopupPresentAnimation* animation = [[HMPopupPresentAnimation alloc] init];
    animation.isPresnet = false;
    animation.configure = config;
    return animation;
}
@synthesize manager;

- (UIViewController *)rootVC{
    return self;
}

@end

@implementation HMPopupPresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    if(self.isPresnet){
        return [self.configure showAnimationDuring];
    }else{
        return [self.configure hidenAnimationDuring];
    }
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if(self.isPresnet){
        UIView* from = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView* to = [transitionContext viewForKey:UITransitionContextToViewKey];
        [transitionContext.containerView addSubview:from];
        [transitionContext.containerView addSubview:to];
//        from.frame = UIScreen.mainScreen.bounds;
//        to.frame = UIScreen.mainScreen.bounds;
        [self edge:from container:transitionContext.containerView];
        [self edge:to container:transitionContext.containerView];
        [from layoutIfNeeded];
        [to layoutIfNeeded];
        [self.configure showAnimationComplete:^(BOOL b) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }else{
        UIView* from = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView* to = [transitionContext viewForKey:UITransitionContextToViewKey];
        [transitionContext.containerView addSubview:from];
        [transitionContext.containerView addSubview:to];
//        from.frame = UIScreen.mainScreen.bounds;
//        to.frame = UIScreen.mainScreen.bounds;
        [self edge:from container:transitionContext.containerView];
        [self edge:to container:transitionContext.containerView];
        [self.configure hideAnimationComplete:^(BOOL b) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}

-(void)edge:(UIView *)view container:(UIView *)container{
    if(!view || !container){
        return;
    }
    view.translatesAutoresizingMaskIntoConstraints = false;
//    container.translatesAutoresizingMaskIntoConstraints = false;
    NSArray<NSLayoutConstraint *> * cons = @[
    [view.leftAnchor constraintEqualToAnchor:container.leftAnchor],
//    [view.rightAnchor constraintEqualToAnchor:container.rightAnchor],
//    [view.bottomAnchor constraintEqualToAnchor:container.bottomAnchor],
    [view.topAnchor constraintEqualToAnchor:container.topAnchor],
    ];
    [container addConstraints:cons];
    cons = @[
             [view.widthAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width],
             //    [view.rightAnchor constraintEqualToAnchor:container.rightAnchor],
             //    [view.bottomAnchor constraintEqualToAnchor:container.bottomAnchor],
             [view.heightAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.height],
             ];
    [view addConstraints:cons];
    
}

@end


