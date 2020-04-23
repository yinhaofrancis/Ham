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
        [s callbackWithName:@"haha" param:nil];
    });
}

- (UIViewController *)rootVC{
    return self;
}
- (BOOL)showKeyWindow{
    return true;
}
@synthesize controllerManager;
@synthesize manager;

@end

@HMController(haha, HMMaskViewController)
