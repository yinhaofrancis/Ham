//
//  HMGradient.h
//  Ham_Example
//
//  Created by KnowChat02 on 2019/12/6.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMLinearGradient : NSObject
@property(nonatomic,copy) NSArray<UIColor *> *colors;
@property(nonatomic,copy) NSArray<NSNumber *> *location;
@property(nonatomic,assign) CGFloat angle;
- (void)renderWithRect:(CGRect)rect call:(void(^)(UIImage *))callback;
- (instancetype)initWithCanvasSize:(CGSize)size;
-(instancetype)init UNAVAILABLE_ATTRIBUTE;
@end

@interface UIColor (colorMix)
+(UIColor *)mix:(UIColor *)left with:(UIColor *) right percent:(CGFloat)per;
@end

NS_ASSUME_NONNULL_END
