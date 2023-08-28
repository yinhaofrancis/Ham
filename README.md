# 用法

创建登录服务

KLogin.h 协议头文件
```objective-C

@protocol KLogin <NSObject>

- (void) loginWithAccout:(NSString *)account password:(NSString *)password;

@end

```
登录模块


```objective-C
//KLoginService.h
#import <Foundation/Foundation.h>
#import <Ham/Ham.h>

#import "KLogin.h"

@interface KLoginService : NSObject<HMModule,KLogin>

@end

//KLoginService.m
@implementation KLoginService
+ (HMModuleMemoryType)memoryType{
    return HMModuleSinglten; //单例
}


- (void)loginWithAccout:(NSString *)account password:(NSString *)password{
    // todo login
    NSLog(@"%@,%@",account,password);
}

@end

//协议与服务绑定
HMService(KLogin, KLoginService)

```

创建路由

```Objective-C

#import "KViewController.h"
#import <Ham/HMProtocol.h>
#import <Ham/Ham.h>
#import "KLogin.h"


@interface KViewController ()

@property(nonatomic) id<KLogin> login; //通过路由获取的viewcontroller 可以自动获取依赖的模块 非路由创建的VC 可以通过InstantProtocol(KLogin) 获取登录模块
@property (nonatomic,copy) NSDictionary* param;
@end

@implementation KViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.param);
}
- (instancetype)initWithParam:(NSDictionary *)param;
{
    self = [super init];
    if (self) {
        self.param = param;
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self.login loginWithAccout:self.param[@"account"] password:self.param[@"password"]];
    
}

@end



HMKeyController("/login/:role",KViewController) //路由声明 


```