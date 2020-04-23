//
//  HMDrawImage.h
//  Himalaya
//
//  Created by KnowChat02 on 2019/5/30.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class HMDrawImage;
typedef void(^DrawCallBlock)(CGContextRef ctx,HMDrawImage* draw);
@interface HMDrawImage : NSObject

@property(nonatomic,readonly) CGContextRef ctx;

@property (readonly) CGSize contextSize;

@property (nonatomic, assign) BOOL isPNG;

@property (nonatomic, assign) BOOL hasAlpha;

- (instancetype)initWithSize:(CGSize)size ForCallback:(DrawCallBlock)call;

- (instancetype)initWithSize:(CGSize)size isPNG:(BOOL)flag ForCallback:(DrawCallBlock)call;
 
- (instancetype)initWithBitmapBuffer:(void *)buffer Size:(CGSize)size ForCallback:(DrawCallBlock)call;

- (void)render;
- (UIImage *)synchronization;
- (CGImageRef)synchronizationGC;

- (void)asynchronization:(void(^)(UIImage *))callback;
@end
CGContextRef createContext(CGSize size,CGFloat scale,void* _Nullable bitmapBuffer);
CGContextRef createContextNoAlpha(CGSize size,CGFloat scale,CGColorRef fillColor,void* _Nullable bitmapBuffer);
CGImageRef CGBitContextExportPNG(CGContextRef ctx,CGFloat quality);
CGImageRef CGBitContextExportJPG(CGContextRef ctx,CGFloat quality);
NS_ASSUME_NONNULL_END
