//
//  HMPopupManager.h
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/13.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMPopupConfigure.h"
#import "HMWindowManager.h"
#import "HMModule.h"
#import "HMPopupProtocol.h"
#define PopupKey @"PopupKey"
NS_ASSUME_NONNULL_BEGIN

@protocol HMPopupModel<NSObject>
@property (nonatomic,weak) id<HMPopupConfigure> configure;
- (instancetype)initWithNibName:(NSString *)name bundle:(nullable NSBundle *)bundle;
@optional
-(nullable NSString*)nibName;
-(nullable NSBundle*)nibBundle;
@end
@interface HMBasePopupModel:NSObject<HMPopupModel>

@property (copy ,nonatomic) NSString *nibName;
@property (strong ,nonatomic) NSBundle *nibBundle;

@end
@interface HMPopupIndexModel:HMBasePopupModel

@property (copy ,nonatomic) void(^handleIndex)(NSUInteger);
-(IBAction)handleEvent:(UIControl *)sender;

@end



@interface HMPopupManagerImp :NSObject<HMModule,HMPopupManager>
+ (instancetype)shared;
//+ (void)registerAlertConfigure:(Class)configureClass withInfomationClass:(NSString*)cls;
@end


@interface HMBasePopupConfigure:NSObject<HMPopupConfigure>

@property (nullable,nonatomic) IBOutlet UIView *view;
@property (nonatomic,nullable) IBOutlet UIView *containerView;
@property (nonatomic,readonly) UINib *nib;
- (UINib *)loadView:(id<HMPopupModel>)infoObject;
@end
@interface HMSplitPopupConfigure:HMBasePopupConfigure

@end
NS_ASSUME_NONNULL_END
