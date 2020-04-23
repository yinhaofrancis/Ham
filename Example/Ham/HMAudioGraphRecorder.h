//
//  HMAudioGraphRecorder.h
//  Ham_Example
//
//  Created by KnowChat02 on 2019/11/8.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, HMAudioBufferType) {
    HMAudioInt,
    HMAudioFloat
};

@class HMAudioGraphRecorder;

@protocol HMAudioGraphRecorderDelegate

-(void)HMAudioGraphRecorder:(HMAudioGraphRecorder *)record handle:(NSData *)data;
@end
@interface HMAudioGraphRecorder : NSObject
@property (nonatomic,readonly) HMAudioBufferType bufferType;
@property (nonatomic,readonly) double sampleRate;
@property (nonatomic,weak)id<HMAudioGraphRecorderDelegate>delegate;
@property(nonatomic,readonly) AudioStreamBasicDescription format;
-(instancetype)initWithSampleRate:(double)sampleRate bufferType:(HMAudioBufferType)bfType;

- (void)start;

//关闭 Audio Unit
- (void)stop;
//结束 Audio Unit
- (void)finished;
@end

NS_ASSUME_NONNULL_END
