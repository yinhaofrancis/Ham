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

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)mask:(id)sender{
    NSLog(@"%@",sender);
}
- (IBAction)showkeyBoard:(id)sender {
    HMShowRoute(@"haha", @{@"a":@"a"},^(NSString * _Nonnull name, NSDictionary * _Nonnull param) {
        NSLog(@"param    %@",param);
    });
    
   
}
- (IBAction)eeeee:(id)sender {
//    HMShowRouterWithParamAndCallback(@"/jj/l", @{@"g":@"h"},^(NSString * _Nonnull name, NSDictionary * _Nonnull param) {
//        NSLog(@"param    %@",param);
//    });
    
//    UIViewController *vc = HMGetControllerWithCallback(@"/jj/l", @{@"g":@"h"}, ^(NSString * name,NSDictionary *param){
//        NSLog(@"param    %@",param);
//    });
    UIViewController *vc = HMGetController(@"/jj/l",  @{@"g":@"h"}, ^(NSString * _Nonnull name, NSDictionary * _Nonnull param) {
        NSLog(@"param    %@",param);
    });
    [self presentViewController:vc animated:true completion:nil];
}

- (BOOL)showKeyWindow {
    return true;
}
- (void)handleCallbackWithName:(NSString *)name param:(NSDictionary *)param{
    
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

@synthesize controllerManager;


synthesizeAssociatedProperty(HMCopy, haha)

@end
