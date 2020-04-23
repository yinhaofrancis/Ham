//
//  HMPopupConfigure.h
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/13.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HMPopupModel;
@protocol HMPopupManager;

@protocol HMPopupConfigure <NSObject>

- (instancetype)initWithInfomation:(id<HMPopupModel>)infoObject;

- (void)displayDialog:(UIView*)container infomation:(id<HMPopupModel>)infoObject;

- (void)hideAnimationComplete:(nonnull void (^)(BOOL))handle;

- (void)showAnimationComplete:(nonnull void (^)(BOOL))handle;

- (id<HMPopupModel>)infoObject;

- (NSTimeInterval) showAnimationDuring;
- (NSTimeInterval) hidenAnimationDuring;



@property (weak,nullable)id<HMPopupManager> manager;

@property (weak,nullable)UIViewController *viewController;

@optional
- (nullable UIView*)container;

- (void)reload;

- (UIWindowLevel) windowLevel;

- (BOOL)onKeyWindow;
@end
NS_ASSUME_NONNULL_END
