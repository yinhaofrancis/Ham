//
//  HMTimer.h
//  Ham_Example
//
//  Created by KnowChat02 on 2020/1/15.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMQueue.h"
NS_ASSUME_NONNULL_BEGIN

@interface HMTimer : NSObject
- (instancetype) initWithQueue:(HMQueue*)queue Seconds:(NSTimeInterval)time callback:(dispatch_block_t)call;
- (instancetype) initWithQueue:(HMQueue*)queue Millisecond:(NSTimeInterval)time callback:(dispatch_block_t)call;
- (void)run;
@end

NS_ASSUME_NONNULL_END
