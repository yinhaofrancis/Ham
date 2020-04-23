////
////  HMTestRun.m
////  Ham_Tests
////
////  Created by hao yin on 2020/2/19.
////  Copyright © 2020 yinhaofrancis. All rights reserved.
////
//
//#import "HMTestRun.h"
//
//@implementation HMTestRun
//+ (void)runTestTime:(NSTimeInterval)timeout
//               desc:(NSString *)desc
//           testCase:(nonnull XCTestCase *)test
//          testBlock:(nonnull HMTestCallback)block{
//    __block XCTestExpectation* expect = [[XCTestExpectation alloc] initWithDescription:desc];
//    HMTestComplete complete = ^{
//        [expect fulfill];
//    };
//    block(complete);
//    [test waitForExpectations:@[expect] timeout:timeout];
//}
//
//@end
