//
//  HMContainter.m
//  Ham_Example
//
//  Created by KnowChat02 on 2019/8/24.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "HMContainter.h"
#import <objc/runtime.h>

const CGFloat ItemSizePriority = 999;
const CGFloat ItemNotEquelSizePriority = 998.9;
const CGFloat itemRelatePriority = 750;
const CGFloat itemRelateLastPriority = 749.9;
const CGFloat ItemSizeWeakPriority = 250;
const CGFloat ItemNotEquelSizeWeakPriority = 249.9;

@implementation UIView(HMLayout)
- (CGSize)fittingContentSize{
    return [self systemLayoutSizeFittingSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
}
- (CGFloat)width{
    return ((NSLayoutConstraint *)objc_getAssociatedObject(self, "width")).constant ;
}
- (void)setWidth:(CGFloat)width{
    if(width <= 0){
        [self removeConstraint:objc_getAssociatedObject(self, "width")];
    }else{
        NSLayoutConstraint* constraint = [self.widthAnchor constraintEqualToConstant:width];
        constraint.identifier = @"width";
        constraint.priority = ItemSizePriority;
        self.translatesAutoresizingMaskIntoConstraints = false;
        [self addConstraint:constraint];
        objc_setAssociatedObject(self, "width", constraint, OBJC_ASSOCIATION_ASSIGN);
    }
}
- (CGFloat)height{
    return ((NSLayoutConstraint *)objc_getAssociatedObject(self, "height")).constant ;
}
- (void)setHeight:(CGFloat)height{
    if(height <= 0){
        [self removeConstraint:objc_getAssociatedObject(self, "height")];
    }else{
        NSLayoutConstraint* constraint = [self.heightAnchor constraintEqualToConstant:height];
        constraint.identifier = @"height";
        constraint.priority = ItemSizePriority;
        self.translatesAutoresizingMaskIntoConstraints = false;
        [self addConstraint:constraint];
        objc_setAssociatedObject(self, "height", constraint, OBJC_ASSOCIATION_ASSIGN);
    }
}


- (CGFloat)maxWidth{
    return ((NSLayoutConstraint *)objc_getAssociatedObject(self, "maxWidth")).constant ;
}
- (void)setMaxWidth:(CGFloat)width{
    if(width <= 0){
        [self removeConstraint:objc_getAssociatedObject(self, "maxWidth")];
    }else{
        NSLayoutConstraint* constraint = [self.widthAnchor constraintLessThanOrEqualToConstant:width];
        constraint.identifier = @"maxWidth";
        constraint.priority = ItemNotEquelSizePriority;
        self.translatesAutoresizingMaskIntoConstraints = false;
        [self addConstraint:constraint];
        objc_setAssociatedObject(self, "maxWidth", constraint, OBJC_ASSOCIATION_ASSIGN);
    }
}
- (CGFloat)maxHeight{
    return ((NSLayoutConstraint *)objc_getAssociatedObject(self, "maxHeight")).constant ;
}
- (void)setMaxHeight:(CGFloat)height{
    if(height <= 0){
        [self removeConstraint:objc_getAssociatedObject(self, "maxHeight")];
    }else{
        NSLayoutConstraint* constraint = [self.heightAnchor constraintLessThanOrEqualToConstant:height];
        constraint.identifier = @"maxHeight";
        constraint.priority = ItemNotEquelSizePriority;
        self.translatesAutoresizingMaskIntoConstraints = false;
        [self addConstraint:constraint];
        objc_setAssociatedObject(self, "maxHeight", constraint, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (CGFloat)minWidth{
    return ((NSLayoutConstraint *)objc_getAssociatedObject(self, "minWidth")).constant ;
}
- (void)setMinWidth:(CGFloat)width{
    if(width <= 0){
        [self removeConstraint:objc_getAssociatedObject(self, "minWidth")];
    }else{
        NSLayoutConstraint* constraint = [self.widthAnchor constraintGreaterThanOrEqualToConstant:width];
        constraint.identifier = @"minWidth";
        constraint.priority = ItemNotEquelSizePriority;
        self.translatesAutoresizingMaskIntoConstraints = false;
        [self addConstraint:constraint];
        objc_setAssociatedObject(self, "minWidth", constraint, OBJC_ASSOCIATION_ASSIGN);
    }
}
- (CGFloat)minHeight{
    return ((NSLayoutConstraint *)objc_getAssociatedObject(self, "minHeight")).constant ;
}
- (void)setMinHeight:(CGFloat)height{
    if(height <= 0){
        [self removeConstraint:objc_getAssociatedObject(self, "minHeight")];
    }else{
        NSLayoutConstraint* constraint = [self.widthAnchor constraintGreaterThanOrEqualToConstant:height];
        constraint.identifier = @"minHeight";
        self.translatesAutoresizingMaskIntoConstraints = false;
        constraint.priority = ItemNotEquelSizePriority;
        [self addConstraint:constraint];
        objc_setAssociatedObject(self, "minHeight", constraint, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (CGFloat)grow{
    NSNumber* num = objc_getAssociatedObject(self, "grow");
    return [num doubleValue];
}
- (void)setGrow:(CGFloat)grow{
    objc_setAssociatedObject(self, "grow", @(grow), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setContentHuggingPriority:grow <=0 ? 1000:1 forAxis:UILayoutConstraintAxisVertical];
    [self setContentHuggingPriority:grow <=0 ? 1000:1 forAxis:UILayoutConstraintAxisHorizontal];
}

- (CGFloat)shrink{
    NSNumber* num = objc_getAssociatedObject(self, "shrink");
    return [num doubleValue];
}
- (void)setShrink:(CGFloat)shrink{
    objc_setAssociatedObject(self, "shrink", @(shrink), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setContentCompressionResistancePriority:(shrink <=0 ? 1000:1) forAxis:UILayoutConstraintAxisVertical];
    [self setContentCompressionResistancePriority:(shrink <=0 ? 1000:1) forAxis:UILayoutConstraintAxisHorizontal];
}
- (itemsLayout)alignSelf{
    return [objc_getAssociatedObject(self, "alignSelf") integerValue];
}
- (void)setAlignSelf:(itemsLayout)alignSelf{
    objc_setAssociatedObject(self, "alignSelf", @(alignSelf), OBJC_ASSOCIATION_ASSIGN);
}
- (itemsLayout)alignSelf{
    return [objc_getAssociatedObject(self, "alignSelf") integerValue];
}
- (void)setAlignSelf:(itemsLayout)alignSelf{
    objc_setAssociatedObject(self, "alignSelf", @(alignSelf), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@interface HMContainter ()
@property (nonnull,nonatomic) NSMutableArray<NSMutableArray<UIView *> *>* viewLines;
@property (nonnull,nonatomic) NSMutableArray<UILayoutGuide *> *guides;
@property (nonnull,nonatomic) NSMutableArray<NSLayoutConstraint*> *startConstaint;
@property (nonnull,nonatomic) NSMutableArray<NSLayoutConstraint*> *guideStartConstaint;
@property (nonnull,nonatomic) NSMutableArray<NSLayoutConstraint*> *guideEndConstaint;
@property (nonnull,nonatomic) NSMutableArray<NSLayoutConstraint*> *guideCenterConstaint;
@property (nonnull,nonatomic) NSMutableArray<NSLayoutConstraint*> *itemSpaceConstaint;
@end


@implementation HMContainter
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.guides = [[NSMutableArray alloc] init];
        self.viewLines = [[NSMutableArray alloc] init];
        self.startConstaint = [[NSMutableArray alloc] init];
        self.guideStartConstaint = [[NSMutableArray alloc] init];
        self.guideEndConstaint = [[NSMutableArray alloc] init];
        self.guideCenterConstaint = [[NSMutableArray alloc] init];
        self.itemSpaceConstaint = [[NSMutableArray alloc] init];
        self.direction = UILayoutConstraintAxisHorizontal;
        self.justifiContent = contentsFlexStart;
        self.alignContent = contentsFlexStart;
        self.alignItem = contentsStretch;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if(self.wrap){
        [self divideLine];
    }else{
        self.guides = [[NSMutableArray alloc] initWithObjects:UILayoutGuide.new, nil];
        [self.viewLines addObject:self.subviews.mutableCopy];
        
    }
    
}
-(void)divideLine{
    CGFloat sum = 0;
    CGFloat max = 0;
    NSMutableArray* array = [[NSMutableArray alloc] init];
    if(self.direction == UILayoutConstraintAxisHorizontal){
        max = self.fittingContentSize.width;
    }else{
        max = self.fittingContentSize.height;
    }
    for (int i = 0; i < self.subviews.count; i++) {
        UIView* v = self.subviews[i];
        
        if(self.direction == UILayoutConstraintAxisHorizontal){
            sum += v.fittingContentSize.width;
        }else{
            sum += v.fittingContentSize.height;
        }
        if(sum < max){
            [array addObject:v];
        }else{
            if(array.count == 0){
                [array addObject:v];
                [self.viewLines addObject:array];
                UILayoutGuide* guide = [UILayoutGuide.alloc init];
                [self addLayoutGuide:guide];
                [self.guides addObject:guide];
                array = [[NSMutableArray alloc] init];
            }else{
                [self.viewLines addObject:array];
                UILayoutGuide* guide = [UILayoutGuide.alloc init];
                [self addLayoutGuide:guide];
                [self.guides addObject:guide];
                array = [[NSMutableArray alloc] init];
                --i;
            }
            sum = 0;
        }
    }
}
<<<<<<< HEAD
- (void)justify{
    switch (self.justifiContent) {
        case contentsFlexStart:{
                for (int i = 0; i < self.viewLines.count; i++) {
                    UILayoutGuide* guide = self.guides[i];
                    NSArray *views = self.viewLines[i];
                    [self guideStart:guide];
                    [self itemLayoutSpace:0 startvalue:0 views:views guide:guide];
                }
            }
            break;
        case contentsCenter:{
            for (int i = 0; i < self.viewLines.count; i++) {
                UILayoutGuide* guide = self.guides[i];
                NSArray *views = self.viewLines[i];
                [self guideCenter:guide];
                [self itemLayoutSpace:0 startvalue:0 views:views guide:guide];
            }
        }
            break;
        case contentsFlexEnd:{
            for (int i = 0; i < self.viewLines.count; i++) {
                UILayoutGuide* guide = self.guides[i];
                NSArray *views = self.viewLines[i];
                [self guideEnd:guide];
                [self itemLayoutSpace:0 startvalue:0 views:views guide:guide];
            }
        }
            break;
        case contentsSpaceBetween:{
            for (int i = 0; i < self.viewLines.count; i++) {
                UILayoutGuide* guide = self.guides[i];
                NSArray *views = self.viewLines[i];
                [self guideEnd:guide];
                [self guideStart:guide];
                CGFloat extra = [self lineExtraSize:i];
                if(views.count > 1){
                    [self itemLayoutSpace:extra / views.count startvalue:0 views:views guide:guide];
                }else{
                    [self itemLayoutSpace:0 startvalue:0 views:views guide:guide];
                }
            }
        }
            break;
        case contentsSpaceEvenly:{
            for (int i = 0; i < self.viewLines.count; i++) {
                UILayoutGuide* guide = self.guides[i];
                NSArray *views = self.viewLines[i];
                [self guideEnd:guide];
                [self guideStart:guide];
                CGFloat extra = [self lineExtraSize:i];
                [self itemLayoutSpace:extra / (views.count + 1) startvalue:extra / (views.count + 1) views:views guide:guide];
            }
        }
            break;
        case contentsSpaceAround:{
            for (int i = 0; i < self.viewLines.count; i++) {
                UILayoutGuide* guide = self.guides[i];
                NSArray *views = self.viewLines[i];
                [self guideEnd:guide];
                [self guideStart:guide];
                CGFloat extra = [self lineExtraSize:i];
                [self itemLayoutSpace:extra / (views.count * 2) startvalue:extra / (views.count * 2) / 2 views:views guide:guide];
            }
        }
            break;
        case contentsStretch:{
            
        }
            break;
        default:
            break;
    }
}
=======
>>>>>>> e33ecc7304467e2cb5121637b3084ea108433ee4
-(void)itemLayoutSpace:(CGFloat)value startvalue:(CGFloat)startValue views:(NSArray<UIView*> *)views guide:(UILayoutGuide *)guide{
    for (int j = 0 ; j < views.count; j++) {
        if(j == 0){
            NSLayoutConstraint* contrait = [[self directionStartCheck:views[j]] constraintEqualToAnchor:[self directionGuideStartCheck:guide] constant:startValue];
            contrait.priority = itemRelatePriority;
            [self.startConstaint addObject:contrait];
            [self addConstraint:contrait];
        }else{
            NSLayoutConstraint* contrait = [[self directionStartCheck:views[j]] constraintEqualToAnchor:[self directionGuideStartCheck:guide] constant:value];
            [self.itemSpaceConstaint addObject:contrait];
            contrait.priority = itemRelatePriority;
            [self addConstraint:contrait];
        }
    }
}
-(void)itemLayoutSize:(CGFloat)value views:(NSArray<UIView*> *)views guide:(UILayoutGuide *)guide{
    if(value > 0){
        CGFloat growsum = 0;
        for (UIView * v in views) {
            growsum += v.grow;
        }
        for (UIView* v in views) {
            CGFloat size = value * v.grow / growsum + v.width;
            v.translatesAutoresizingMaskIntoConstraints = false;
            NSLayoutConstraint *containt = [[self directionSizeCheck:v] constraintEqualToConstant:size];
            containt.priority = ItemSizeWeakPriority;
            [v addConstraint:containt];
        }
    }else if (value < 0){
        CGFloat shrinksum = 0;
        for (UIView * v in views) {
            shrinksum += v.shrink;
        }
        for (UIView* v in views) {
            CGFloat size = value * v.shrink / shrinksum + v.width;
            v.translatesAutoresizingMaskIntoConstraints = false;
            NSLayoutConstraint *containt = [[self directionSizeCheck:v] constraintEqualToConstant:size];
            containt.priority = ItemSizeWeakPriority;
            [v addConstraint:containt];
        }
    }else{
        
    }
}

-(void)alignViews:(NSArray<UIView*> *)views guide:(UILayoutGuide *)guide alignOption:(itemsLayout)align{
    switch (align) {
        case itemsFlexStart:{
            for (UIView * v in views) {
                NSLayoutConstraint* containt = [[self alignStartCheck:v] constraintEqualToAnchor: [self alignGuideStartCheck:guide]];
                containt.priority = itemRelatePriority;
                self.translatesAutoresizingMaskIntoConstraints = false;
                [self addConstraint:containt];
            }
        }
            break;
        case itemsCenter:{
            for (UIView * v in views) {
                NSLayoutConstraint* containt = [[self alignCenterCheck:v] constraintEqualToAnchor: [self alignGuideCenterCheck:guide]];
                containt.priority = itemRelatePriority;
                self.translatesAutoresizingMaskIntoConstraints = false;
                [self addConstraint:containt];
            }
        }
            break;
        case itemsFlexEnd:{
            for (UIView * v in views) {
                NSLayoutConstraint* containt = [[self alignCenterCheck:v] constraintEqualToAnchor: [self alignGuideCenterCheck:guide]];
                containt.priority = itemRelatePriority;
                self.translatesAutoresizingMaskIntoConstraints = false;
                [self addConstraint:containt];
            }
        }
            break;
        case itemsStretch:
            break;
        case itemsBaseline:
            break;
        default:
            break;
    }
}
-(void)guideStart:(UILayoutGuide *)guide{
    NSLayoutConstraint* startGuide = [[self directionGuideStartCheck:guide] constraintEqualToAnchor:[self directionStartCheck:self]];
    startGuide.priority = itemRelatePriority;
    [self addConstraint:startGuide];
    [self.guideStartConstaint addObject:startGuide];
}
-(void)guideEnd:(UILayoutGuide *)guide{
    NSLayoutConstraint* endGuide = [[self directionGuideEndCheck:guide] constraintEqualToAnchor:[self directionEndCheck:self]];
    endGuide.priority = itemRelatePriority;
    [self addConstraint:endGuide];
    [self.guideEndConstaint addObject:endGuide];
}
-(void)guideCenter:(UILayoutGuide *)guide{
    NSLayoutConstraint* endGuide = [[self directionGuideCenterCheck:guide] constraintEqualToAnchor:[self directionCenterCheck:self]];
    [self addConstraint:endGuide];
    endGuide.priority = itemRelatePriority;
    [self.guideCenterConstaint addObject:endGuide];
}
-(NSLayoutAnchor *)directionStartCheck:(UIView*)view{
    if(self.direction == UILayoutConstraintAxisHorizontal){
        return view.leftAnchor;
    }else{
        return view.topAnchor;
    }
}

-(NSLayoutAnchor *)directionEndCheck:(UIView*)view{
    if(self.direction == UILayoutConstraintAxisHorizontal){
        return view.rightAnchor;
    }else{
        return view.bottomAnchor;
    }
}

-(NSLayoutDimension *)directionSizeCheck:(UIView*)view{
    if(self.direction == UILayoutConstraintAxisHorizontal){
        return view.widthAnchor;
    }else{
        return view.heightAnchor;
    }
}
-(NSLayoutAnchor *)directionGuideStartCheck:(UILayoutGuide *)guide{
    if(self.direction == UILayoutConstraintAxisHorizontal){
        return guide.leftAnchor;
    }else{
        return guide.topAnchor;
    }
}
-(NSLayoutAnchor *)directionGuideEndCheck:(UILayoutGuide *)guide{
    if(self.direction == UILayoutConstraintAxisHorizontal){
        return guide.rightAnchor;
    }else{
        return guide.bottomAnchor;
    }
}
-(NSLayoutAnchor *)directionCenterCheck:(UIView*)view{
    if(self.direction == UILayoutConstraintAxisHorizontal){
        return view.centerXAnchor;
    }else{
        return view.centerYAnchor;
    }
}
-(NSLayoutAnchor *)directionGuideCenterCheck:(UILayoutGuide *)guide{
    if(self.direction == UILayoutConstraintAxisHorizontal){
        return guide.centerXAnchor;
    }else{
        return guide.centerYAnchor;
    }
}
<<<<<<< HEAD
- (CGFloat)lineExtraSize:(NSInteger)index{
    NSArray * array = self.viewLines[index];
    CGFloat maxSize = (self == UILayoutConstraintAxisHorizontal ? [self fittingContentSize].width : [self fittingContentSize].height);
    CGFloat sum = 0;
    for (UIView *view in array) {
        if(self.direction == UILayoutConstraintAxisHorizontal){
            sum += [view fittingContentSize].width;
        }else{
            sum += [view fittingContentSize].height;
        }
    }
    return maxSize - sum;
}
=======
///////////////////////////////////////////////////////////
-(NSLayoutAnchor *)alignStartCheck:(UIView*)view{
    if(self.direction == UILayoutConstraintAxisHorizontal){
        return view.topAnchor;
    }else{
        return view.leftAnchor;
    }
}
-(NSLayoutAnchor *)alignEndCheck:(UIView*)view{
    if(self.direction == UILayoutConstraintAxisHorizontal){
        return view.bottomAnchor;
    }else{
        return view.rightAnchor;
    }
}

-(NSLayoutAnchor *)alignGuideStartCheck:(UILayoutGuide *)guide{
    if(self.direction == UILayoutConstraintAxisHorizontal){
        return guide.topAnchor;
    }else{
        return guide.leftAnchor;
    }
}

-(NSLayoutAnchor *)alignGuideEndCheck:(UILayoutGuide *)guide{
    if(self.direction == UILayoutConstraintAxisHorizontal){
        return guide.bottomAnchor;
    }else{
        return guide.rightAnchor;
    }
}
-(NSLayoutAnchor *)alignCenterCheck:(UIView*)view{
    if(self.direction == UILayoutConstraintAxisHorizontal){
        return view.centerYAnchor;
    }else{
        return view.centerXAnchor;
    }
}
-(NSLayoutAnchor *)alignGuideCenterCheck:(UILayoutGuide *)guide{
    if(self.direction == UILayoutConstraintAxisHorizontal){
        return guide.centerYAnchor;
    }else{
        return guide.centerXAnchor;
    }
}
-(NSLayoutDimension *)alighSizeCheck:(UIView*)view{
    if(self.direction == UILayoutConstraintAxisHorizontal){
        return view.heightAnchor;
    }else{
        return view.widthAnchor;
    }
}

>>>>>>> e33ecc7304467e2cb5121637b3084ea108433ee4
- (void)align{
    
}

@end
