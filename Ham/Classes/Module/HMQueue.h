//
//  HMQueue.h
//  HMGCD
//
//  Created by KnowChat02 on 2020/1/14.
//  Copyright © 2020 KnowChat02. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, HMActionType) {
    HMActionAsync,
    HMActionSync,
    HMActionBarrier,
    HMActionSyncBarrier,
    HMActionAfter
};
@interface HMAction : NSObject
@property(nonatomic,assign)HMActionType type;
@property(nonatomic,assign)int64_t afterTime;
@property(nonatomic,strong) dispatch_block_t call;
@end


@interface HMQueue : NSObject
@property(nonatomic,readonly) dispatch_queue_t queue;
@property(nonatomic,readonly) qos_class_t qos;
@property(nonatomic,readonly) NSArray<HMAction *> *actions;
+ (HMQueue *)main;
+ (HMQueue *)globalQos:(qos_class_t)qos;
- (instancetype)async:(dispatch_block_t)call;
- (instancetype)commit;
- (instancetype)afterSecond:(UInt64)seconds async:(dispatch_block_t)call;
- (instancetype)afterMillisecond:(UInt64)seconds async:(dispatch_block_t)call;
- (instancetype)sync:(dispatch_block_t)call;
- (void)cancel;
- (void)applyWithNumber:(size_t)size call:(void(^)(size_t))run;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
@end


@interface HMUserQueue : HMQueue
- (instancetype)initWithConcurrent:(qos_class_t)qos;
- (instancetype)initWithSerial:(qos_class_t)qos;
- (HMUserQueue *)barrier:(dispatch_block_t)call;
- (HMUserQueue *)syncBarrier:(dispatch_block_t)call;

@end
NS_ASSUME_NONNULL_END
