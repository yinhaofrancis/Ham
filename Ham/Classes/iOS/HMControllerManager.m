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
@HMService(HMRouterController,HMControllerManagerImp)

@implementation HMControllerManagerImp
- (UIViewController *)dequeueViewController:(NSString *)name param:(NSDictionary *)param{
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
    if([obj conformsToProtocol:@protocol(HMRouterController)]){
        HMWeakContainer* w = [[HMWeakContainer alloc] init];
        w.content = obj;
        if(!self.routers){
            self.routers = [NSMutableArray new];
        }
        [self.routers addObject:w];
    }
    if([obj conformsToProtocol:@protocol(HMManagedController)]){
        [HMOCRunTimeTool assignIVar:@{@"controllerManager":self} ToObject:obj];
        [HMOCRunTimeTool classImplamentProtocol:@protocol(HMManagedController) selector:@selector(callbackWithName:param:) toClass:obj.class imp:^(id s,NSString* name,NSDictionary * param){
            [self.notificationQueue enqueueNotification:[NSNotification notificationWithName:name object:s userInfo:param] postingStyle:NSPostWhenIdle];
        }];
    }
    return obj;
}
+ (HMModuleMemoryType)memoryType {
    return HMModuleSinglten;
}
- (void)showRoute:(NSString *)name withParam:(NSDictionary *)param{
    while (!self.routers.lastObject.content && self.routers.count > 0) {
        [self.routers removeLastObject];
    }
    id<HMRouterController> ro = (id<HMRouterController>)self.routers.lastObject.content;
    if(ro){
        [ro showRoute:name withParam:param];
    }
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _notificationCenter = [NSNotificationCenter new];
        _notificationQueue = [[NSNotificationQueue alloc] initWithNotificationCenter:self.notificationCenter];
    }
    return self;
}

- (id)handleName:(NSString *)name vc:(UIViewController *)vc callback:(void (^)(NSNotification * _Nonnull))callback{
    return [self.notificationCenter addObserverForName:name object:vc queue:[NSOperationQueue mainQueue] usingBlock:callback];
}
@end
