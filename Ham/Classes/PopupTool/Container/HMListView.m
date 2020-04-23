//
//  HMListView.m
//  chufeng
//
//  Created by KnowChat02 on 2019/7/2.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMListView.h"

@implementation HMListView{
    UIScrollView * scroll;
    UIStackView * stack;
    NSMutableArray<id<HMListItem>> *allItem;
    NSArray <NSLayoutConstraint *> * center;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self loadUI];
    }
    return self;
}
- (void)loadUI{
    allItem = [[NSMutableArray alloc] init];
    scroll = [[UIScrollView alloc] init];
    stack = [[UIStackView alloc] init];
    [self addSubview:scroll];
    [scroll addSubview:stack];
    [self edge:scroll container:self];
    [self edge:stack container:scroll];
    stack.distribution = UIStackViewDistributionFill;
    stack.alignment = UIStackViewAlignmentCenter;
    scroll.showsVerticalScrollIndicator = false;
    scroll.showsHorizontalScrollIndicator = false;
    
}
- (void)edge:(UIView *)view container:(UIView *)container{
    view.translatesAutoresizingMaskIntoConstraints = false;
    NSArray<NSLayoutConstraint *> * array = @[
                                            [view.leadingAnchor constraintEqualToAnchor:container.leadingAnchor],
                                            [view.trailingAnchor constraintEqualToAnchor:container.trailingAnchor],
                                            [view.topAnchor constraintEqualToAnchor:container.topAnchor],
                                            [view.bottomAnchor constraintEqualToAnchor:container.bottomAnchor],
                                            ];
    [container addConstraints:array];
    
}
- (void)addItem:(id<HMListItem>)item{
    UIControl * c = item.itemView;
    c.tag = stack.arrangedSubviews.count;
    [stack addSubview:c];
    [stack addArrangedSubview:c];
    c.translatesAutoresizingMaskIntoConstraints = false;
    [allItem addObject:item];
    [c addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setAxis:(UILayoutConstraintAxis)axis{
    if(center.count > 0){
        [scroll removeConstraints:center];
    }
    if(axis == UILayoutConstraintAxisVertical){
        center = @[[stack.centerXAnchor constraintEqualToAnchor:scroll.centerXAnchor]];
    }else{
        center = @[[stack.centerYAnchor constraintEqualToAnchor:scroll.centerYAnchor]];
    }
    [scroll addConstraints:center];
    stack.axis = axis;
}
- (UILayoutConstraintAxis)axis{
    return stack.axis;
}
- (CGFloat)spacing{
    return stack.spacing;
}
- (void)setSpacing:(CGFloat)spacing{
    stack.spacing = spacing;
}
-(void)click:(UIControl *)c{
    for (id<HMListItem> i in allItem) {
        if (i.itemView.tag == c.tag){
            [i onselect:true];
        }else{
            [i onselect:false];
        }
    }
}
- (UIEdgeInsets)scrollInset{
    return scroll.contentInset;
}
- (void)setScrollInset:(UIEdgeInsets)scrollInset{
    scroll.contentInset = scrollInset;
}
- (void)clean{
    for (UIView *v in stack.subviews) {
        [v removeFromSuperview];
        [stack removeArrangedSubview:v];
    }
}
- (UIScrollView *)scrollView{
    return scroll;
}
- (void)scrollToIndex:(NSInteger)index animation:(BOOL)animation{
    id<HMListItem> item = allItem[index];
    [self layoutIfNeeded];
    CGRect rect = item.itemView.frame;
    if(self.axis == UILayoutConstraintAxisVertical){
        if(CGRectGetMaxY(rect) > self.scrollView.frame.size.height){
            CGRect r = CGRectMake(0, CGRectGetMaxY(rect) - self.scrollView.frame.size.height - self.scrollView.contentInset.bottom , self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
            [self.scrollView scrollRectToVisible:r animated:animation];
        }
    }else{
        if(CGRectGetMaxX(rect) > self.scrollView.frame.size.width){
            CGRect r = CGRectMake(CGRectGetMaxX(rect) - self.scrollView.frame.size.width - self.scrollView.contentInset.right, 0 , self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
            [self.scrollView scrollRectToVisible:r animated:animation];
        }
    }
    
}
@end
