//
//  HMAudioGraphRecorder.m
//  Ham_Example
//
//  Created by KnowChat02 on 2019/11/8.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "HMAudioGraphRecorder.h"

#define kOutputBus 0
#define kInputBus 1
static OSStatus recordCallback(void *inRefCon,
                               AudioUnitRenderActionFlags *ioActionFlags,
                               const AudioTimeStamp *inTimeStamp,
                               UInt32 inBusNumber,
                               UInt32 inNumberFrames,
                               AudioBufferList *ioData);
static OSStatus playbackCallback(void *inRefCon,
                                 AudioUnitRenderActionFlags *ioActionFlags,
                                 const AudioTimeStamp *inTimeStamp,
                                 UInt32 inBusNumber,
                                 UInt32 inNumberFrames,
                                 AudioBufferList *ioData);

@interface HMAudioGraphRecorder()
@property(nonatomic,assign) AudioUnit audioUnit;
@property(nonatomic,assign) dispatch_queue_t queue;
@property(nonatomic,assign) AudioStreamBasicDescription format;
@property (nonatomic,assign) AudioBufferList buffers;
@end
@implementation HMAudioGraphRecorder

- (instancetype)initWithSampleRate:(double)sampleRate bufferType:(HMAudioBufferType)bfType{
    self = [super init];
    if (self) {
        _sampleRate = sampleRate;
        _bufferType = bfType;
        [self createAudioFormat];
        self.queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
    }
    return self;
}

- (instancetype)init
{
    return [self initWithSampleRate:44100 bufferType:HMAudioInt];
}
- (void) loadAudioFormat{
    OSStatus status = AudioUnitSetProperty(self.audioUnit,
                                    kAudioUnitProperty_StreamFormat,
                                    kAudioUnitScope_Output,
                                    kInputBus,
                                    &_format,
                                    sizeof(_format));
       [self check:status];
       status = AudioUnitSetProperty(self.audioUnit,
                                    kAudioUnitProperty_StreamFormat,
                                    kAudioUnitScope_Input,
                                    kOutputBus,
                                    &_format,
                                    sizeof(_format));
       [self check:status];
}
- (void) createAudioFormat{
    AudioStreamBasicDescription format;
    memset(&format, 0, sizeof(format));
    format.mSampleRate = self.sampleRate;
    format.mFormatID = kAudioFormatLinearPCM;
    if(self.bufferType == HMAudioFloat){
        format.mFormatFlags = kAudioFormatFlagIsFloat | kAudioFormatFlagIsPacked;
        format.mChannelsPerFrame = 1;
        format.mBitsPerChannel = 8 * sizeof(float);
        format.mFramesPerPacket = 1;
        format.mBytesPerFrame = format.mBitsPerChannel / 8 * format.mChannelsPerFrame;
        format.mBytesPerPacket = sizeof(float) * format.mFramesPerPacket;
    }else{
        format.mFormatFlags = kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
        format.mChannelsPerFrame = 2;
        format.mBitsPerChannel = 8 * sizeof(SInt16);
        format.mFramesPerPacket = 1;
        format.mBytesPerFrame = format.mBitsPerChannel / 8 * format.mChannelsPerFrame;
        format.mBytesPerPacket = format.mBytesPerFrame;
    }
    _format = format;
   
}

