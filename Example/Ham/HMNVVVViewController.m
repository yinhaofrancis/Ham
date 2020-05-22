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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self callbackWithName:@"haha" param:nil];
        [self dismissViewControllerAnimated:true completion:nil];
    });
    
}

@synthesize controllerManager;

- (IBAction)t:(id)sender {
    
}
+ (HMModuleMemoryType)memoryType {
    return HMModuleWeakSinglten;
    self respondsToSelector:<#(SEL)#>
}

- (void)application:(nonnull UIApplication *)application performFetchWithCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"HMNVVVViewController");
}
- (void)handleCallbackWithName:(NSString *)name param:(NSDictionary *)param{
    
}


- (void)displayViewController:(nonnull UIViewController *)vc WithName:(nonnull NSString *)name {
    [self pushViewController:vc animated:true];
}



@end

//@HMComponent(HMBackgroundFetch, HMNVVVViewController)
