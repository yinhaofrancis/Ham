//
//  HMTableViewCell.m
//  Ham_Example
//
//  Created by hao yin on 2020/5/1.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import "HMTableViewCell.h"

@implementation HMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    for (UIView * v in self.imms) {
        v.layer.cornerRadius = 18;
//        v.layer.shouldRasterize = true;
        v.layer.masksToBounds = true;
    }
//    self.view.layer.cornerRadius = 32;
    self.view.layer.masksToBounds = true;
}


@end
