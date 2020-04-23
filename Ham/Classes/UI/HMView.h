//
//  HMView.h
//  PopUpDisplay
//
//  Created by KnowChat02 on 2019/5/22.
//  Copyright © 2019 hao yin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define HMRGBAColor(rgba) \
[[UIColor alloc] initWithRed:((uint32_t)rgba >> 24) / 255.0 green:(((uint32_t)rgba >> 16) - (((uint32_t)rgba >> 24) << 8)) / 255.0 blue:(((uint32_t)rgba >> 8) - (((uint32_t)rgba >> 24) << 16) - ((((uint32_t)rgba >> 16) - (((uint32_t)rgba >> 24) << 8)) << 8)) / 255.0 alpha:((uint32_t)rgba - (((uint32_t)rgba >> 24) << 24) - ((((uint32_t)rgba >> 16) - (((uint32_t)rgba >> 24) << 8)) << 16) - ((((uint32_t)rgba >> 8) - (((uint32_t)rgba >> 24) << 16) - ((((uint32_t)rgba >> 16) - (((uint32_t)rgba >> 24) << 8)) << 8)) << 8)) / 255.0]


#define HMColor(rgb) \
HMRGBAColor((rgb >> 24 == 0 ? ((rgb<<8)+0xff) : rgb))

@interface UIView (nib)
+ (nullable UINib*)generateWithName:(NSString*)name bundle:(nullable NSBundle *)bundle owner:(nullable id)owner injectContent:(nullable NSDictionary<NSString*,id> *)contents;
+ (NSArray *)generateInstanceWithName:(NSString *)name bundle:(nullable NSBundle *)bundle owner:(nullable id)owner injectContent:(nullable NSDictionary<NSString *,id> *)contents;

@property (nonatomic,   assign)     IBInspectable CGFloat   cornerRadius;

@property (nonatomic,   assign)     IBInspectable CGFloat   borderWidth;
@property (nonatomic,   copy)       IBInspectable UIColor   *borderColor;

@property (nonatomic,   assign)     IBInspectable UIColor   *shadowColor;
@property (nonatomic,   assign)     IBInspectable CGSize    shadowOffset;
@property (nonatomic,   assign)     IBInspectable CGFloat   shadowRadius;
@property (nonatomic,   assign)     IBInspectable CGFloat   shadowOpacity;


@end


@interface UIButton (nib)


@property (nonatomic,   copy)     IBInspectable UIColor*  normalBackgroundColor;

@property (nonatomic,   copy)     IBInspectable UIColor*  hightlightBackgroundColor;

@property (nonatomic,   copy)     IBInspectable UIColor*  selectBackgroundColor;

@property (nonatomic,   copy)     IBInspectable UIColor*  disableBackgroundColor;

- (void)setBtnBackgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cr withState:(UIControlState)state;

@end

@protocol HMViewDraw <NSObject>

-(void) asyncDisplay;
@optional
-(void)asyncDrawRect:(CGRect)rect withContext:(CGContextRef)ctx;

@end

@interface HMView : UIView<HMViewDraw>

@end

@interface UIColor (hex)
+ (UIColor*) colorWithHex:(long)hexColor;

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
@end
NS_ASSUME_NONNULL_END
