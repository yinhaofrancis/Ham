//
//  HMAlertButtonModel.m
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/14.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMAlertButtonModel.h"

@implementation HMAlertButtonModel

- (instancetype)initWithTitle:(NSString *)title nibName:(NSString *)nameOfNib bundle:(NSBundle *)bundle {
    self = [super init];
    if (self) {
        _title = title;
        _nibName = nameOfNib;
        _bundle = bundle;
        if(bundle == nil){
            _bundle = NSBundle.mainBundle;
        }
    }
    return self;
}

@end
