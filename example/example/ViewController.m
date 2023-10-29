//
//  ViewController.m
//  example
//
//  Created by wenyang on 2023/10/30.
//

#import "ViewController.h"
#import "Constance.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"this is test";
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"btn" forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 100, 200, 200);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)touchBtn:(UIButton*)btn{
    //push 控制器
    HMShowRoute(@"/login/root", @{@"username":@"un",@"password":@"pw"}, ^(NSString* type,NSDictionary * result) {
        [btn setTitle:type forState:UIControlStateNormal];
    });
}
@end

@interface ViewNaviController ()


@end

@implementation ViewNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)backViewController { 
    [self popViewControllerAnimated:true];
}

- (void)displayViewController:(nonnull UIViewController *)vc WithName:(nonnull NSString *)name animation:(BOOL)animation { 
    [self pushViewController:vc animated:true];
}

- (NSInteger)priority { 
    return  1;
}

- (void)replaceCurrentViewController:(nonnull UIViewController *)vc WithName:(nonnull NSString *)name animation:(BOOL)animation { 
    
}

- (void)replaceViewController:(nonnull UIViewController *)vc WithName:(nonnull NSString *)name animation:(BOOL)animation { 
    
}

- (void)resetViewController:(nonnull UIViewController *)vc WithName:(nonnull NSString *)name animation:(BOOL)animation { 
    
}

@end




HMController(Test,ViewController)
HMController(Navigator,ViewNaviController)
