//
//  HMURL.m
//  Ham
//
//  Created by hao yin on 2019/9/16.
//

#import "HMURL.h"
#import "HMAnnotation.h"
#import "HMControllerManager.h"
@implementation HMURL
- (instancetype)initWithPath:(NSString *)path param:(NSDictionary *)dic{
    self = [super initWithString:path];
    if(self){
        _param = dic;
    }
    return self;
}
- (UIViewController *)open{
    NSMutableDictionary* mdic = [self.urlParam mutableCopy];
    if(self.param != nil){
        [mdic addEntriesFromDictionary:self.param];
    }
    return [InstantProtocol(HMControllerManager) dequeueViewController:self.path param:mdic];
}
+ (UIViewController *)openName:(NSString *)name param:(NSDictionary *)dic{
    return [[[HMURL alloc] initWithPath:name param:dic] open];
}
- (NSDictionary<NSString *,NSString *> *)urlParam{
    NSArray* closure = [self.parameterString componentsSeparatedByString:@"&"];
    NSMutableDictionary* temp = [[NSMutableDictionary alloc] init];
    if(closure.count > 0){
        for (NSString * cl in closure) {
            NSArray* a = [cl componentsSeparatedByString:@"="];
            if(a.count > 1){
                temp[a[0]] = a[1];
            }
        }
        return [temp copy];
    }
    return @{};
}
@end
