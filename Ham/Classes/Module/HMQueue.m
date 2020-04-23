//
//  HMQueue.m
//  HMGCD
//
//  Created by KnowChat02 on 2020/1/14.
//  Copyright © 2020 KnowChat02. All rights reserved.
//

#import "HMQueue.h"

@implementation HMAction

@end
@interface HMQueue ()
@property (nonatomic,strong) NSMutableArray *mactions;
@end

@implementation HMQueue
@synthesize queue;
- (instancetype)initWithQueue:(dispatch_queue_t)queue;
{
    self = [super init];
    if (self) {
        self->queue = queue;
        self.mactions = [NSMutableArray new];
    }
    return self;
}
-(NSArray<HMAction *> *)actions{
    return [self.mactions copy];
}
+ (instancetype)main{
    return [[HMQueue alloc] initWithQueue:dispatch_get_main_queue()];
}
+ (instancetype)globalQos:(qos_class_t)qos{
    return [[HMQueue alloc] initWithQueue:dispatch_get_global_queue(qos, 0)];
}

-(HMQueue *)async:(dispatch_block_t)call{
    HMAction* action = [[HMAction alloc] init];
    action.type = HMActionAsync;
    action.call =  dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, ^{
        call();
        [self.mactions removeObject:action];
    });
    [self.mactions addObject:action];
    return self;
}


- (qos_class_t)qos{
    int priority;
    return dispatch_queue_get_qos_class(self.queue, &priority);
}
- (HMQueue *)commit{
    for (HMAction *a in self.actions) {
        switch (a.type) {
            case HMActionSync:
                dispatch_sync(self.queue, a.call);
                break;
            case HMActionAsync:
                dispatch_async(self.queue, a.call);
                break;
            case HMActionBarrier:
                dispatch_barrier_async(self.queue, a.call);
                break;
            case HMActionSyncBarrier:
                dispatch_barrier_sync(self.queue, a.call);
                break;
            case HMActionAfter:
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, a.afterTime),self.queue,a.call);
            default:
                break;
        }
    }
    return self;
}
-(HMQueue *)sync:(dispatch_block_t)call{
    HMAction* action = [[HMAction alloc] init];
    action.type = HMActionSync;
    action.call = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, ^{
        call();
        [self.mactions removeObject:action];
    });
    [self.mactions addObject:action];
    return self;
}
- (HMQueue *)afterSecond:(UInt64)seconds async:(dispatch_block_t)call{
    HMAction* action = [[HMAction alloc] init];
    action.type = HMActionAfter;
    action.call = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, ^{
        call();
        [self.mactions removeObject:action];
    });
    action.afterTime = (int64_t)(seconds * NSEC_PER_SEC);
    [self.mactions addObject:action];
    return self;
}
- (HMQueue *)afterMillisecond:(UInt64)seconds async:(dispatch_block_t)call{
    HMAction* action = [[HMAction alloc] init];
    action.type = HMActionAfter;
    action.call = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, ^{
        call();
        [self.mactions removeObject:action];
    });
    action.afterTime = (int64_t)(seconds * NSEC_PER_MSEC);
    [self.mactions addObject:action];
    return self;
}
- (void)cancel{
    for (HMAction *a in self.actions) {
        if(!dispatch_block_testcancel(a.call)){
            dispatch_block_cancel(a.call);
        }
    }
}
- (void)applyWithNumber:(size_t)size call:(void (^)(size_t))run{
    dispatch_apply(size, self.queue, run);
}
@end

@interface HMUserQueue ()

@end
@implementation HMUserQueue

- (instancetype)initWithConcurrent:(qos_class_t)qos{
    self = [super initWithQueue:dispatch_queue_create("HMCONCURRENT", dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, qos, 0))];
    return self;
}
- (instancetype)initWithSerial:(qos_class_t)qos{
    self = [super initWithQueue:dispatch_queue_create("HMSERIAL", dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, qos, 0))];
    return self;
}

-(HMUserQueue *)barrier:(dispatch_block_t)call{
    HMAction* action = [[HMAction alloc] init];
    action.type = HMActionBarrier;
    action.call = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, ^{
        call();
        [self.mactions removeObject:action];
    });
    [self.mactions addObject:action];
    return self;
}
-(HMUserQueue *)syncBarrier:(dispatch_block_t)call{
    HMAction* action = [[HMAction alloc] init];
    action.type = HMActionSyncBarrier;
    action.call = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, ^{
        call();
        [self.mactions removeObject:action];
    });
    [self.mactions addObject:action];
    return self;
}


@end

