//
//  HMProtocol.h
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/21.
//

#import <UIKit/UIKit.h>
#import "HMModule.h"

#define HMSectCtrlKey "HMSectCtrl"

#define HMController(router,controller) \
class controller; \
@HMCustomAnnotation(HMSectCtrl,router,controller)


#define HMController(router,controller) \
class controller; \
@HMCustomAnnotation(HMSectCtrl,router,controller)

#define HMKeyController(router,controller) \
class controller; \
char const * HMConr_##controller##_contr_Annotation HMDATA(HMSectCustom) =  "{\"HMSectCtrl\":{ \"" router"\" :\""#controller"\"}}";

#define HMNibController(router,bundleId) \
HMCustomAnnotationString(HMSectCtrl,router,bundleId)

#define HMGetController(name) \
[InstantProtocol(HMControllerManager) dequeueViewController:name param:nil context:nil]

#define HMGetControllerWithParam(name,p) \
[InstantProtocol(HMControllerManager) dequeueViewController:name param:p context:nil]

#define HMGetControllerCtx(name,ctx) \
[InstantProtocol(HMControllerManager) dequeueViewController:name param:nil context:ctx]

#define HMGetControllerWithParamCtx(name,p,ctx) \
[InstantProtocol(HMControllerManager) dequeueViewController:name param:p context:ctx]

#define HMShowRouterWithParam(router,param) \
[InstantProtocol(HMRouterController) showRoute:router withParam:param callback:nil]

#define HMShowRouterWithParamAndCallback(router,param,handle) \
[InstantProtocol(HMRouterController) showRoute:router withParam:param callback:handle]

#define HMGetControllerWithCallback(name,p,callback) \
[InstantProtocol(HMControllerManager) dequeueViewController:name param:p handle:callback]

NS_ASSUME_NONNULL_BEGIN

typedef void(^handleControllerCallback)(NSString * name,NSDictionary *param);

@protocol HMControllerManager <NSObject>

- (UIViewController *)dequeueViewController:(NSString *)name param:(nullable NSDictionary *)param context:(nullable id)ctx;

- (UIViewController *)dequeueViewController:(NSString *)name param:(nullable NSDictionary *)param handle:(nullable handleControllerCallback)callback;

@end



@protocol HMControllerCallback <NSObject>
@optional
- (void) handleCallbackWithName:(NSString *)name param:(nullable NSDictionary*)param;
@end


@protocol HMManagedController <HMControllerCallback>

@property (nonatomic,weak)id<HMControllerManager> controllerManager;

@optional

- (void) callbackWithName:(NSString *)name param:(nullable NSDictionary*)param;



@end


@protocol HMParamController <NSObject>
@property (nonatomic,readonly) NSDictionary *param;
@optional
- (instancetype)initWithParam:(nullable NSDictionary *)param;
- (void)handleParam:(NSDictionary *)param;
@end

@protocol HMNameController <NSObject>
@property (nonatomic,readonly) NSString* vcName;

@end

@protocol HMRouterController <NSObject>

@optional

- (BOOL)showRoute:(NSString *)name withParam:(nullable NSDictionary *)param callback:(nullable handleControllerCallback)callback;

@end

@protocol HMRoute <HMRouterController>

- (void) displayViewController:(UIViewController *)vc WithName:(NSString *)name;

@end

@protocol HMResourceLoader <NSObject>

-(void)loadResource:(NSURL *)url handle:(void(^)(NSData * data))handle;

-(NSURL *)loadLocalUrl:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
