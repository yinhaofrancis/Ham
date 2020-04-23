//
//  HMURL.h
//  Ham
//
//  Created by hao yin on 2019/9/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMURL : NSURL

@property (nonatomic, readonly) NSDictionary *param;
@property (nonatomic, readonly) NSDictionary<NSString *,NSString *> *urlParam;

-(instancetype) initWithPath:(NSString *)path param:(nullable NSDictionary *)dic;

- (nullable UIViewController *)open;
+ (nullable UIViewController *)openName:(NSString *)name param:(nullable NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
