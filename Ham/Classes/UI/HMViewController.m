//
//  HMViewController.m
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/14.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMViewController.h"

@interface HMViewController ()

@end

@implementation HMViewController

@synthesize param = _param;
- (instancetype)initWithParam:(NSDictionary *)param{
    self = [super init];
    if(self){
        _param = param;
        [self handleParam:param];
    }
    return self;
}

- (void)handleParam:(nonnull NSDictionary *)param {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (UIViewController *)viewController{
    return self;
}

- (BOOL)showNavigationBar {
    return true;
}
- (BOOL)needSysPanback{
    return true;
}
@end

@implementation HMNavigationPushAnimationObject

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isAnimation = true;
    }
    return self;
}
- (NSTimeInterval)animationDuring{
    return 0.3;
}
- (void)animationfromView:(UIView *)fromView
                   toView:(UIView *)toView
                container:(UIView *)containerView
                 complete:(void (^)(BOOL))handle{
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    toView.transform = CGAffineTransformMakeTranslation(0, UIScreen.mainScreen.bounds.size.height);
    [UIView animateWithDuration:self.animationDuring delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        handle(finished);
    }];
}
@synthesize interactive;

@synthesize isAnimation;

@synthesize isInteractive;

-(void)loadInteactiveAtViewController:(UIViewController *)viewController{
    
}
@end
@implementation HMNavigationPopAnimationObject{
    __weak UIViewController* vc;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isAnimation = true;
    }
    return self;
}

- (NSTimeInterval)animationDuring{
    return 0.3;
}
- (void)animationfromView:(UIView *)fromView
                   toView:(UIView *)toView
                container:(UIView *)containerView
                 complete:(void (^)(BOOL))handle{
    
    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    UIViewAnimationOptions option;
    if(self.isInteractive){
        option = UIViewAnimationOptionCurveLinear;
    }else{
        option = UIViewAnimationOptionCurveEaseInOut;
    }
    toView.transform =  CGAffineTransformMakeScale(0.9, 0.9);
    [UIView animateWithDuration:self.animationDuring delay:0 options:option animations:^{
        fromView.transform = CGAffineTransformMakeTranslation(0, UIScreen.mainScreen.bounds.size.height);
        toView.transform = CGAffineTransformIdentity;
    } completion:handle];
}
@synthesize interactive;

@synthesize isAnimation;

@synthesize isInteractive;

-(void)loadInteactiveAtViewController:(UIViewController *)viewController{
    if(!self.pan){
        self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        self.interactive = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    [viewController.view addGestureRecognizer:self.pan];
    vc = viewController;
}
-(void)handlePan:(UIPanGestureRecognizer *)pan{
    static CGPoint start;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.isInteractive = true;
            [vc.navigationController popViewControllerAnimated:true];
            start = [pan locationInView:vc.view.window];
            break;
        case UIGestureRecognizerStateChanged:{
            CGPoint current = [pan locationInView:vc.view.window];
            CGFloat percent = (current.y - start.y) / UIScreen.mainScreen.bounds.size.height;
            [self.interactive updateInteractiveTransition:percent];
            break;
        }
        case UIGestureRecognizerStateEnded:{
            CGPoint current = [pan locationInView:vc.view.window];
            CGPoint speed = [pan velocityInView:vc.view.window];
            CGFloat percent = (current.y - start.y) / UIScreen.mainScreen.bounds.size.height;
            if(percent > 0.5 || (speed.y > 500 && speed .y > speed.x)){
                [self.interactive finishInteractiveTransition];
            }else{
                [self.interactive cancelInteractiveTransition];
            }
        }
            self.isInteractive = false;
            break;
        default:
            self.isInteractive = false;
            [self.interactive cancelInteractiveTransition];
            break;
    }
}
@end
