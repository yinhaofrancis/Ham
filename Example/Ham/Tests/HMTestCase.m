//
//  HMTestCase.m
//  Ham_Tests
//
//  Created by hao yin on 2020/2/19.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import "HMTestCase.h"

@implementation HMTestCase
- (void)asyncRunTest:(NSString *)desc
             timeout:(NSTimeInterval)time
            callback:(HMTestCallback)handle{
    __block XCTestExpectation* expect = [[XCTestExpectation alloc] initWithDescription:desc];
    HMTestComplete complete = ^{
        [expect fulfill];
    };
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        handle(complete);
    });
    [self waitForExpectations:@[expect] timeout:time];
}
@end
