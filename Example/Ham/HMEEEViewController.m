//
//  HMEEEViewController.m
//  Ham_Example
//
//  Created by hao yin on 2020/4/30.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import "HMEEEViewController.h"

@interface HMEEEViewController ()

@end

@implementation HMEEEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self callbackWithName:@"haha" param:@{@"dddd":@"dddds"}];
    });
    // Do any additional setup after loading the view from its nib.
}

@synthesize controllerManager;

@end

@HMKeyController("/jj/l", HMEEEViewController)

