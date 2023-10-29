//
//  LoginViewController.m
//  example
//
//  Created by wenyang on 2023/10/30.
//


@import Ham;

#import "LoginViewController.h"
#import "Protocols.h"

@interface LoginViewController ()<HMManagedController,HMParamController>
@property(nonatomic,strong) id<LoginService> loginService; //登錄service
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"login %@",self.param[@":role"]];
    self.view.backgroundColor = UIColor.whiteColor;
    //獲取可選參數
    NSString* username = self.param[@"username"];
    NSString* password = self.param[@"password"];
    
    //調用service
    [self.loginService loginWithUserName:username WithPassword:password];
    
    NSString* role = self.param[@":role"]; // 獲取path 參數;
    NSString* name = [NSString stringWithFormat:@"login %@ success",role];
    //回調給起給 起這個VC的對象
    [self callbackWithName:name param:nil];
}

@synthesize controllerManager;

@synthesize param;

@end

HMKeyController("/login/:role", LoginViewController)
