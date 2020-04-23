//
//  HMBundle.m
//  Himalaya-core
//
//  Created by hao yin on 2019/7/9.
//

#import "HMBundle.h"

@implementation NSBundle(HMBundle)
-(NSBundle *)resourceBundleWithName:(NSString *)name{

    return [NSBundle bundleWithPath:[self pathForResource:name ofType:@"bundle"]];
}
-(BOOL) nibExistWithName:(NSString *)name bundle:(NSBundle *)bundle{
    return [bundle pathForResource:name ofType:@"nib"].length > 0;
}
@end
