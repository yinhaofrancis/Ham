//
//  HMTableViewCell.h
//  Ham_Example
//
//  Created by hao yin on 2020/5/1.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray<UIImageView *> *imms;
@property (weak, nonatomic) IBOutlet UIView *view;

@end

NS_ASSUME_NONNULL_END
