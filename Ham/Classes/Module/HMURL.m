//
//  HMURL.m
//  Ham
//
//  Created by hao yin on 2019/9/16.
//

#import "HMURL.h"
@implementation NSURL (HMURL)

- (NSDictionary<NSString *,NSString *> *)urlParam{
    NSMutableDictionary* a = [[NSMutableDictionary alloc] init];
    NSURLComponents* comp = [[NSURLComponents alloc] initWithString:self.absoluteString];
    [comp.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [a setObject:obj.value forKey:obj.name];
    }];
    return [a copy];
}
@end
