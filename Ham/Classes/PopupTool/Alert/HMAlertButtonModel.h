//
//  HMAlertButtonModel.h
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/14.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMAlertButtonModel :NSObject
@property (nonatomic, weak) IBOutlet UIButton* button;
@property (nonatomic, readonly,nonnull)NSString* nibName;
@property (nonatomic, readonly,nullable)NSBundle* bundle;
@property (nonatomic, readonly,nonnull)NSString* title;

-(instancetype)initWithTitle:(NSString*)title nibName:(NSString*)nameOfNib bundle:(nullable NSBundle*)bundle;
@end

NS_ASSUME_NONNULL_END
