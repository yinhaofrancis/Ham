//
//  HMProtocol.h
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/21.
//

#import <UIKit/UIKit.h>

#define HMSectToastKey @"HMSectToast"
#define HMSectToast "HMSectToast"


#define HMToast(infoClass,config) \
class infoClass,config; \
@HMCustomAnnotation(HMSectToast,infoClass,config)


#define HMSectAlert "HMSectAlert"
#define HMSectAlertKey "HMSectAlert"

#define HMPopup(infoClass,config) \
class infoClass,config; \
@HMCustomAnnotation(HMSectAlert,infoClass,config)



NS_ASSUME_NONNULL_BEGIN
@protocol HMPopupModel;
@protocol HMToastModel;
@protocol HMWindowManager;
@protocol HMPopupConfigure;

@class HMWindow;

@protocol HMPopupManager <NSObject>
- (void)showPopup:(id<HMPopupModel>)infomation;
- (IBAction)removeCurrentPopup;
-(void)popUpVC:(id<HMPopupModel>)information onContext:(UIViewController *)ctx;
-(UIViewController *)createPopupVC:(id<HMPopupModel>)model;
- (id<HMPopupConfigure>) genConfigure:(id<HMPopupModel>)model;
- (void)removeAllPendingModel;
@end

@protocol  HMToastManager<NSObject>
-(void)showToast:(id<HMToastModel>)toast;
@end



@protocol HMToastModel <NSObject>
@optional
-(NSTimeInterval)delayTime;
-(nullable NSString*)nibName;
-(nullable NSBundle*)nibBundle;
@end

@protocol HMToastConfigure <NSObject>

-(void)displayModel:(id<HMToastModel>)model;

-(nullable UIView *)container;
@end

NS_ASSUME_NONNULL_END
