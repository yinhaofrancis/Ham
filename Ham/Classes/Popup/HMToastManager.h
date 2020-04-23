//
//  HMToastManager.h
//  Himalaya
//
//  Created by hao yin on 2019/6/17.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMModule.h"
#import "HMPopupProtocol.h"
#import "HMAnnotation.h"

#define HMSectToastKey @"HMSectToast"
#define HMSectToast "HMSectToast"


#define HMToast(infoClass,config) \
class infoClass,config; \
@HMCustomAnnotation(HMSectToast,infoClass,config)

#define ToastKey @"ToastKey"
#define HMToastName @"HMToast"
NS_ASSUME_NONNULL_BEGIN




@interface HMToastConfigureObject : NSObject<HMToastConfigure>
@property (nonatomic,weak) IBOutlet UILabel *label;
@property (nonatomic,weak) IBOutlet UIView *container;
@end

@interface HMToastModelObject : NSObject<HMToastModel>
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *nibName;
@property (nonatomic,nullable) NSBundle *nibBundle;
@property (nonatomic,assign) NSTimeInterval delayTime;
-(instancetype)initWithName:(nonnull NSString *)name
                     bundle:(nullable NSBundle *)bundle
                  delayTime:(NSTimeInterval)time;
@end

@interface HMToastManagerImp : NSObject<HMModule,HMToastManager>
+(instancetype)shared;
@end


NS_ASSUME_NONNULL_END
