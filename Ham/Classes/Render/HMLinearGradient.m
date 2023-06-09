//
//  HMLinearGradient.m
//  Ham_Example
//
//  Created by KnowChat02 on 2019/12/6.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "HMLinearGradient.h"
#import "HMDrawImage.h"

@interface HMLinearGradient ()
@property (nonatomic,nullable)HMDrawImage* draw;
@end

@implementation HMLinearGradient{
    
    CGSize canvasSize;
};
- (instancetype)initWithCanvasSize:(CGSize)size{
    self = [super init];
    if (self) {
        canvasSize = size;
        self.angle = 0;
    }
    return self;
}
- (void)renderWithRect:(CGRect)rect call:(void(^)(UIImage *))callback{
    
    __weak HMLinearGradient* wself = self;
    self.draw = [[HMDrawImage alloc] initWithSize:self->canvasSize ForCallback:^(CGContextRef  _Nonnull ctx,HMDrawImage* draw) {
        CGFloat* colorLocations = [wself cglocations];
        CGFloat * colors = [wself cgcolors];
        CGColorSpaceRef csp = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(csp, colors, colorLocations, wself.colors.count);
        
        CGPoint start;
        CGPoint end;
        start.x = [wself XFuncRadius:MIN(rect.size.width, rect.size.height)/ 2 angle:wself.angle center:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))];
        start.y = [wself YFuncRadius:MIN(rect.size.width, rect.size.height)/ 2 angle:wself.angle center:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))];
        end.x = [wself XFuncRadius:MIN(rect.size.width, rect.size.height)/ 2 angle:wself.angle + M_PI center:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))];
        end.y = [wself YFuncRadius:MIN(rect.size.width, rect.size.height)/ 2 angle:wself.angle + M_PI center:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))];
        CGContextDrawLinearGradient(ctx, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
        free(colorLocations);
        free(colors);
        CGGradientRelease(gradient);
        CGColorSpaceRelease(csp);
        wself.draw = nil;
    }];
    self.draw.isPNG = true;
    [self.draw asynchronization:callback];
}

- (CGFloat *)cgcolors{
    CGFloat * colors = malloc(sizeof(CGFloat) * self.colors.count * 4);
    for (int i = 0 ; i < self.colors.count; i ++) {
        memcpy(colors + i * 4, CGColorGetComponents(self.colors[i].CGColor), sizeof(CGFloat) * 4);
    }
    
    return colors;
}
- (CGFloat *)cglocations{
    CGFloat *locations = malloc(sizeof(CGFloat) * self.location.count);
    for (int i = 0 ; i < self.location.count; i ++) {
        locations[i] = [self.location[i] doubleValue];
    }
    return locations;
}

-(CGFloat)XFuncRadius:(CGFloat)r angle:(CGFloat)theta center:(CGPoint)o{
    return o.x + r * cos(theta);
}
-(CGFloat)YFuncRadius:(CGFloat)r angle:(CGFloat)theta center:(CGPoint)o{
    return o.y + r * sin(theta);
}
@end

@implementation UIColor (colorMix)

+ (UIColor *)mix:(UIColor *)left with:(UIColor *)right percent:(CGFloat)per{
    const CGFloat *lefts = CGColorGetComponents(left.CGColor);
    const CGFloat *rights = CGColorGetComponents(right.CGColor);
    return [[UIColor alloc] initWithRed:lefts[0] * per + rights[0] * (1 - per)
                                  green:lefts[1] * per + rights[1] * (1 - per) blue:lefts[2] * per + rights[2] * (1 - per) alpha:lefts[3] * per + rights[3] * (1 - per)];
}

@end
