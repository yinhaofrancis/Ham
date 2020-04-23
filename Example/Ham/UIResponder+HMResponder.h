//
//  UIResponder+HMResponder.h
//  Ham_Example
//
//  Created by hao yin on 2020/4/17.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (HMResponder)
- (void)raiseResponseToHandle:(SEL)handle withSender:(id)sender;


@end

NS_ASSUME_NONNULL_END
