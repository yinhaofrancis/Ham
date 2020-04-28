//
//  HMURL.h
//  Ham
//
//  Created by hao yin on 2019/9/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (HMURL)

@property (nonatomic, readonly) NSDictionary<NSString *,NSString *> *urlParam;

- (nullable UIViewController *)open;

@end

NS_ASSUME_NONNULL_END
