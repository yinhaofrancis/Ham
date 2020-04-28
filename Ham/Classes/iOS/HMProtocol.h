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
@HMCustomAnnotationStringkey(HMSectCtrl,router,controller)

#define HMNibController(router,bundleId) \
HMCustomAnnotationString(HMSectCtrl,router,bundleId)

#define HMGetController(name) \
[InstantProtocol(HMControllerManager) dequeueViewController:name param:nil]

#define HMGetControllerWithParam(name,p) \
[InstantProtocol(HMControllerManager) dequeueViewController:name param:p]


#define HMShowRouterWithParam(router,param) \
[InstantProtocol(HMRouterController) showRoute:router withParam:param]

NS_ASSUME_NONNULL_BEGIN

@protocol HMControllerManager <NSObject>

- (UIViewController *)dequeueViewController:(NSString *)name param:(nullable NSDictionary *)param;

- (id)handleName:(nullable NSString*)name vc:(UIViewController *)vc callback:(void(^)(NSNotification *))callback;

@end

@protocol HMManagedController <NSObject>

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

- (BOOL)showRoute:(NSString *)name withParam:(nullable NSDictionary *)param;

@end

@protocol HMResourceLoader <NSObject>

-(void)loadResource:(NSURL *)url handle:(void(^)(NSData * data))handle;

-(NSURL *)loadLocalUrl:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
