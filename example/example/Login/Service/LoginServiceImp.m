//
//  LoginService.m
//  example
//
//  Created by wenyang on 2023/10/30.
//
@import Ham;

#import "LoginServiceImp.h"
#import "Protocols.h"

@implementation LoginServiceImp
- (void)loginWithUserName:(NSString *)username WithPassword:(NSString *)password{
    NSLog(@"%@,%@ is logined",username,password);
}
@end


HMService(LoginService, LoginServiceImp)