- (void) createAudioCallback{

    
    
    
    AURenderCallbackStruct callbackStruct;
    callbackStruct.inputProc = recordCallback;
    callbackStruct.inputProcRefCon = (__bridge void * _Nullable)(self);
    OSStatus status = AudioUnitSetProperty(self.audioUnit,
                                 kAudioOutputUnitProperty_SetInputCallback,
                                 kAudioUnitScope_Global,
                                 kInputBus,
                                 &callbackStruct,
                                 sizeof(callbackStruct));
    [self check:status];

//    callbackStruct.inputProc = playbackCallback;
//    callbackStruct.inputProcRefCon = (__bridge void * _Nullable)(self);
//    status = AudioUnitSetProperty(self.audioUnit,
//                                 kAudioUnitProperty_SetRenderCallback,
//                                 kAudioUnitScope_Global,
//                                 kOutputBus,
//                                 &callbackStruct,
//                                 sizeof(callbackStruct));
//    [self check:status];
    int flag = 0;
    status = AudioUnitSetProperty(self.audioUnit,
                                 kAudioUnitProperty_ShouldAllocateBuffer,
                                 kAudioUnitScope_Output,
                                 kInputBus,
                                 &flag,
                                 sizeof(flag));

    status = AudioUnitInitialize(self.audioUnit);
    [self check:status];
}
- (void)createUnit{
    OSStatus status;
    AudioComponentInstance audioUnit;

    AudioComponentDescription desc;
    desc.componentType                      = kAudioUnitType_Output;
    desc.componentSubType                   = kAudioUnitSubType_RemoteIO;
    desc.componentFlags                     = 0;
    desc.componentFlagsMask                 = 0;
    desc.componentManufacturer              = kAudioUnitManufacturer_Apple;

    AudioComponent inputComponent = AudioComponentFindNext(NULL, &desc);

    status = AudioComponentInstanceNew(inputComponent, &audioUnit);
    [self check:status];
    self.audioUnit = audioUnit;
}
- (void)createIoBus{
    UInt32 flag = 1;
    OSStatus status = AudioUnitSetProperty(self.audioUnit,
                                  kAudioOutputUnitProperty_EnableIO,
                                  kAudioUnitScope_Input,
                                  kInputBus,
                                  &flag,
                                  sizeof(flag));
    [self check:status];
    
    // Enable IO for playback
    // 为播放打开 IO
    status = AudioUnitSetProperty(self.audioUnit,
                                  kAudioOutputUnitProperty_EnableIO,
                                  kAudioUnitScope_Output,
                                  kOutputBus,
                                  &flag,
                                  sizeof(flag));
    [self check:status];
}
- (void)start {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    if(self.audioUnit){
        [self finished];
    }
    [self createUnit];
    [self loadAudioFormat];
    [self createIoBus];
    [self createAudioCallback];
    OSStatus status = AudioOutputUnitStart(self.audioUnit);
    [self check:status];
}
- (void)check:(OSStatus)status{
    NSAssert(status == 0, @"参数错误");
}
//关闭 Audio Unit
- (void)stop {
    OSStatus status = AudioOutputUnitStop(self.audioUnit);
    [self check:status];
}
//结束 Audio Unit
- (void)finished {
    AudioComponentInstanceDispose(self.audioUnit);
}
- (void)dealloc
{
    [self finished];
}
- (void)setBuffers:(AudioBufferList)buffers{
    NSMutableData* data = [[NSMutableData alloc] init];
    for (int i = 0; i < buffers.mNumberBuffers; i ++) {
        [data appendData:[[NSData alloc] initWithBytes:buffers.mBuffers[i].mData length:buffers.mBuffers[i].mDataByteSize]];
        free(buffers.mBuffers[i].mData);
    }
    
    [self.delegate HMAudioGraphRecorder:self handle:data];
}
@end
static OSStatus recordCallback(void *inRefCon,
                               AudioUnitRenderActionFlags *ioActionFlags,
                               const AudioTimeStamp *inTimeStamp,
                               UInt32 inBusNumber,
                               UInt32 inNumberFrames,
                               AudioBufferList *ioData){
    HMAudioGraphRecorder *self = (__bridge HMAudioGraphRecorder*)inRefCon;
//    dispatch_async(self.queue, ^{
//        [self.delegate HMAudioGraphRecorder:self handle:[[NSData alloc] initWithBytes:ioData-> length:]]
//    });
    AudioBufferList buffer;
    buffer.mNumberBuffers = 1;
    buffer.mBuffers[0].mDataByteSize = sizeof(SInt16) * inNumberFrames * self.format.mChannelsPerFrame;
    buffer.mBuffers[0].mNumberChannels = self.format.mChannelsPerFrame;
    buffer.mBuffers[0].mData = (SInt16*) malloc(buffer.mBuffers[0].mDataByteSize);
    OSStatus status = AudioUnitRender(self.audioUnit, ioActionFlags, inTimeStamp, inBusNumber, inNumberFrames, &buffer);
    self.buffers = buffer;
//    return noErr;
    if(status != 0){
        return status;
    }
    return noErr;
}

static OSStatus playbackCallback(void *inRefCon,
                                 AudioUnitRenderActionFlags *ioActionFlags,
                                 const AudioTimeStamp *inTimeStamp,
                                 UInt32 inBusNumber,
                                 UInt32 inNumberFrames,
                                 AudioBufferList *ioData) {

    NSLog(@"%d",inNumberFrames);
    return noErr;
}
