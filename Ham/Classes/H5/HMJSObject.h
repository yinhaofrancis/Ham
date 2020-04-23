//
//  HMJSObject.h
//  chufeng
//
//  Created by KnowChat02 on 2019/7/1.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN


typedef void(^NaiveFunction)(WKUserContentController* userContentController,WKScriptMessage *message);

@interface HMJSObject : NSObject<WKScriptMessageHandler>
@property (nonatomic, readonly) NSString* functionName;
@property (nonatomic, readonly) NaiveFunction naiveFuncCallBack;

- (instancetype)initWithNaiveFuntionName:(NSString *)name callback:(NaiveFunction)function;
@end

NS_ASSUME_NONNULL_END
