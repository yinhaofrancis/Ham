//
//  HMPageViewController.m
//  Ham_Example
//
//  Created by KnowChat02 on 2019/11/14.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "HMPageViewController.h"

@interface HMPageViewController ()<UIScrollViewDelegate>
@property (nonatomic,copy) NSArray<NSLayoutConstraint *> *constains;
@property (nonatomic,nonnull)UIView *containnerView;
@property (nonatomic,strong)NSMutableDictionary<NSString *,UIViewController *>*cachedViewControllers;
@end

@implementation HMPageViewController
@synthesize scrollView = _scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray<NSString *> *vcs = self.param[@"vcs"];
    self.registerViewControllers = vcs;
    self.vcIndex = 0;
    [self awakeSelect];
    [self.view sendSubviewToBack:self.scrollView];
    self.scrollView.bounces = false;
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
}
- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        [self.view addSubview:_scrollView];
        BOOL safearea = [self.param[@"safeArea"] boolValue];
        if(safearea){
            if (@available(iOS 11.0, *)) {
                NSArray* arry =  @[
                    [_scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                    [_scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                    [_scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                    [_scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                ];
                [self.view addConstraints:arry];
            } else {
                NSArray* arry =  @[
                    [_scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                    [_scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                    [_scrollView.topAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.topAnchor],
                    [_scrollView.bottomAnchor constraintEqualToAnchor:self.view.layoutMarginsGuide.bottomAnchor],
                ];
                [self.view addConstraints:arry];
            }
        }else{
            NSArray* arry =  @[
                [_scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                [_scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                [_scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                [_scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
            ];
            [self.view addConstraints:arry];
        }
        
        self.scrollView.pagingEnabled = true;
        if (@available(iOS 13.0, *)) {
            self.scrollView.automaticallyAdjustsScrollIndicatorInsets = false;
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (void)setVcIndex:(NSUInteger)vcIndex{
    [self.scrollView scrollRectToVisible:CGRectMake(vcIndex * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:true];
    [self changeIndex:vcIndex];
}
- (void)setRegisterViewControllers:(NSArray<NSString *> *)registerViewControllers{
    for (UIViewController * vc in self.registerViewControllers) {
        [vc removeFromParentViewController];
        [vc.view removeFromSuperview];
    }
    for (UIViewController* vc in self.cachedViewControllers.allValues) {
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
    [self.cachedViewControllers removeAllObjects];
    if(self.registerViewControllers == nil){
        _registerViewControllers = [NSMutableArray new];
    }
    _registerViewControllers = registerViewControllers;
    [self layoutLayoutGuides];
}
- (NSMutableDictionary<NSString *,UIViewController *> *)cachedViewControllers{
    if(!_cachedViewControllers){
        _cachedViewControllers = [[NSMutableDictionary alloc] init];
    }
    return _cachedViewControllers;
}
-(void)changeIndex:(NSUInteger)index{
    if(index != _vcIndex){
        
        [self sleepSelect];
        _vcIndex = index;
        [self awakeSelect];
    }
}
- (void)sleepSelect{
    UIViewController * vc = [self indexViewController:_vcIndex];
    if ([vc respondsToSelector:@selector(HMPageViewControllerDidDeselect:)]){
        [vc performSelector:@selector(HMPageViewControllerDidDeselect:) withObject:self];
    }
}
- (void)awakeSelect{
    UIViewController *vc = [self indexViewController:_vcIndex];
    if ([vc respondsToSelector:@selector(HMPageViewControllerDidSelect:)]){
        [vc performSelector:@selector(HMPageViewControllerDidSelect:) withObject:self];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger index = (NSUInteger)(scrollView.contentOffset.x / scrollView.frame.size.width);
    [self changeIndex:index];
}
- (void)layoutLayoutGuides{
    self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
    for (int i = 0; i < self.registerViewControllers.count; i++) {
        NSString *name = self.registerViewControllers[i];
        UIViewController * vc = [self indexViewController:i];
        if(!vc){
            vc = HMGetController(name);
            self.cachedViewControllers[self.registerViewControllers[i]] = vc;
            if([vc respondsToSelector:@selector(setPageContainerController:)]){
                [vc performSelector:@selector(setPageContainerController:) withObject:self];
            }
            if([vc respondsToSelector:@selector(setIndex:)]){
                id<HMPageViewControllerItem> item = (id<HMPageViewControllerItem>)vc;
                [item setIndex:i];
            }
        }
        [self.scrollView addSubview:vc.view];
        if(i == 0){
            
            NSArray* con = @[
                [vc.view.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor]
            ];
            vc.view.translatesAutoresizingMaskIntoConstraints = false;
            [self.scrollView addConstraints:con];
            if(self.registerViewControllers.count == 1){
                NSArray* con = @[
                    [vc.view.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor]
                ];
                [self.scrollView addConstraints:con];
            }
        }else if (i == self.registerViewControllers.count - 1){
            UIViewController * last = [self indexViewController:i - 1];
            NSArray* con = @[
                [vc.view.leadingAnchor constraintEqualToAnchor:last.view.trailingAnchor],
                [vc.view.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor]
            ];
            vc.view.translatesAutoresizingMaskIntoConstraints = false;
            [self.scrollView addConstraints:con];
        }else{
            UIViewController * last = [self indexViewController:i - 1];
           NSArray* con = @[
               [vc.view.leadingAnchor constraintEqualToAnchor:last.view.trailingAnchor],
               
           ];
           vc.view.translatesAutoresizingMaskIntoConstraints = false;
           [self.scrollView addConstraints:con];
        }
        NSArray* con = @[
            [vc.view.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:0],
//            [vc.view.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
            [vc.view.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor],
            [vc.view.heightAnchor constraintEqualToAnchor:self.scrollView.heightAnchor],
//            [vc.view.centerYAnchor constraintEqualToAnchor:self.scrollView.centerYAnchor]
        ];
        vc.view.translatesAutoresizingMaskIntoConstraints = false;
        [self.scrollView addConstraints:con];
    }
}
- (void)layoutContainer{
    [self.scrollView addSubview:_containnerView];
}
- (UIView *)containnerView{
    if(!_containnerView){
        _containnerView = [[UIView alloc] init];
    }
    return _scrollView;
}
- (UIViewController *)indexViewController:(NSUInteger)index{
    NSString *name = self.registerViewControllers[index];
    UIViewController * vc = self.cachedViewControllers[name];
    return vc;
}
@end
@HMController(page, HMPageViewController)
