//
//  HMAudioEncoder.m
//  Ham_Example
//
//  Created by hao yin on 2019/10/20.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "HMCocoaAudioCoder.h"

@implementation HMCocoaAudioCoder{
    AudioConverterRef converter;
    AudioClassDescription* audioClasses;
}
- (void)configration{
    [self createConverter];
}
-(void)createConverter{
    if(converter != nil){
        AudioConverterDispose(converter);
        converter = nil;
    }
    [self createAudioClass];
    OSStatus status = AudioConverterNewSpecific(&self->_from, &self->_to,self.to.mChannelsPerFrame,audioClasses,&converter);
    NSLog(@"%d",status);
}
- (void)createAudioClass{
    if(audioClasses){
        free(audioClasses);
    }
    audioClasses = malloc(self.to.mChannelsPerFrame * sizeof(AudioClassDescription));
    for (int i = 0; i < self.to.mChannelsPerFrame; i++) {
        AudioClassDescription acd = {
            kAudioEncoderComponentType,
            self.to.mFormatID,
            kAppleHardwareAudioCodecManufacturer
        };
        audioClasses[i] = acd;
    }
}
- (void)dealloc
{
    free(audioClasses);
    AudioConverterDispose(converter);
}


- (nonnull NSData *)convert:(nonnull NSData *)data {
    UInt32 ds = 0;
    char *c = malloc(data.length);
//    AudioConverterComplexInputDataProc
    AudioConverterConvertBuffer(converter, (UInt32)data.length, data.bytes, &ds, c);
    
    return [[NSData alloc] initWithBytesNoCopy:c length:ds];
}

@end

