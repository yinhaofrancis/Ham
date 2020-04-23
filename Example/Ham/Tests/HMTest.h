//
//  HMTest.h
//  Ham_Example
//
//  Created by KnowChat02 on 2019/10/18.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Ham/Ham.h>
NS_ASSUME_NONNULL_BEGIN
@class HMTest;
@protocol HMCoco <NSObject>

- (void)run;

@end

@protocol HMCoco2 <NSObject>

- (void)run2;

@property (nonatomic,strong)id<HMCoco> coco;

@property (nonatomic,strong)HMTest* tcoco;

@end


@interface HMTest2 : NSObject<HMModule,HMCoco2>

@end


@interface HMTest : NSObject<HMModule,HMCoco>

@end



NS_ASSUME_NONNULL_END
