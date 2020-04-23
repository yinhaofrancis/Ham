//
//  HMVideoMaker.m
//  Ham_Example
//
//  Created by KnowChat02 on 2019/11/6.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "HMVideoMaker.h"
#import "HMDrawImage.h"
@interface HMVideoMaker()
@property (nonatomic,nonnull) AVAssetWriter* writer;
@property (nonatomic,nonnull) AVAssetWriterInput *input;
@property (nonatomic,nonnull) AVAssetWriterInputPixelBufferAdaptor *adaptor;
@property (nonatomic,nonnull) dispatch_queue_t queue;
@property (assign,nonatomic)  CGSize size;
@property (nonatomic,assign)  int64_t currentTime;
@end
@implementation HMVideoMaker
- (instancetype)initWithUrl:(NSURL *)url fileType:(AVFileType)ftype videoSize:(CGSize)size{
    self = [super init];
    if (self) {
        AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:url
                                                               fileType:ftype
                                                                  error:nil];

        self.writer = videoWriter;
        NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264, AVVideoCodecKey,
                                       [NSNumber numberWithInt:size.width], AVVideoWidthKey,
                                       [NSNumber numberWithInt:size.height], AVVideoHeightKey, nil];
        AVAssetWriterInput *writerInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
        self.input = writerInput;
        NSDictionary *sourcePixelBufferAttributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_32ARGB], kCVPixelBufferPixelFormatTypeKey, nil];

        AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor
                                                         assetWriterInputPixelBufferAdaptorWithAssetWriterInput:writerInput sourcePixelBufferAttributes:sourcePixelBufferAttributesDictionary];
        NSParameterAssert(writerInput);
        NSParameterAssert([videoWriter canAddInput:writerInput]);
        self.adaptor = adaptor;
        if ([videoWriter canAddInput:writerInput])
            return nil;
        [videoWriter addInput:writerInput];
        [videoWriter startWriting];
        self.size = size;
        [videoWriter startSessionAtSourceTime:kCMTimeZero];
        self.queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0);
        self.currentTime = 0;
    }
    return self;
}
- (void)writeImage:(CGImageRef)image{
    [self.input requestMediaDataWhenReadyOnQueue:self.queue usingBlock:^{
        if([self.input isReadyForMoreMediaData]){
            CVPixelBufferRef px = [self genPixelBuffer:image];
            [self.adaptor appendPixelBuffer:px withPresentationTime:CMTimeMake(self.currentTime, 1000)];
            self.currentTime += 100;
        }
    }];
}
- (void)close{
    [self.input markAsFinished];
    [self.writer finishWritingWithCompletionHandler:^{
        
    }];
}
-(CVPixelBufferRef)genPixelBuffer:(CGImageRef)image{
    CVPixelBufferRef pxbuffer;
    CVPixelBufferCreate(CFAllocatorGetDefault(),self.size.width, self.size.height, kCVPixelFormatType_32ARGB, nil, &pxbuffer);
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    [[[HMDrawImage alloc] initWithBitmapBuffer:pxdata Size:self.size ForCallback:^(CGContextRef  _Nonnull ctx) {
        CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.width, self.size.height), image);
    }] render];
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    return pxbuffer;
}

@end
