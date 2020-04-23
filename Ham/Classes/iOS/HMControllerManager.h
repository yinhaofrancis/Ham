//
//  HMControllerManager.h
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/21.
//

#import <Foundation/Foundation.h>
#import "HMModule.h"
#import "HMProtocol.h"
#import "HMWeakContainer.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMControllerManagerImp : NSObject<HMModule,HMControllerManager,HMRouterController>
@property (nonatomic,strong) NSMutableArray<HMWeakContainer *> *routers;

@property(nonatomic,readonly) NSNotificationCenter* notificationCenter;

@property(nonatomic,readonly) NSNotificationQueue* notificationQueue;

@end

NS_ASSUME_NONNULL_END
