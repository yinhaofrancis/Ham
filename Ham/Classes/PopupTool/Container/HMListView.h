//
//  HMListView.h
//  chufeng
//
//  Created by KnowChat02 on 2019/7/2.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HMListItem<NSObject>

- (void)onselect:(BOOL)select;
- (UIControl *)itemView;
@end

@interface HMListView : UIView
-(void) addItem:(id<HMListItem>)item;
-(void) clean;
@property (assign, nonatomic) UILayoutConstraintAxis axis;
@property (assign, nonatomic) CGFloat spacing;
@property (assign, nonatomic) UIEdgeInsets scrollInset;
@property (nonatomic,readonly) UIScrollView* scrollView;
-(void)scrollToIndex:(NSInteger)index animation:(BOOL)animation;
@end


NS_ASSUME_NONNULL_END
