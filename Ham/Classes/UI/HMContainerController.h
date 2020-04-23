//
//  HMContainerController.h
//  CHFeng
//
//  Created by KnowChat02 on 2019/10/9.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import <Ham/UI.h>

NS_ASSUME_NONNULL_BEGIN
@class HMContainerController;
@protocol ContainerItemVC <NSObject>

-(UIViewController *)currentVC;


@property (nonatomic,weak) HMNavigationController *container;
@property (nonatomic,copy) NSString *name;

@optional

-(void)showAnimationWithComplete:(void(^)(BOOL))handle;

-(void)hiddenAnimationWithComplete:(void(^)(BOOL))handle;

@end


@interface HMContainerController : HMViewController

@property(nonatomic,readonly)NSString *currentName;

- (void)registerVCItem:(id<ContainerItemVC>)VC WithName:(NSString *)name;

- (void)showWithName:(NSString *)name;

- (void)showWithName:(NSString *)name param:(nullable NSDictionary *)param;

@property (nonatomic,nonnull) IBOutlet UIView *floatView;

@end

@interface HMDefaultContainerItemVC : NSObject<ContainerItemVC>
@property (nonatomic,strong)UIViewController * realVC;
@end

NS_ASSUME_NONNULL_END
