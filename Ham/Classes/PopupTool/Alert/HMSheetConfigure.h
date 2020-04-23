//
//  HMSheetConfigure.h
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/14.
//  Copyright © 2019 KnowChat02. All rights reserved.
//


#import "HMAlertButtonModel.h"
#import "HMPopupManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface HMSheetConfigure : HMBasePopupConfigure
@property(weak,nonatomic) IBOutlet UILabel* title;
@property(weak,nonatomic) IBOutlet UIStackView* buttonContainer;
@property(weak,nonatomic) IBOutlet UIButton* back;
@property (weak, nonatomic) IBOutlet UIButton *background;
@end

@interface HMSheetModel : HMPopupIndexModel
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *backtitle;
@property (nonatomic, assign) BOOL isLocked;
@property (nonatomic, copy)NSArray<HMAlertButtonModel *> *buttonsTitle;
@end

NS_ASSUME_NONNULL_END
