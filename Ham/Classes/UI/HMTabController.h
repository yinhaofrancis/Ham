//
//  HMTabController.h
//  Ham_Example
//
//  Created by KnowChat02 on 2019/7/30.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "HMTabView.h"
#import "HMViewController.h"
NS_ASSUME_NONNULL_BEGIN
@protocol HMTabChildVC <NSObject>

@property(nonatomic,readonly) UIControl<HMTabSelectItem> *selectItems;

@end
@interface HMTabController : HMViewController
@property (nonatomic,weak)IBOutlet HMTabView* tabView;
@property (nonatomic,weak)IBOutlet UIView* containter;
-(void)addChildVC:(UIViewController<HMTabChildVC> *)vc;
-(void)removeChildVC:(UIViewController<HMTabChildVC> *)vc;
@end

NS_ASSUME_NONNULL_END
