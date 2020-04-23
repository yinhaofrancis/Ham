//
//  HMGroup.h
//  HMGCD
//
//  Created by KnowChat02 on 2020/1/14.
//  Copyright © 2020 KnowChat02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMQueue.h"
NS_ASSUME_NONNULL_BEGIN

@interface HMGroup : NSObject
@property(nonatomic,readonly)dispatch_group_t group;
-(HMGroup *)async:(HMQueue*(^)(void))workflow;
-(HMGroup *)notify:(HMQueue*(^)(void))workflow;
@end

NS_ASSUME_NONNULL_END
