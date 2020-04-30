//
//  HMTestSceneViewController.h
//  Ham_Example
//
//  Created by hao yin on 2020/3/23.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Ham/Ham.h>
NS_ASSUME_NONNULL_BEGIN

@interface HMTestSceneViewController : UIViewController<HMNameController,HMParamController,HMManagedController>
defineAssociatedProperty(copy, haha, NSString)
@end

NS_ASSUME_NONNULL_END
