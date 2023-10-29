//
//  Protocols.h
//  example
//
//  Created by wenyang on 2023/10/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginService <NSObject>
- (void)loginWithUserName:(NSString *)username WithPassword:(NSString *)password;
@end

NS_ASSUME_NONNULL_END
