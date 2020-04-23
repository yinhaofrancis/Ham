//
//  HamTests.m
//  HamTests
//
//  Created by yinhaofrancis on 07/24/2019.
//  Copyright (c) 2019 yinhaofrancis. All rights reserved.
//

@import XCTest;
#import <Ham/Ham.h>
#import "HMTest.h"
#import "HMTestRun.h"
#import "HMTestCase.h"


@interface TestContent : NSObject

@property(atomic,assign) BOOL content;

@end

@implementation TestContent

@end

@interface Tests : HMTestCase

@property (nonatomic,strong) HMTest *test;



@end

@implementation Tests

- (void)setUp {
    [super setUp];
}

- (void)tearDown{
    [super tearDown];
}

- (void)testDraw{
    
}

@end
