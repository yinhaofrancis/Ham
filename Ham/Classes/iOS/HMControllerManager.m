//
//  HMControllerManager.m
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/21.
//

#import "HMControllerManager.h"
#import "HMAnnotation.h"
#import "HMProtocol.h"
#import "HMAnotationStorage.h"
#import <objc/runtime.h>
#import "HMOCRunTimeTool.h"
//static NSMutableDictionary *dc;
@HMService(HMControllerManager,HMControllerManagerImp)
@implementation HMControllerManagerImp
- (UIViewController *)dequeueViewController:(NSString *)name param:(NSDictionary *)param context:(nullable id)ctx{
    UIViewController * vc = [self dequeueViewControllerInner:name param:param context:ctx];
    if(vc == nil){
        UIViewController * vc = [[UIViewController alloc] init];
        UILabel* lb = [[UILabel alloc] init];
        lb.text = @"正在装修";
        lb.textAlignment = NSTextAlignmentCenter;
        lb.backgroundColor = UIColor.whiteColor;
        lb.frame = vc.view.bounds;
        lb.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [vc.view addSubview:lb];
        return vc;
    }
    return vc;
}
- (UIViewController *)dequeueViewController:(NSString *)name param:(NSDictionary *)param handle:(handleControllerCallback)callback{
    return [self dequeueViewController:name param:param context:[[HMCallBack alloc] initWithCallBack:callback]];
}
- (UIViewController *)dequeueViewControllerInner:(NSString *)name param:(NSDictionary *)param context:(id)ctx{
    NSDictionary* dc = [HMAnotationStorage.shared getEnvConfigByName:@HMSectCtrlKey];
    Class cls = NSClassFromString(dc[name]);
    UIViewController *obj;
    id temp = [cls alloc];
    if([cls conformsToProtocol:@protocol(HMNameController)]){
        [HMOCRunTimeTool assignIVar:@{@"vcName":name} ToObject:temp];
    }
    if([cls conformsToProtocol:@protocol(HMParamController)]){
        
        if(param && [temp respondsToSelector:@selector(initWithParam:)]){
            obj = [temp initWithParam:param];
        }else{
            if(param){
                [HMOCRunTimeTool assignIVar:@{@"param":param} ToObject:temp];
                
            }
            obj = [temp init];
        }
        
    }else{
        obj = [cls new];
    }
    if(obj){
        [HMModuleManager.shared assignAllModule:obj];
    }
    if(obj == nil && dc[name] != nil){
        obj = [[UIStoryboard storyboardWithName:name bundle:[NSBundle bundleWithIdentifier:dc[name]]] instantiateInitialViewController];
        if([obj conformsToProtocol:@protocol(HMParamController)]){
            if(param){
                if([obj respondsToSelector:@selector(handleParam:)]){
                    id<HMParamController> p = (id<HMParamController>) obj;
                    [p handleParam:param];
                }else{
                    [HMOCRunTimeTool assignIVar:@{@"param":param} ToObject:temp];
                }
            }
        }
        if([obj conformsToProtocol:@protocol(HMNameController)]){
            [HMOCRunTimeTool assignIVar:@{@"vcName":name} ToObject:temp];
        }
    }else if(obj == nil){
        return nil;
    }
    if([obj conformsToProtocol:@protocol(HMRoute)]){
        HMWeakContainer* w = [[HMWeakContainer alloc] init];
        w.content = obj;
        if(!self.routers){
            self.routers = [NSMutableArray new];
        }
        [self.routers addObject:w];
//        __weak id<HMRoute> o = (id<HMRoute>)obj;
//        [HMOCRunTimeTool classImplamentProtocol:@protocol(HMRoute) selector:@selector(showRoute:withParam:callback:) toClass:obj.class imp:^BOOL (id<HMRoute> s,NSString *name,NSDictionary * param ,handleControllerCallback call) {
//
//            UIViewController * vc = [self dequeueViewControllerInner:name param:param context:[HMCallBack.alloc initWithCallBack:call]];
//            if(vc){
//                if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive) {
//
//                }else{
//                    HMVCBackUp* b = [[HMVCBackUp alloc] init];
//                    b.vc = vc;
//                    b.name = name;
//                    [self.backup addObject:b];
//                }
//                return true;
//            }else {
//                return false;
//            }
//        }];
    }
    if([obj conformsToProtocol:@protocol(HMManagedController)]){
        [HMOCRunTimeTool assignIVar:@{@"controllerManager":self} ToObject:obj];

        objc_setAssociatedObject(obj, @"_^&^callback", ctx, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [HMOCRunTimeTool classImplamentProtocol:@protocol(HMManagedController) selector:@selector(callbackWithName:param:) toClass:obj.class imp:^(id s,NSString *name,NSDictionary * param){
            id<HMControllerCallback> wc = objc_getAssociatedObject(s, @"_^&^callback");
            if(wc && [wc respondsToSelector:@selector(handleCallbackWithName:param:)]){
                [wc handleCallbackWithName:name param:param];
            }
        }];
    }
    [self.activeViewController addObject:obj];
    return obj;
}
+ (HMModuleMemoryType)memoryType {
    return HMModuleSinglten;
}
- (BOOL)showRoute:(NSString *)name withParam:(NSDictionary *)param callback:(handleControllerCallback)callback{
    while (!self.routers.lastObject.content && self.routers.count > 0) {
        [self.routers removeLastObject];
    }
    id<HMRoute> ro = (id<HMRoute>)self.routers.lastObject.content;
    if(ro){
        UIViewController* vc = HMGetController(name, param, callback);
        if (UIApplication.sharedApplication.applicationState == UIApplicationStateActive){
            [ro displayViewController:vc WithName:name];
        }else{
            HMVCBackUp* b = [[HMVCBackUp alloc] init];
            b.vc = vc;
            b.name = name;
            [self.backup addObject:b];
        }
        
    }
    return false;
}
- (BOOL)showRoutePresent:(NSString *)name
               withParam:(NSDictionary *)param
                inWindow:(nonnull UIWindow *)window
                callback:(handleControllerCallback)callback{
    UIViewController * vc = [self dequeueViewControllerInner:name param:param context:[[HMCallBack alloc] initWithCallBack:callback]];
    if(!vc)
        return false;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController * pvc = window.rootViewController;
        while ([pvc presentedViewController]) {
            pvc = pvc.presentedViewController;
        }
        [pvc presentViewController:vc animated:true completion:^{
        }];
    });
    return true;
}

- (void)displayViewController:(nonnull UIViewController *)vc WithName:(nonnull NSString *)name {
    
}

- (void)handleApplicationActive{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (HMVCBackUp* v in self.backup) {
            id<HMRoute> ro = (id<HMRoute>)self.routers.lastObject.content;
            [ro displayViewController:v.vc WithName:v.name];
        }
        [self.backup removeAllObjects];
    });
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.activeViewController = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:10];
        self.backup = [NSMutableArray new];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleApplicationActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}
@end


@implementation HMCallBack

- (void)handleCallbackWithName:(NSString *)name param:(NSDictionary *)param{
    if(self.callback){
        self.callback(name, param);
    }
}
- (instancetype)initWithCallBack:(handleControllerCallback)callback
{
    self = [super init];
    
    
    if (self) {
        _callback = [callback copy];
    }
    return self;
}
@synthesize controllerManager;
@end



@implementation HMVCBackUp



@end
