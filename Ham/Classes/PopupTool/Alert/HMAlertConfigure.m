//
//  HMAlertConfigure.m
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/14.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMAlertConfigure.h"
#import "HMAnnotation.h"
#import "HMView.h"
@HMPopup(HMAlertModel, HMAlertConfigure)
@implementation HMAlertConfigure
- (void)displayDialog:(UIView *)container infomation:(HMAlertModel *)infoObject{
    [super displayDialog:container infomation:infoObject];
    self.title.text = infoObject.title;
    if(infoObject.buttonsTitle.count > 2){
        self.buttonContainer.axis = UILayoutConstraintAxisVertical;
    }else{
        self.buttonContainer.axis = UILayoutConstraintAxisHorizontal;
    }
    for (int i = 0; i < infoObject.buttonsTitle.count; i++) {
        [UIView generateInstanceWithName:infoObject.buttonsTitle[i].nibName bundle:infoObject.buttonsTitle[i].bundle owner:infoObject.buttonsTitle[i] injectContent:nil];
        UIButton* button = infoObject.buttonsTitle[i].button;
#if DEBUG
        NSAssert(button, @"error name %@  bundle  %@",infoObject.buttonsTitle[i].nibName,infoObject.buttonsTitle[i].bundle);
#endif
        if(button == nil){
            return;
        }
        button.tag = i;
        [button setTitle:infoObject.buttonsTitle[i].title forState:UIControlStateNormal];
        [button addTarget:infoObject action:@selector(handleEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonContainer addArrangedSubview:button];
        [self.buttonContainer addSubview:button];
    }
    if(!infoObject.isLocked){
        [self.background addTarget:self.manager action:@selector(removeCurrentPopup) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)showAnimationComplete:(void (^)(BOOL))handle{
    self.view.transform = CGAffineTransformMakeScale(0.001, 0.001);
    self.containerView.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.transform = CGAffineTransformIdentity;
        self.containerView.alpha = 1;
    } completion:handle];
}
-(void)hideAnimationComplete:(void (^)(BOOL))handle{
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.transform = CGAffineTransformMakeScale(0.001, 0.001);
        self.containerView.alpha = 0;
    } completion:handle];
}
@end


@implementation HMAlertModel

@end


