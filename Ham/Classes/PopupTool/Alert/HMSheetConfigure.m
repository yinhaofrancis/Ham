//
//  HMSheetConfigure.m
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/14.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMSheetConfigure.h"
#import "HMView.h"
#import "HMAnnotation.h"
@HMPopup(HMSheetModel, HMSheetConfigure)
@implementation HMSheetConfigure
- (void)displayDialog:(UIView *)container infomation:(HMSheetModel *)infoObject{
    
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
    [self.back addTarget:self.manager action:@selector(removeCurrentPopup) forControlEvents:UIControlEventTouchUpInside];
    [self.background addTarget:self.manager action:@selector(removeCurrentPopup) forControlEvents:UIControlEventTouchUpInside];
    self.title.text = infoObject.title;
}
- (void)showAnimationComplete:(void (^)(BOOL))handle{
    self.background.alpha = 0;
    self.view.transform = CGAffineTransformMakeTranslation(0, self.containerView.frame.size.height - self.view.frame.origin.y);
    self.back.transform = CGAffineTransformMakeTranslation(0, self.containerView.frame.size.height - self.back.frame.origin.y);
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.background.alpha = 1;
        self.view.transform = CGAffineTransformIdentity;
    } completion:nil];
    
     [UIView animateWithDuration:0.4 delay:0.1 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.back.transform = CGAffineTransformIdentity;
    } completion:handle];
    
}
- (void)hideAnimationComplete:(void (^)(BOOL))handle{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.background.alpha = 0;
        self.view.transform = CGAffineTransformMakeTranslation(0, self.containerView.frame.size.height - self.view.frame.origin.y);

    } completion:nil];
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.back.transform = CGAffineTransformMakeTranslation(0, self.containerView.frame.size.height - self.back.frame.origin.y);
    } completion:handle];
}
@end

@implementation HMSheetModel

@end
