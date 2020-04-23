//
//  HMGroup.m
//  HMGCD 
//
//  Created by KnowChat02 on 2020/1/14.
//  Copyright © 2020 KnowChat02. All rights reserved.
//

#import "HMGroup.h"

@implementation HMGroup
- (HMGroup *)async:(HMQueue * _Nonnull (^)(void))workflow{
    HMQueue * q = workflow();
    for (HMAction *a in q.actions) {
        if(a.type == HMActionAsync){
            dispatch_group_async(self.group,q.queue , a.call);
        }else if(a.type == HMActionSync){
            dispatch_group_enter(self.group);
            dispatch_block_t block = a.call;
            a.call = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, ^{
                block();
                dispatch_group_leave(self.group);
            });
            dispatch_sync(q.queue, a.call);
        }else if(a.type == HMActionBarrier){
            dispatch_group_enter(self.group);
            dispatch_block_t block = a.call;
            a.call = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS,^{
                block();
                dispatch_group_leave(self.group);
            } );
            dispatch_barrier_async(q.queue, a.call);
        }else if(a.type == HMActionSyncBarrier){
            dispatch_group_enter(self.group);
            dispatch_block_t block = a.call;
            a.call = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS,^{
                block();
                dispatch_group_leave(self.group);
            });
            dispatch_barrier_sync(q.queue, a.call);
        }else if(a.type == HMActionAfter){
            dispatch_group_enter(self.group);
            dispatch_block_t block = a.call;
            a.call = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS,^{
                block();
                dispatch_group_leave(self.group);
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, a.afterTime), q.queue, a.call);
        }
    }
    return self;
}
- (HMGroup *)notify:(HMQueue * _Nonnull (^)(void))workflow{
    HMQueue *q = workflow();
    for (HMAction *action in q.actions) {
        if(action.type == HMActionAsync){
            dispatch_group_notify(self.group, q.queue, action.call);
        }
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _group = dispatch_group_create();
    }
    return self;
}
@end
