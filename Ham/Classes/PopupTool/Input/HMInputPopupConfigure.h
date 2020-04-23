//
//  HMInputPopupConfigure.h
//  Himalaya_Example
//
//  Created by KnowChat02 on 2019/6/26.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "HMPopupManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMInputPopupConfigure : HMBasePopupConfigure
@property (nonatomic,weak) IBOutlet UIResponder<UITextInput>*textView;
@property (nonatomic,weak) IBOutlet UIControl *sendControl;
@property (nonatomic,assign)IBInspectable CGFloat bottomMargin;
@property (nonatomic,weak) IBOutlet UIButton* background;
@property (nonatomic,weak) IBOutlet UILabel *placeHolderLabel;
@end

@class HMInputPopupModel;
typedef void(^handleBlock)(HMInputPopupModel *);

@interface HMInputPopupModel :HMBasePopupModel
@property (nonatomic,copy)NSString *text;
@property (nonatomic,copy)NSString *placeHold;
@property (nonatomic,copy)NSAttributedString *attributePlaceHold;
@property (nonatomic,assign) BOOL isFirstResponser;
@property (nonatomic,copy) handleBlock sendBlock;
@end

NS_ASSUME_NONNULL_END
