//
//  HMTabView.m
//  Ham_Example
//
//  Created by KnowChat02 on 2019/7/30.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "HMTabView.h"
@implementation UIButton (Select)

- (void)selectState:(BOOL)state{
    self.selected = state;
}
@end
@implementation HMTabView{
    NSMutableArray<UIControl<HMTabSelectItem> *>* array;
    UIStackView *stack;
    __weak UIControl<HMTabSelectItem> * last;
    NSLayoutConstraint *left;
    NSLayoutConstraint *right;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        array = [[NSMutableArray alloc] init];
        stack = [[UIStackView alloc] init];
        [self addSubview:stack];
        self.translatesAutoresizingMaskIntoConstraints = false;
        stack.axis = UILayoutConstraintAxisHorizontal;
        stack.distribution = UIStackViewDistributionFillEqually;
        stack.alignment = UIStackViewAlignmentFill;
        stack.translatesAutoresizingMaskIntoConstraints = false;
        left = [stack.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:self.margin];
        right = [stack.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-self.margin];
        [self addConstraints:@[left,
                               right,
                               [stack.topAnchor constraintEqualToAnchor:self.topAnchor],
                               [stack.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],]];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        array = [[NSMutableArray alloc] init];
        stack = [[UIStackView alloc] init];
        [self addSubview:stack];
        self.translatesAutoresizingMaskIntoConstraints = false;
        stack.axis = UILayoutConstraintAxisHorizontal;
        stack.distribution = UIStackViewDistributionFillEqually;
        stack.alignment = UIStackViewAlignmentFill;
        stack.translatesAutoresizingMaskIntoConstraints = false;
        left = [stack.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:self.margin];
        right = [stack.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-self.margin];
        [self addConstraints:@[left,
                               right,
                               [stack.topAnchor constraintEqualToAnchor:self.topAnchor],
                               [stack.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],]];
    }
    return self;
}
- (void)addControl:(UIControl<HMTabSelectItem> *)control{
    
    [stack addSubview:control];
    [stack addArrangedSubview:control];
    
    [control addTarget:self action:@selector(handle:) forControlEvents:UIControlEventTouchUpInside];
    if(stack.arrangedSubviews.count == 1){
        self.selectIndex = 0;
        last = control;
        [control selectState:true];
        [self sendActionsForControlEvents:HMSelectItemEvent];
    }else{
        [control selectState:false];
    }
}
- (void)removeControl:(UIControl<HMTabSelectItem> *)control{
    [stack removeArrangedSubview:control];
    [control removeFromSuperview];
}

- (void) handle:(UIControl<HMTabSelectItem> *)c{
    if(c == last){
        return;
    }
    self.selectIndex = [[stack arrangedSubviews] indexOfObject:c];
    [c selectState:true];
    [last selectState:false];
    last = c;
    [self sendActionsForControlEvents:HMSelectItemEvent];
}
- (void)setMargin:(CGFloat)margin{
    _margin = margin;
    left.constant = margin;
    right.constant = -margin;
}
- (CGFloat)spaceing{
    return stack.spacing;
}
- (void)setSpaceing:(CGFloat)spaceing{
    stack.spacing = spaceing;
}
@end
