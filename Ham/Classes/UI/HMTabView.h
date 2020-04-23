//
//  HMTabView.h
//  Ham_Example
//
//  Created by KnowChat02 on 2019/7/30.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HMSelectItemEvent 1 <<  9

NS_ASSUME_NONNULL_BEGIN
@protocol HMTabSelectItem <NSObject>

- (void)selectState:(BOOL)state;

@end
@interface UIButton (Select)<HMTabSelectItem>

@end
@interface HMTabView : UIControl

-(void)addControl:(UIControl<HMTabSelectItem>*)control;
-(void)removeControl:(UIControl<HMTabSelectItem>*)control;

@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,assign) IBInspectable CGFloat spaceing;
@property (nonatomic,assign) IBInspectable CGFloat margin;
@end

NS_ASSUME_NONNULL_END
