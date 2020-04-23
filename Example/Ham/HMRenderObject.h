//
//  HMRenderObject.h
//  Ham_Example
//
//  Created by KnowChat02 on 2019/12/25.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface HMRenderObject : NSObject
@property(nonatomic,unsafe_unretained,nullable,readonly)CGLayerRef layer;
@property(nonatomic,assign) CGRect rect;
@property(nonatomic,readonly)NSArray<HMRenderObject *> *objects;
@property(nonatomic,readonly,weak)HMRenderObject *superRenderObj;
@property(nonatomic,strong) UIColor* backgroundColor;
- (void)drawWithContext:(CGContextRef)ctx rect:(CGRect)rect;
- (void)render;
- (void)displayInContext:(CGContextRef)ctx;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithContext:(CGContextRef)ctx;
- (void)addSubObject:(HMRenderObject *)renderObject;

@end

NS_ASSUME_NONNULL_END
