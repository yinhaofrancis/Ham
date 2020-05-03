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

@property (nonatomic,readonly) NSMapTable *drawWorkFlow;

@property (nonatomic,readonly) CGSize contextSize;

-(instancetype)draw:(renderBlock)callback;

-(NSString *)drawSize:(CGSize)size callback:(getImageBlock)call;

-(void)cancel:(NSString *)workName;

-(void)cancelAllWork;

+(instancetype)shared;

@end

NS_ASSUME_NONNULL_END
