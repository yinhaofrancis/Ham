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
#import <GLKit/GLKit.h>
#import "HMRenderImage.h"
@interface HMTestSceneViewController ()

@property(nullable,nonatomic)id<HMWindowManager > windowManager;

@property(nonatomic,strong) CIContext *context;
@property(nonatomic,strong) HMRenderImage *image;
@end

@implementation HMTestSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)mask:(id)sender{

}

- (BOOL)showKeyWindow {
    return true;
}
- (void)handleCallbackWithName:(NSString *)name param:(NSDictionary *)param{
    
}
- (nonnull UIViewController *)rootVC {
    return self;
}
- (IBAction)action:(id)sender {
    
}

@synthesize param;

@synthesize vcName;
- (void)handleParam:(NSDictionary *)param{
    NSLog(@"%@ | %@",self.vcName,self.param);
}


+ (HMModuleMemoryType)memoryType {
    return HMModuleWeakSinglten;
}

@synthesize controllerManager;


synthesizeAssociatedProperty(HMCopy, haha)

@end
