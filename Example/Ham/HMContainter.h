//
//  HMContainter.h
//  Ham_Example
//
//  Created by KnowChat02 on 2019/8/24.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat ItemSizePriority;
extern const CGFloat ItemNotEquelSizePriority;
extern const CGFloat itemRelatePriority;
extern const CGFloat itemRelateLastPriority;
extern const CGFloat ItemSizeWeakPriority;

typedef NS_ENUM(NSUInteger, contentsLayout) {
    contentsFlexStart,
    contentsCenter,
    contentsFlexEnd,
    contentsSpaceBetween,
    contentsSpaceEvenly,
    contentsSpaceAround,
    contentsStretch
};
typedef NS_ENUM(NSUInteger, itemsLayout) {
    itemsFlexStart,
    itemsCenter,
    itemsFlexEnd,
    itemsBaseline,
    itemsStretch
};
NS_ASSUME_NONNULL_BEGIN
@interface UIView (HMLayout)
@property (nonatomic, assign) IBInspectable CGFloat width;

@property (nonatomic, assign) IBInspectable CGFloat height;

@property (nonatomic, assign) IBInspectable CGFloat minWidth;

@property (nonatomic, assign) IBInspectable CGFloat maxWidth;

@property (nonatomic, assign) IBInspectable CGFloat minHeight;

@property (nonatomic, assign) IBInspectable CGFloat maxHeight;

@property (nonatomic, assign) IBInspectable CGFloat grow;

@property (nonatomic, assign) IBInspectable CGFloat shrink;

@property (nonatomic,assign) itemsLayout alignSelf;

-(CGSize)fittingContentSize;

@end
@interface HMContainter : UIView
@property (nonatomic,assign)IBInspectable BOOL wrap;
@property (nonatomic,assign)UILayoutConstraintAxis direction;
@property (nonatomic,assign)contentsLayout justifiContent;
@property (nonatomic,assign)contentsLayout alignContent;
@property (nonatomic,assign)itemsLayout alignItem;

@end

NS_ASSUME_NONNULL_END
