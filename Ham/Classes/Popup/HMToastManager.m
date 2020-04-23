//
//  HMToastManager.m
//  Himalaya
//
//  Created by hao yin on 2019/6/17.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMToastManager.h"
#import "HMView.h"
#import "HMAnnotation.h"
#import "HMWindowManager.h"
#import "HMContentController.h"
#import "HMModuleManager.h"
#import "HMAnotationStorage.h"
#import "UI.h"
@HMService(HMToastManager, HMToastManagerImp)


@implementation HMToastManagerImp{
    id<HMWindowManager> window;
    UIStackView* stack;
}
+(HMModuleMemoryType)memoryType{
    return HMModuleSinglten;
}

+(instancetype)shared{
    return instant(HMToastManagerImp, HMToastManager);
}
- (void)requestQuery:(NSDictionary *)param{
    if (param[ToastKey]){
        [self showToast:param[ToastKey]];
    }
}
- (void)showToast:(id<HMToastModel>)toast{
    NSDictionary* toastDic = [HMAnotationStorage.shared getDicByName:HMSectToastKey];
    Class cls = NSClassFromString(toastDic[NSStringFromClass(toast.class)]);
    id<HMToastConfigure> config = [[cls alloc] init];
    
    [UIView generateInstanceWithName:toast.nibName bundle:toast.nibBundle owner:config injectContent:nil];
    if(config.container == nil){
        NSBundle * b = [NSBundle bundleForClass:self.class];
        [UIView generateWithName:toast.nibName bundle:[b resourceBundleWithName:@"popup"]  owner:config injectContent:nil];
    }
    if(config.container == nil){
        NSBundle * b = [NSBundle bundleForClass:self.class];
        [UIView generateWithName:@"Toast" bundle:[b resourceBundleWithName:@"popup"]  owner:config injectContent:nil];
    }
    [self generateWindow];
    [stack addSubview:config.container];
    [stack addArrangedSubview:config.container];
    [config displayModel:toast];
    NSTimeInterval time = -1;
    if ([toast respondsToSelector:@selector(delayTime)]){
        time = toast.delayTime;
    }
    if(time > 0){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(toast.delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self->stack removeArrangedSubview:config.container];
            [config.container removeFromSuperview];
            if(self->stack.arrangedSubviews.count == 0){
                self->window.currentwindow.hidden = true;
            }
        });
    }
    
}

- (void)generateWindow{
//    window = InstantProtocol(HMWindowManager);
    window.level = UIWindowLevelStatusBar - 1;
    window.currentwindow.hidden = false;
    if(!stack){
        stack = [[UIStackView alloc] init];
        UIView * view = [[UIView alloc] init];
        stack.axis = UILayoutConstraintAxisVertical;
        stack.alignment = UIStackViewAlignmentCenter;
        stack.distribution = UIStackViewDistributionEqualSpacing;
        stack.spacing = 8;
        [view addSubview:stack];
        stack.translatesAutoresizingMaskIntoConstraints = false;
        view.translatesAutoresizingMaskIntoConstraints = false;
        [view addConstraint:[stack.leftAnchor constraintEqualToAnchor:view.leftAnchor constant:20]];
        [view addConstraint:[stack.rightAnchor constraintEqualToAnchor:view.rightAnchor constant:-20]];
        if (@available(iOS 11.0, *)) {
            //        [view addConstraint:[stack.topAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.topAnchor constant:96]];
            [view addConstraint:[stack.bottomAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.bottomAnchor constant:-96]];
        } else {
            //        [view addConstraint:[stack.topAnchor constraintEqualToAnchor:view.topAnchor constant:96]];
            [view addConstraint:[stack.bottomAnchor constraintEqualToAnchor:view.bottomAnchor constant:-96]];
        }
        HMContentController* w = [[HMContentController alloc] initWithContent:view];
        [window showWindow:w];
        window.currentwindow.userInteractionEnabled = false;
    }
}
@end

@HMToast(HMToastModelObject, HMToastConfigureObject)


@implementation HMToastConfigureObject


- (void)displayModel:(nonnull HMToastModelObject *)model {
    self.label.text = model.title;
}

@synthesize container;
@end

@implementation HMToastModelObject

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle delayTime:(NSTimeInterval)time{
    self = [super init];
    if(self){
        self.nibName = name;
        self.nibBundle = bundle;
        self.delayTime = time;
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delayTime = 2;
    }
    return self;
}

@end
