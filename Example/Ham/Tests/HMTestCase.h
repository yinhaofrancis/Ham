//
//  HMTestCase.h
//  Ham_Tests
//
//  Created by hao yin on 2020/2/19.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import <XCTest/XCTest.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HMTestComplete)(void);

typedef void(^HMTestCallback)(HMTestComplete complete);

@interface HMTestCase : XCTestCase

- (void) asyncRunTest:(NSString *)desc
              timeout:(NSTimeInterval)time
             callback:(HMTestCallback)handle;

@end

NS_ASSUME_NONNULL_END
