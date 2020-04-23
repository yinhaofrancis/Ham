//
//  CFGView.m
//  PopUpDisplay
//
//  Created by KnowChat02 on 2019/5/22.
//  Copyright © 2019 hao yin. All rights reserved.
//

#import "HMView.h"
#import "HMDrawImage.h"
#import <objc/runtime.h>

@implementation UIView (nib)

+ (UINib *)generateWithName:(NSString *)name bundle:(NSBundle *)bundle owner:(nullable id)owner injectContent:(nullable NSDictionary<NSString *,id> *)contents{
    if(bundle == nil){
        bundle = [NSBundle mainBundle];
    }
    if (![bundle pathForResource:name ofType:@"nib"]){
        return nil;
    }
    UINib *n = [UINib nibWithNibName:name bundle:bundle];
    if(contents == nil){
        [n instantiateWithOwner:owner options:nil];
    }else{
        [n instantiateWithOwner:owner options:@{UINibExternalObjects:contents}];
    }
    return n;
}
+ (NSArray *)generateInstanceWithName:(NSString *)name bundle:(NSBundle *)bundle owner:(nullable id)owner injectContent:(nullable NSDictionary<NSString *,id> *)contents{
    if(bundle == nil){
        bundle = [NSBundle mainBundle];
    }
    if (![bundle pathForResource:name ofType:@"nib"]){
        return @[];
    }
    UINib *n = [UINib nibWithNibName:name bundle:bundle];
    if(contents == nil){
        return [n instantiateWithOwner:owner options:nil];
    }else{
        return [n instantiateWithOwner:owner options:@{UINibExternalObjects:contents}];
    }
}
- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}
- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}
- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}
- (UIColor *)borderColor{
    return [[UIColor alloc] initWithCGColor:self.layer.borderColor];
}
- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}
- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}
- (void)setShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
}
- (UIColor *)shadowColor{
    return [[UIColor alloc] initWithCGColor:self.layer.shadowColor];
}
- (void)setShadowRadius:(CGFloat)shadowRadius{
    self.layer.shadowRadius = shadowRadius;
}
- (CGFloat)shadowRadius{
    return self.layer.shadowRadius;
}
- (void)setShadowOffset:(CGSize)shadowOffset{
    self.layer.shadowOffset = shadowOffset;
}
- (CGSize)shadowOffset{
    return self.layer.shadowOffset;
}
- (CGFloat)shadowOpacity{
    return self.layer.shadowOpacity;
}
- (void)setShadowOpacity:(CGFloat)shadowOpacity{
    self.layer.shadowOpacity = shadowOpacity;
}

@end

@implementation UIButton (nib)

- (UIColor *)normalBackgroundColor{
    return objc_getAssociatedObject(self, "normalBackgroundColor");
}
- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor{
    objc_setAssociatedObject(self, "normalBackgroundColor", normalBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setBtnBackgroundColor:normalBackgroundColor cornerRadius:0 withState:UIControlStateNormal];
}
- (UIColor *)hightlightBackgroundColor{
    return objc_getAssociatedObject(self, "hightlightBackgroundColor");
}
- (void)setHightlightBackgroundColor:(UIColor *)hightlightBackgroundColor{
    objc_setAssociatedObject(self, "hightlightBackgroundColor", hightlightBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setBtnBackgroundColor:hightlightBackgroundColor cornerRadius:0 withState:UIControlStateHighlighted];
}
- (UIColor *)selectBackgroundColor{
    return objc_getAssociatedObject(self, "selectBackgroundColor");
}
- (void)setSelectBackgroundColor:(UIColor *)selectBackgroundColor {
    objc_setAssociatedObject(self, "selectBackgroundColor", selectBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setBtnBackgroundColor:selectBackgroundColor cornerRadius:0 withState:UIControlStateSelected];
}
- (UIColor *)disableBackgroundColor{
    return objc_getAssociatedObject(self, "disableBackgroundColor");
}
- (void)setDisableBackgroundColor:(UIColor *)disableBackgroundColor{
    objc_setAssociatedObject(self, "disableBackgroundColor", disableBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setBtnBackgroundColor:disableBackgroundColor cornerRadius:0 withState:UIControlStateDisabled];
}

- (void)setBtnBackgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cr withState:(UIControlState)state{
    cr = cr > 0 ? cr : 1;
    [[[HMDrawImage alloc] initWithSize:CGSizeMake(2,2) ForCallback:^(CGContextRef  _Nonnull ctx) {
//        CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 0, 2, 2), nil);
        CGPathRef path = CGPathCreateWithRoundedRect(CGRectMake(0, 0, cr * 3, cr * 3), cr, cr, nil);
        CGContextAddPath(ctx, path);
        CGContextSetFillColorWithColor(ctx, backgroundColor.CGColor);
        CGContextFillPath(ctx);
        CGPathRelease(path);
    }] asynchronization:^(UIImage * _Nullable image) {
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.4, 0.4, 0.4, 0.4) resizingMode:UIImageResizingModeStretch];
        [self setBackgroundImage:image forState:state];
    }];
}
@end

@interface HMView()
@property (nonatomic,strong) dispatch_semaphore_t semaphore;
@end

@implementation HMView

+(dispatch_queue_t)createQueue{
    static dispatch_queue_t q;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        q = dispatch_queue_create("HMViewQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    return q;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.semaphore = dispatch_semaphore_create(1);
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.semaphore = dispatch_semaphore_create(1);
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.semaphore = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self asyncDisplay];
}
- (void)asyncDisplay{
    CGRect rect = self.bounds;
    BOOL isOpaque = self.isOpaque;
    dispatch_async([HMView createQueue], ^{
        if([self respondsToSelector:@selector(asyncDrawRect:withContext:)]){
            if(rect.size.width <= 0 || rect.size.height <= 0){
                return;
            }
            long result = dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_NOW + NSEC_PER_MSEC * 100);
            if(result != 0){
                return;
            }
            
            CGContextRef ctx = createContext(rect.size, UIScreen.mainScreen.scale,nil);
            CGContextTranslateCTM(ctx, 0, rect.size.height);
            CGContextScaleCTM(ctx, 1, -1);
            [self asyncDrawRect:rect withContext:ctx];
            CGImageRef image;
            if (isOpaque) {
                image = CGBitContextExportJPG(ctx, 1);
            }else{
                image = CGBitContextExportPNG(ctx, 1);
            }
            CGContextRelease(ctx);
            dispatch_semaphore_signal(self.semaphore);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.layer.contents = (__bridge id _Nullable)(image);
                CGImageRelease(image);
            });
        }
    });
}
@end

@implementation UIColor (hex)

+ (UIColor*) colorWithHex:(long)hexColor
{
    return [UIColor colorWithHex:hexColor alpha:1.];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}
@end
