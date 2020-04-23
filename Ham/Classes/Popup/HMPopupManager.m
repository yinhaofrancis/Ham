//
//  HMPopupManager.m
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/13.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMPopupManager.h"
#import "HMPopupController.h"
#import "HMView.h"
#import "HMModuleManager.h"
#import "HMAnnotation.h"
#import "HMAnotationStorage.h"
@HMService(HMPopupManager, HMPopupManagerImp)

//static NSMutableDictionary<NSString *,Class>* alertDic;
@implementation HMPopupManagerImp{
    id<HMWindowManager> alertWindow;
    NSMutableArray *mainContaier;
}

- (instancetype)init{
    self = [super init];
    if (self) {
//        alertWindow = InstantProtocol(HMWindowManager);
        mainContaier = [[NSMutableArray alloc] init];
    }
    return self;
}



- (void)showPopup:(id<HMPopupModel>)infomation{

    id<HMPopupConfigure> configure = [self genConfigure:infomation];
    if ([configure conformsToProtocol:@protocol(HMPopupConfigure)]){
        
        configure.manager = self;
        infomation.configure = configure;
        HMPopupController* alertVc = [[HMPopupController alloc] initWithConfigure:configure infomation:infomation];
        if([configure respondsToSelector:@selector(onKeyWindow)]){
            [alertWindow showKeyWindow:alertVc];
        }else{
            [alertWindow showWindow:alertVc];
        }
        if([configure respondsToSelector:@selector(windowLevel)]){
            alertWindow.level = configure.windowLevel;
        }else{
            alertWindow.level = 1;
        }
        [mainContaier addObject:alertWindow];
    }
}
-(void)popUpVC:(id<HMPopupModel>)information onContext:(UIViewController *)ctx{
    HMPopupController* alertVc = (HMPopupController *)[self createPopupVC:information];
    alertVc.transitioningDelegate = alertVc;
    alertVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [ctx presentViewController:alertVc animated:true completion:nil];
    [mainContaier addObject:alertVc];
}
- (UIViewController *)createPopupVC:(id<HMPopupModel>)model{
    id<HMPopupConfigure> configure = [self genConfigure:model];
    if ([configure conformsToProtocol:@protocol(HMPopupConfigure)]){
        
        configure.manager = self;
        model.configure = configure;
        HMPopupController* alertVc = [[HMPopupController alloc] initWithConfigure:configure infomation:model];
        return alertVc;
    }
    return HMGetController(@"");
}
- (id<HMPopupConfigure>) genConfigure:(id<HMPopupModel>)model{
    NSString* cls = NSStringFromClass(model.class);
    NSDictionary* alertDic = [HMAnotationStorage.shared getDicByName:@HMSectAlertKey];
    NSString * cclss = alertDic[cls];
    Class acls = NSClassFromString(cclss);
    id<HMPopupConfigure> configure = [[acls alloc] initWithInfomation:model];
    return configure;
}
- (IBAction)removeCurrentPopup{
    if([mainContaier.lastObject conformsToProtocol:@protocol(HMWindowManager)]){
        [alertWindow removeWindow];
        [mainContaier removeLastObject];
    }else{
        UIViewController * vc = mainContaier.lastObject;
        [vc dismissViewControllerAnimated:true completion:nil];
        [mainContaier removeLastObject];
    }
}
-(void)removeAllPendingModel{
    id last = mainContaier.lastObject;
    if(last){
        [mainContaier removeAllObjects];
        [mainContaier addObject:last];
        [alertWindow.windowObjects removeAllObjects];
    }
}
- (void)requestQuery:(NSDictionary *)param{
    if(param[PopupKey]){
        [self showPopup:param[PopupKey]];
    }
}
+ (HMModuleMemoryType)memoryType{
    return HMModuleSinglten;
}

+ (instancetype)shared{
    return instant(HMPopupManagerImp, HMPopupManager);
}

@end


@implementation HMBasePopupConfigure{
    __weak id _infoObject;
}

- (void)hideAnimationComplete:(nonnull void (^)(BOOL))handle {
    
    [UIView animateWithDuration:self.hidenAnimationDuring delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.containerView.alpha = 0;;
    } completion:handle];
}

- (void)showAnimationComplete:(nonnull void (^)(BOOL))handle {
    self.containerView.alpha = 0;
    [UIView animateWithDuration:self.showAnimationDuring delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.containerView.alpha = 1;
    } completion:handle];
}

- (UIView *)container{
    return self.containerView;
}

- (void)displayDialog:(nonnull UIView *)container infomation:(id<HMPopupModel>)infoObject{
   
}

- (instancetype)initWithInfomation:(id<HMPopupModel>)infoObject {
    self = [super init];
    if (self) {
        _infoObject = infoObject;
        _nib = [self loadView:infoObject];
    }
    return self;
}

- (nonnull id<HMPopupModel>)infoObject {
    return _infoObject;
}

- (NSTimeInterval)hidenAnimationDuring {
    return 0.3;
}

- (NSTimeInterval)showAnimationDuring {
    return 0.3;
}

- (UINib *)loadView:(id<HMPopupModel>)infoObject{
    NSString* name = NSStringFromClass(self.class);
    if([infoObject respondsToSelector:@selector(nibName)] && infoObject.nibName.length > 0){
        name = infoObject.nibName;
    }
    NSBundle *bundle = [NSBundle mainBundle];
    if([infoObject respondsToSelector:@selector(nibBundle)] && infoObject.nibBundle != nil){
         bundle = infoObject.nibBundle;
    }
    UINib* nib = [HMView generateWithName:name
                                   bundle:bundle
                                    owner:self
                            injectContent:@{@"PopupManager":HMPopupManagerImp.shared,
                                            @"PopupModel":_infoObject
                                            }];
    if(!self.view){
        self.view = [[UIView alloc] init];
    }
    return nib;
}
- (void)reload{
    [self displayDialog:self.containerView infomation:self.infoObject];
}

@synthesize manager;

@synthesize viewController;

@end


@implementation HMSplitPopupConfigure

- (void)displayDialog:(UIView *)container infomation:(id<HMPopupModel>)infoObject{
    [super displayDialog:container infomation:infoObject];
    [container addSubview:self.view];
    
    self.view.translatesAutoresizingMaskIntoConstraints = false;
    [container addConstraint:[self.view.centerXAnchor constraintEqualToAnchor:container.centerXAnchor]];
    [container addConstraint:[self.view.centerYAnchor constraintEqualToAnchor:container.centerYAnchor]];
}

@end

@implementation HMPopupIndexModel

- (IBAction)handleEvent:(UIControl *)sender{
    if(self.handleIndex){
        self.handleIndex(sender.tag);
    }
}

@synthesize configure;

@end

@implementation HMBasePopupModel
@synthesize nibName;
@synthesize nibBundle;

@synthesize configure;
- (instancetype)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle{
    self = [super init];
    if(self){
        self.nibName = name;
        self.nibBundle = bundle;
    }
    return self;
}
@end
