//
//  HMAudioCoder.h
//  Ham_Example
//
//  Created by hao yin on 2019/10/20.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@protocol HMAudioCoder <NSObject>
-(NSData *)convert:(NSData *)data;
-(void) configration;
@end

NS_ASSUME_NONNULL_END
