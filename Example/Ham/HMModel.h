//
//  HMModel.h
//  Ham_Example
//
//  Created by hao yin on 2020/3/31.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMJSONPaser.h"
NS_ASSUME_NONNULL_BEGIN

struct ik {
    int a;
    CGFloat k;
};

@interface HMModel : NSObject
@property(nonatomic,strong) NSObject *vt;
@property(nonatomic,strong) NSNumber *nt;
@property(nonatomic,strong) NSString *strt;
@property(nonatomic,strong) NSArray<NSObject *> *nst;
@property(nonatomic,assign) int at;
@property(nonatomic,assign) long a1t;
@property(nonatomic,assign) long long a2t;
@property(nonatomic,assign) unsigned long a3t;
@property(nonatomic,assign) unsigned long long a4t;
@property(nonatomic,assign) float a5t;
@property(nonatomic,assign) double a6t;
@property(nonatomic,assign) NSInteger a7t;
@property(nonatomic,assign) NSUInteger a8t;

@end

@interface HMTestModel : NSObject
@property(nonatomic,strong) NSObject *v;
@property(nonatomic,strong) NSNumber *n;
@property(nonatomic,strong) NSString *str;
@property(nonatomic,copy) NSArray<NSObject *> *ns;
@property(nonatomic,copy) NSDictionary* dic;
@property(nonatomic,assign) int8_t it8;
@property(nonatomic,assign) int32_t it32;
@property(nonatomic,assign) int64_t it64;
@property(nonatomic,assign) int16_t it16;
@property(nonatomic,assign) uint8_t uit8;
@property(nonatomic,assign) uint32_t uit32;
@property(nonatomic,assign) uint64_t uit64;
@property(nonatomic,assign) uint16_t uit16;
@property(nonatomic,assign) long a1;
@property(nonatomic,assign) long long a2;
@property(nonatomic,assign) unsigned long a3;
@property(nonatomic,assign) unsigned long long a4;
@property(nonatomic,assign) float a5;
@property(nonatomic,assign) double a6;
@property(nonatomic,assign) NSInteger a7;
@property(nonatomic,assign) NSUInteger a8;
@property(nonatomic,strong) HMModel *model;
@property(nonatomic,assign) CGRect rect;
@property(nonatomic,assign) struct ik pl;
@property(nonatomic,strong) NSDate *date;
@property(nonatomic,strong) NSData *data;
@end

NS_ASSUME_NONNULL_END
