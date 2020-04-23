//
//  HMVideoMaker.h
//  Ham_Example
//
//  Created by KnowChat02 on 2019/11/6.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface HMVideoMaker : NSObject
-(instancetype) initWithUrl:(NSURL *)url
                   fileType:(AVFileType)ftype
                  videoSize:(CGSize)size;
-(void)writeImage:(CGImageRef)image;
@end

NS_ASSUME_NONNULL_END
