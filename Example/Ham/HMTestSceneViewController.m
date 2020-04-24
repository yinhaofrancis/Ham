//
//  HMTestSceneViewController.m
//  Ham_Example
//
//  Created by hao yin on 2020/3/23.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import "HMTestSceneViewController.h"
#import <Ham/Ham.h>
#import "HMModel.h"
#import "HMJSONPaser.h"
#import "HMMaskViewController.h"
@interface HMTestSceneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property(nullable,nonatomic)id<HMWindowManager > windowManager;
@end

@implementation HMTestSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tf becomeFirstResponder];
    
    self.haha = @"aaaaa";
    NSLog(@"%@", self.haha);
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)mask:(id)sender{
    NSLog(@"%@",sender);
}
- (IBAction)showkeyBoard:(id)sender {
    UIViewController *v = HMGetController(@"haha");
    [self.controllerManager  handleName:nil vc:v callback:^(NSNotification * _Nonnull no) {
        NSLog(@"%@",no);
    }];
    [self showViewController:v sender:nil];
//    HMShowRouterWithParam(@"haha", @{@"da":@"d"});
}

- (BOOL)showKeyWindow {
    return true;
}

- (nonnull UIViewController *)rootVC {
    return self;
}

@synthesize param;

@synthesize vcName;
- (void)handleParam:(NSDictionary *)param{
    NSLog(@"%@ | %@",self.vcName,self.param);
}


+ (HMModuleMemoryType)memoryType {
    return HMModuleWeakSinglten;
}

- (void)application:(nonnull UIApplication *)application performFetchWithCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"%@",@"HMTestSceneViewController");
}
@synthesize controllerManager;


synthesizeAssociatedProperty(HMCopy, haha)

@end
@HMComponent(HMBackgroundFetchKK, HMTestSceneViewController)
