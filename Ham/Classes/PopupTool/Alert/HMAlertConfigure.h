//
//  HMAlertConfigure.h
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/14.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMAlertButtonModel.h"
#import "HMPopupManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface HMAlertConfigure : HMSplitPopupConfigure
@property(weak,nonatomic) IBOutlet UILabel* title;
@property (weak, nonatomic) IBOutlet UIButton *background;
@property(weak,nonatomic) IBOutlet UIStackView* buttonContainer;
@end




@interface HMAlertModel : HMPopupIndexModel
@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign) BOOL isLocked;
@property (nonatomic, copy)NSArray<HMAlertButtonModel *> *buttonsTitle;
@end

NS_ASSUME_NONNULL_END
