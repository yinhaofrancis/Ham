//
//  HMContentController.m
//  Himalaya
//
//  Created by hao yin on 2019/6/17.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMContentController.h"

@interface HMContentController ()
@property (nonatomic, nonnull)UIView* content;
@end

@implementation HMContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = _content;
    // Do any additional setup after loading the view.
}
- (instancetype)initWithContent:(UIView *)view{
    self = [super init];
    if (self) {
        _content = view;
    }
    return self;
}


@synthesize manager;

- (nonnull UIViewController *)rootVC {
    return self;
}


@end
