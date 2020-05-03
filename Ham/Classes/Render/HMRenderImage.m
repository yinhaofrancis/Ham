//
//  HMRenderImage.m
//  Ham_Example
//
//  Created by hao yin on 2020/5/2.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import "HMRenderImage.h"
#import "HMDrawImage.h"
#import <Metal/Metal.h>
@implementation HMRenderImage{
    renderBlock _render;
    dispatch_queue_t _queue;
    
}


- (instancetype)init {
    self = [super init];
    if(self) {
        _contextSize = UIScreen.mainScreen.bounds.size;
        _cgContext = createContext(self.contextSize, UIScreen.mainScreen.scale, nil);
        _ciContext = [CIContext contextWithOptions:@{
            kCIContextPriorityRequestLow:@1,
            kCIContextUseSoftwareRenderer:@1
        }];
        dispatch_queue_attr_t aa =  dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_BACKGROUND, 0);
        _queue = dispatch_queue_create("", aa);
    }
    return self;
}
- (instancetype)draw:(renderBlock)callback{
    _render = [callback copy];
    _drawWorkFlow = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory capacity:100];
    return self;
}
- (NSString *)drawSize:(CGSize)size callback:(getImageBlock)call {
    NSString *uuid = NSUUID.UUID.UUIDString;
    dispatch_block_t t = ^{
        CGContextFlush(self.cgContext);
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        self->_render(self.cgContext,rect);
        CGFloat delta = self.contextSize.height * UIScreen.mainScreen.scale - rect.size.height * UIScreen.mainScreen.scale;
        CGRect exend = CGRectMake(rect.origin.x * UIScreen.mainScreen.scale,
                                  rect.origin.y * UIScreen.mainScreen.scale + delta,
                                  rect.size.width * UIScreen.mainScreen.scale,
                                  rect.size.height * UIScreen.mainScreen.scale);
        CGImageRef cimg = CGBitmapContextCreateImage(self.cgContext);
        
        CGImageRef img = CGImageCreateWithImageInRect(cimg, exend);
        CGImageRef png = CGBitMapExportPNG(img,1);
        UIImage * uimg =[[UIImage alloc] initWithCGImage:png scale:UIScreen.mainScreen.scale orientation:UIImageOrientationUp];
        CGImageRelease(cimg);
        CGImageRelease(png);
        call(uimg);
    };
    
    [self.drawWorkFlow setObject:t forKey:uuid];
    t =  dispatch_block_create(DISPATCH_BLOCK_DETACHED, t);
    dispatch_async(_queue, t);
    
    return uuid;
}

- (CGImageRef)createPNGImage:(CIImage *)img size:(CGRect)exend{
    return CGBitMapExportPNG([self.ciContext createCGImage:img fromRect:exend],1);
}
- (CIImage *)ciImage{
    return CGBitmapContextGetCIImage(_cgContext);
}
+ (instancetype)shared{
    static HMRenderImage* render;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        render = [HMRenderImage new];
    });
    return render;
}
- (void)dealloc
{
    [self cancelAllWork];
}
@end
