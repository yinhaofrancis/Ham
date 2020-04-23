//
//  HMTimer.m
//  Ham_Example
//
//  Created by KnowChat02 on 2020/1/15.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import "HMTimer.h"

@implementation HMTimer{
    dispatch_source_t timer;
}
- (instancetype)initWithQueue:(HMQueue*)queue Seconds:(NSTimeInterval)time callback:(dispatch_block_t)call
{
    self = [super init];
    if (self) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue.queue);
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, time * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, call);
    }
    return self;
}
- (instancetype)initWithQueue:(HMQueue*)queue Millisecond:(NSTimeInterval)time callback:(dispatch_block_t)call
{
    self = [super init];
    if (self) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue.queue);
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, time * NSEC_PER_MSEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, call);
    }
    return self;
}
- (void)run{
    dispatch_resume(timer);
}
@end
