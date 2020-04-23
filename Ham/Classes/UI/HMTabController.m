//
//  HMTabController.m
//  Ham_Example
//
//  Created by KnowChat02 on 2019/7/30.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "HMTabController.h"

@interface HMTabController ()
@property (nonatomic,nonnull)NSMutableArray<UIViewController<HMTabChildVC> *>* vcs;
@property (nonatomic,weak)UIViewController<HMTabChildVC> *current;
@end

@implementation HMTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabView addTarget:self action:@selector(didSelect) forControlEvents:HMSelectItemEvent];
    for (UIViewController<HMTabChildVC> * vc in _vcs) {
        [self.tabView addControl:vc.selectItems];
    }
    [self loadSelect];
}

-(void)addChildVC:(UIViewController<HMTabChildVC> *)vc{
    if(!_vcs){
        _vcs = [[NSMutableArray alloc] init];
    }
    [_vcs addObject:vc];
    [self.tabView addControl:vc.selectItems];
    
}
- (void)removeChildVC:(UIViewController<HMTabChildVC> *)vc{
    [self.vcs removeObject:vc];
}
-(void)didSelect{
    [self unloadCurrent];
    [self loadSelect];
}
-(void)loadSelect{
    UIViewController<HMTabChildVC> *vc = self.vcs[self.tabView.selectIndex];
    [self.containter addSubview:vc.view];
    [self addChildViewController:vc];
    self.containter.translatesAutoresizingMaskIntoConstraints = false;
    vc.view.translatesAutoresizingMaskIntoConstraints = false;
    [self.containter addConstraints:@[[vc.view.leftAnchor constraintEqualToAnchor:self.containter.leftAnchor],
                                      [vc.view.rightAnchor constraintEqualToAnchor:self.containter.rightAnchor],
                                      [vc.view.topAnchor constraintEqualToAnchor:self.containter.topAnchor],
                                      [vc.view.bottomAnchor constraintEqualToAnchor:self.containter.bottomAnchor],
                                      ]];
    self.current = vc;
    if([self.navigationController isKindOfClass:HMNavigationController.class] && [vc conformsToProtocol:@protocol(HMNavigationDisplay)]){
        HMNavigationController* navi = (HMNavigationController*)self.navigationController;
        
        [navi loadNavigationPropertyAtWill:(UIViewController<HMNavigationDisplay> *)vc animation:false];
        [navi loadNavigationPropertyAtDid:(UIViewController<HMNavigationDisplay> *)vc];
    }
    self.navigationItem.leftBarButtonItem = vc.navigationItem.leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = vc.navigationItem.rightBarButtonItem;
    self.navigationItem.title = vc.navigationItem.title;
    self.navigationItem.titleView = vc.navigationItem.titleView;
}
-(void)unloadCurrent{
    [self.current.view removeFromSuperview];
    [self.current removeFromParentViewController];
}
-(BOOL)showNavigationBar{
    if([self.current respondsToSelector:@selector(showNavigationBar)]){
        id<HMNavigationDisplay> db = (id<HMNavigationDisplay>)self.current;
        return [db showNavigationBar];
    }
    return false;
}

-(BOOL)needSysPanback{
    if([self.current respondsToSelector:@selector(needSysPanback)]){
        id<HMNavigationDisplay> db = (id<HMNavigationDisplay>)self.current;
        return [db needSysPanback];
    }
    return false;
}
- (nullable UIImage *)navigationBarBackgroundImage{
    if([self.current respondsToSelector:@selector(navigationBarBackgroundImage)]){
        id<HMNavigationDisplay> db = (id<HMNavigationDisplay>)self.current;
        return [db navigationBarBackgroundImage];
    }
    return nil;
}

- (nullable UIImage *)navigationBarShadowImage{
    if([self.current respondsToSelector:@selector(navigationBarShadowImage)]){
        id<HMNavigationDisplay> db = (id<HMNavigationDisplay>)self.current;
        return [db navigationBarShadowImage];
    }
    return nil;
}

- (nullable UIColor *)navigationBarTintColor{
    if([self.current respondsToSelector:@selector(navigationBarTintColor)]){
        id<HMNavigationDisplay> db = (id<HMNavigationDisplay>)self.current;
        return [db navigationBarTintColor];
    }
    return nil;
}

- (nullable UIColor *)navigationBarBackgoundColor{
    if([self.current respondsToSelector:@selector(navigationBarBackgoundColor)]){
        id<HMNavigationDisplay> db = (id<HMNavigationDisplay>)self.current;
        return [db navigationBarBackgoundColor];
    }
    return nil;
}

- (BOOL) isTranslucent{
    if([self.current respondsToSelector:@selector(isTranslucent)]){
        id<HMNavigationDisplay> db = (id<HMNavigationDisplay>)self.current;
        return [db isTranslucent];
    }
    return false;
}
@end


