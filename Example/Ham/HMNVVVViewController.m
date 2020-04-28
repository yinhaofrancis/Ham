//
//  HMNVVVViewController.m
//  Ham_Example
//
//  Created by hao yin on 2020/4/17.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import "HMNVVVViewController.h"
#import <Ham/Ham.h>
@interface HMNVVVViewController ()


@end

@implementation HMNVVVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.brownColor;
    // Do any additional setup after loading the view.
    

}
- (BOOL)showRoute:(nonnull NSString *)name withParam:(nullable NSDictionary *)param {
    if(param.count > 0){
        [self pushViewController:HMGetControllerWithParam(name, param) animated:true];
    }else{
        [self pushViewController:HMGetController(name) animated:true];
    }
    return true;
}

@synthesize controllerManager;

- (IBAction)t:(id)sender {
    
}
+ (HMModuleMemoryType)memoryType {
    return HMModuleWeakSinglten;
}

- (void)application:(nonnull UIApplication *)application performFetchWithCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"HMNVVVViewController");
}



@end


@HMKeyController("/dddd/ddd", HMNVVVViewController)
//@HMComponent(HMBackgroundFetch, HMNVVVViewController)
