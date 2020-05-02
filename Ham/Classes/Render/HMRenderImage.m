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
        _cgContext = createContext(UIScreen.mainScreen.bounds.size, UIScreen.mainScreen.scale, nil);
        _ciContext = [CIContext contextWithCGContext:_cgContext options:nil];
        dispatch_queue_attr_t aa =  dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_BACKGROUND, 0);
        _queue = dispatch_queue_create("", aa);
    }
    return self;
}
- (instancetype)draw:(renderBlock)callback{
    _render = [callback copy];
    return self;
}
- (void)drawSize:(CGSize)size callback:(getImageBlock)call {
    dispatch_async(_queue, ^{
        CGContextFlush(self.cgContext);
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        self->_render(self.cgContext,rect);
        CGRect exend = CGRectMake(rect.origin.x * UIScreen.mainScreen.scale, rect.origin.y * UIScreen.mainScreen.scale, rect.size.width * UIScreen.mainScreen.scale, rect.size.height * UIScreen.mainScreen.scale);
        CIImage *cimg = self.ciImage;
        CGImageRef img = [self.ciContext createCGImage:cimg fromRect:exend];
        
        UIImage * uimg =[[UIImage alloc] initWithCGImage:img scale:UIScreen.mainScreen.scale orientation:UIImageOrientationUp];
        
        CGImageRelease(img);
        call(uimg);
    });
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
@end
