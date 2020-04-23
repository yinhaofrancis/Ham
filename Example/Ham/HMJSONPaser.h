//
//  HMJSONPaser.h
//  Ham_Example
//
//  Created by hao yin on 2020/3/31.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HMJSONKeyValueProtocol <NSObject>
@optional
- (id) toJSON:(NSString *) key;

- (id) toModel:(NSString *) key type:(NSString *)type;
@end

@interface HMJSONPaser : NSObject
- (id)json:(NSObject *)obj;
- (id)model:(id)json modelClass:(Class)cls;
@property(nonatomic,copy) NSString* dateFormat;
@end

NS_ASSUME_NONNULL_END
