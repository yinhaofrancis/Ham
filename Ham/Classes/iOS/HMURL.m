//
//  HMURL.m
//  Ham
//
//  Created by hao yin on 2019/9/16.
//

#import "HMURL.h"
#import "HMAnnotation.h"
#import "HMControllerManager.h"
@implementation NSURL (HMURL)

- (UIViewController *)open{
    NSMutableDictionary* mdic = [self.urlParam mutableCopy];
    return [InstantProtocol(HMControllerManager) dequeueViewController:self.path param:mdic];
}
- (NSDictionary<NSString *,NSString *> *)urlParam{
    NSMutableDictionary* a = [[NSMutableDictionary alloc] init];
    NSURLComponents* comp = [[NSURLComponents alloc] initWithString:self.absoluteString];
    [comp.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [a setObject:obj.value forKey:obj.name];
    }];
    return [a copy];
}
@end
