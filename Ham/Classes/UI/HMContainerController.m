//
//  HMContainerController.m
//  CHFeng
//
//  Created by KnowChat02 on 2019/10/9.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMContainerController.h"
#import <Ham/Ham.h>
@interface HMContainerController ()
@property (nonatomic,strong) NSMutableDictionary<NSString*,id<ContainerItemVC>>* vcs;
@property (nonatomic,strong) id<ContainerItemVC> currentVC;
@property (nonatomic,assign) NSInteger signal;
@end

@implementation HMContainerController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.vcs = [NSMutableDictionary new];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)showWithName:(NSString *)name{
    [self showWithName:name param:nil];
}
- (void)showWithName:(NSString *)name param:(NSDictionary *)param{
    if([self.currentVC.name isEqualToString:name]){
        return;
    }
    id<ContainerItemVC> vc = self.vcs[name];
    if(vc.currentVC){
        [self showVC:vc.currentVC object:vc];
    }else{
        UIViewController* regVC = param == nil ? HMGetController(name) : HMGetControllerWithParam(name, param);
        if([regVC conformsToProtocol:@protocol(ContainerItemVC)]){
            [self showVC:regVC object:(id<ContainerItemVC>)regVC];
        }else{
            HMDefaultContainerItemVC* def = [[HMDefaultContainerItemVC alloc] init];
            def.realVC = regVC;
            [self registerVCItem:def WithName:name];
            def.name = name;
            [self showVC:regVC object:def];
        }
    }
}

-(void)showVC:(UIViewController *)vc object:(id<ContainerItemVC>)vcobject{
    if(self.signal > 0){
        return;
    }
    self.signal = 1;
    [self.view addSubview:vc.view];
    [self.view bringSubviewToFront:self.floatView];
    [self addChildViewController:vc];
    vc.view.translatesAutoresizingMaskIntoConstraints = false;
    NSArray *array = @[
       [vc.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
       [vc.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
       [vc.view.topAnchor constraintEqualToAnchor:self.view.topAnchor],
       [vc.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ];
    [self.view addConstraints:array];
    [vcobject showAnimationWithComplete:^(BOOL b) {
        self.signal--;
    }];
    HMDefaultContainerItemVC *temp = self.currentVC;
    if([self.currentVC respondsToSelector:@selector(hiddenAnimationWithComplete:)]){
        self.signal ++;
       [self.currentVC hiddenAnimationWithComplete:^(BOOL b) {
           [temp.currentVC.view removeFromSuperview];
           [temp.currentVC removeFromParentViewController];
           self.signal--;
       }];
    }else{
       [self.currentVC.currentVC.view removeFromSuperview];
       [self.currentVC.currentVC removeFromParentViewController];
    }
    self.currentVC = vcobject;
}
- (void)registerVCItem:(id<ContainerItemVC>)VC WithName:(NSString *)name{
    self.vcs[name] = VC;
}
- (NSString *)currentName{
    return self.currentVC.name;
}
@end

@implementation HMDefaultContainerItemVC

- (UIViewController *)currentVC{
    return self.realVC;
}
- (void)showAnimationWithComplete:(void (^)(BOOL))handle{
    self.realVC.view.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.realVC.view.alpha = 1;
    } completion:handle];
}
- (void)hiddenAnimationWithComplete:(void (^)(BOOL))handle{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.realVC.view.alpha = 0;
    } completion:handle];
}

@synthesize container;

@synthesize name;

@end
