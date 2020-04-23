//
//  HMAlertViewController.h
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/13.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMViewController.h"
#import "HMPopupConfigure.h"
#import "HMWindowManager.h"
NS_ASSUME_NONNULL_BEGIN
@class HMPopupController;
@interface HMPopupController : UIViewController<HMWindowObject,UIViewControllerTransitioningDelegate>
- (instancetype)initWithConfigure:(id<HMPopupConfigure>)configure infomation:(id<HMPopupModel>)info;
@end

@interface HMPopupPresentAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic,assign) BOOL isPresnet;
@property (nonatomic,weak) id<HMPopupConfigure> configure;
@end
NS_ASSUME_NONNULL_END
