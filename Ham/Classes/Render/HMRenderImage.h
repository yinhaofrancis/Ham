//
//  HMRenderImage.h
//  Ham_Example
//
//  Created by hao yin on 2020/5/2.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^renderBlock)(CGContextRef,CGRect);

typedef void(^getImageBlock)(UIImage *);

@interface HMRenderImage : NSObject

@property (nonatomic,readonly) CGContextRef cgContext;

@property (nonatomic,readonly) CIContext *ciContext;

@property (nonatomic,readonly) CIImage *ciImage;

-(instancetype)draw:(renderBlock)callback;

-(void)drawSize:(CGSize)size callback:(getImageBlock)call;

+(instancetype)shared;

@end

NS_ASSUME_NONNULL_END
