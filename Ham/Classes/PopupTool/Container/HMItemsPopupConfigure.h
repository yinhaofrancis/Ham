//
//  HMItemsPopupConfigure.h
//  chufeng
//
//  Created by KnowChat02 on 2019/7/2.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMListView.h"
#import "HMPopupManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface HMItemsPopupConfigure : HMBasePopupConfigure
@property (nonatomic, weak) IBOutlet HMListView * list;
@property (nonatomic,copy) NSArray <id<HMPopupConfigure>> *configs;

@end

@interface HMItemsPopupModel : HMBasePopupModel
@property (nonatomic,copy) NSArray<id<HMPopupModel>> *items;

@end

NS_ASSUME_NONNULL_END
