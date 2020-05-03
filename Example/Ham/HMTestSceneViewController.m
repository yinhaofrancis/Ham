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

@property (weak, nonatomic) IBOutlet UIImageView *imgs;
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
    [[[HMRenderImage shared] draw:^(CGContextRef _Nonnull ctx, CGRect rect) {
        CGContextSetFillColorWithColor(ctx, UIColor.whiteColor.CGColor);
        CGContextFillRect(ctx,rect);
        CGContextSetFillColorWithColor(ctx, UIColor.systemBlueColor.CGColor);
        CGContextFillEllipseInRect(ctx, CGRectInset(rect, 10, 10));
    }] drawSize:CGSizeMake(100, 100) callback:^(UIImage * _Nonnull img) {
        NSLog(@"%@,%lf,%@",img,img.scale,NSStringFromCGSize(img.size));
        dispatch_async(dispatch_get_main_queue(), ^{
            self.view.layer.contentsCenter = CGRectMake(0.49999, 0.49999, 0.00002, 0.00002);
            self.view.layer.contents = (__bridge id _Nullable)(img.CGImage);
            self.view.layer.contentsScale = UIScreen.mainScreen.scale;
            self.imgs.image = img;
        });
    }];
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
