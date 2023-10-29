//
//  ViewController.h
//  example
//
//  Created by wenyang on 2023/10/30.
//

#import <UIKit/UIKit.h>
@import Ham;
@interface ViewController : UIViewController


@end

// 實現HMRoute成為路由VC
@interface ViewNaviController : UINavigationController<HMRoute>


@end
