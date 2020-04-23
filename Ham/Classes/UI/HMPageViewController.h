//
//  HMPageViewController.h
//  Ham_Example
//
//  Created by KnowChat02 on 2019/11/14.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "UI.h"
#import "Ham.h"
NS_ASSUME_NONNULL_BEGIN
@class HMPageViewController;
@protocol HMPageViewControllerItem <NSObject>
@property (nonatomic,assign) NSInteger index;
@optional
- (void)HMPageViewControllerDidSelect:(HMPageViewController *)pageVC;
- (void)HMPageViewControllerDidDeselect:(HMPageViewController *)pageVC;

@property (nonatomic,weak)HMPageViewController* pageContainerController;

@end

@interface HMPageViewController : HMViewController
@property (nonatomic,readonly) UIScrollView* scrollView;
@property (copy,nonatomic) NSArray <NSString *> *registerViewControllers;
@property (nonatomic,assign) NSUInteger vcIndex;
-(void)changeIndex:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
