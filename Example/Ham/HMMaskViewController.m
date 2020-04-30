//
//  HMMaskViewController.m
//  Ham_Example
//
//  Created by hao yin on 2020/4/17.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import "HMMaskViewController.h"

@interface HMMaskViewController ()

@end

@implementation HMMaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    __weak HMMaskViewController *s = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableDictionary * aa = [self.param mutableCopy];
        NSInteger l = arc4random() % 5 + 1;
        for (int i = 0; i < l; i++) {
            aa[@(i)] = @(l);
        }
        aa[@"back"] = [NSString stringWithFormat:@"%@",[NSDate new]];
        [s callbackWithName:@"haha" param:aa];
    });
}

- (UIViewController *)rootVC{
    return self;
}
- (BOOL)showKeyWindow{
    return true;
}
- (void)handleCallbackWithName:(NSString *)name param:(NSDictionary *)param{
    
}
@synthesize controllerManager;
@synthesize manager;
@synthesize param;

@end

@HMController(haha, HMMaskViewController)
