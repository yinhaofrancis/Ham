//
//  HMInputPopupConfigure.m
//  Himalaya_Example
//
//  Created by KnowChat02 on 2019/6/26.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "HMInputPopupConfigure.h"
#import "HMKeyBoardWatcher.h"
#import "HMAnnotation.h"
@implementation HMInputPopupConfigure {
    BOOL isKeyboardUp;
    HMKeyBoardWatcher *keyBoard;
}
@synthesize manager;

- (void)displayDialog:(nonnull UIView *)container infomation:(nonnull HMInputPopupModel *)infoObject {
    id ob = self.textView;
    [ob setText:infoObject.text];
    
    if(self.placeHolderLabel){
        if(infoObject.attributePlaceHold.length > 0){
            self.placeHolderLabel.attributedText = infoObject.attributePlaceHold;
        }else{
            self.placeHolderLabel.text = infoObject.placeHold;
        }
    }else if ([self.textView respondsToSelector:@selector(setAttributedPlaceholder:)] && infoObject.attributePlaceHold.length > 0){
        [ob setAttributedPlaceholder:infoObject.attributePlaceHold];
    }else if ([self.textView respondsToSelector:@selector(setPlaceholder:)]){
        [ob setPlaceholder:infoObject.placeHold];
    }
    isKeyboardUp = infoObject.isFirstResponser;
    __weak HMInputPopupConfigure *weaself = self;
    CGFloat tbottomMargin = _bottomMargin;
    keyBoard = [[HMKeyBoardWatcher alloc] initWithAction:0b111111 withBlock:^(CGRect s, CGRect e, NSTimeInterval t, UIViewAnimationCurve c, KeyBoardAction a) {
        if(a == KeyBoardActionWillUp){
            CGFloat f = e.size.height + tbottomMargin;
            [UIView animateWithDuration:t delay:0 options:c << 16 animations:^{
                weaself.view.transform = CGAffineTransformMakeTranslation(0, -f);
            } completion:^(BOOL finished) {
                
            }];
        }else if(a == KeyBoardActionWillDown){
        
            [UIView animateWithDuration:t delay:0 options:c << 16 animations:^{
                weaself.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
            [weaself.manager removeCurrentPopup];
        }
        
    }];
}

- (void)hideAnimationComplete:(nonnull void (^)(BOOL))handle {
    if (self->isKeyboardUp || self.textView.isFirstResponder) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.background.alpha = 0;
            self.view.alpha = 0;
            self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height + self.bottomMargin);
        } completion:handle];
    }else{
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.background.alpha = 0;
            self.view.alpha = 0;
            self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height + self.bottomMargin);
        } completion:handle];
    }
}

- (void)showAnimationComplete:(nonnull void (^)(BOOL))handle {
    self.background.alpha = 0;
    self.view.alpha = 0;
    self.view.transform = CGAffineTransformMakeTranslation(0, self.view.frame.size.height + self.bottomMargin);
    if(self->isKeyboardUp){
        [self tryFirstRespond];
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.background.alpha = 1;
            self.view.alpha = 1;
        } completion:handle];
        
    }else{
    
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.background.alpha = 1;
            self.view.alpha = 1;
            self.view.transform = CGAffineTransformIdentity;
        } completion:handle];
    }
    
}
- (BOOL)onKeyWindow{
    return true;
}
-(IBAction)back:(id)sender{
    if(self.textView.isFirstResponder){
        [self.textView resignFirstResponder];
    }else{
        [self.manager removeCurrentPopup];
    }
    
}
-(IBAction)send:(id)sender{
    
    HMInputPopupModel* info = self.infoObject;
    id ob = self.textView;
    info.text = [ob text];
    if(info.sendBlock){
        info.sendBlock(info);
    }
}
-(void)tryFirstRespond{
    if(isKeyboardUp && self.view.window && self.view.window.keyWindow){
        [self.textView becomeFirstResponder];
    }
}
- (void)dealloc{
    
}
@end


@implementation HMInputPopupModel



@synthesize configure;

@end
@HMPopup(HMInputPopupModel, HMInputPopupConfigure)
