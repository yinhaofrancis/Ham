//
//  HMRenderObject.m
//  Ham_Example
//
//  Created by KnowChat02 on 2019/12/25.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "HMRenderObject.h"
#import <Ham/Ham.h>
@implementation HMRenderObject{
    NSMutableArray<HMRenderObject *> *_objects;
}
- (instancetype)initWithContext:(CGContextRef)ctx{
    self = [super init];
    if(self){
        _layer = CGLayerCreateWithContext(ctx, CGSizeMake(CGBitmapContextGetWidth(ctx), CGBitmapContextGetHeight(ctx)), NULL);
        _objects = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)drawWithContext:(CGContextRef)ctx rect:(CGRect)rect{
    CGContextSetFillColorWithColor(ctx, self.backgroundColor.CGColor);
    CGContextFillRect(ctx, rect);
}
- (void)render{
    if(self.rect.size.width != 0 && self.rect.size.height != 0){
        if(self.layer){
            [self drawWithContext:CGLayerGetContext(self.layer) rect:[self drawRect]];
            for (HMRenderObject *obj in self.objects) {
                [obj render];
            }
        }else{
            NSLog(@"layer is empty");
        }
    }else{
        NSLog(@"render object size is zero");
    }
    
}
-(void)displayInContext:(CGContextRef)ctx{
    CGContextDrawLayerAtPoint(ctx, CGPointZero, self.layer);
    for (HMRenderObject *obj in self.objects) {
        CGContextDrawLayerAtPoint(ctx, CGPointZero, obj.layer);
    }
}

- (void)dealloc{
    CGLayerRelease(self.layer);
}
- (void)addSubObject:(HMRenderObject *)renderObject{
    [_objects addObject:renderObject];
    [HMOCRunTimeTool assignIVar:@{@"_superRenderObj":self} ToObject:renderObject];
}
- (NSArray<HMRenderObject *> *)objects{
    return [_objects copy];
}
-(CGRect)drawRect{
    CGRect current = self.rect;
    HMRenderObject *su = self.superRenderObj;
    while (su) {
        current.origin.x += su.rect.origin.x;
        current.origin.y += su.rect.origin.y;
        su = [su superRenderObj];
    }
    return current;
}

- (void)calcLayout {
    
}

- (CGSize)contentSize {
    return self.rect.size;
}

- (void)displayAtFrame:(CGRect)frame {
    
}

- (void)render:(nonnull CGContextRef)ctx frame:(CGRect)rect {
    
}

@end
