//
//  HMTest.m
//  Ham_Example
//
//  Created by KnowChat02 on 2019/10/18.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "HMTest.h"

@implementation HMTest
+ (HMModuleMemoryType)memoryType{
    return HMModuleWeakSinglten;
}
- (void)run{
    NSLog(@"run");
}
@end
@implementation HMTest2


@synthesize coco;

+ (HMModuleMemoryType)memoryType {
    return HMModuleWeakSinglten;
}

- (void)run2 {
    [self.coco run];
}

@synthesize tcoco;

@end

@HMService(HMCoco , HMTest)

@HMService(HMCoco2 , HMTest2)
@HMClass(HMTest2)
@HMClass(HMTest)
