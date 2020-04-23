//
//  HMAudioEncoder.h
//  Ham_Example
//
//  Created by hao yin on 2019/10/20.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMAudioCoder.h"
NS_ASSUME_NONNULL_BEGIN

@interface HMCocoaAudioCoder : NSObject<HMAudioCoder>
@property(nonatomic,assign) AudioStreamBasicDescription from;
@property(nonatomic,assign) AudioStreamBasicDescription to;
@end

NS_ASSUME_NONNULL_END
