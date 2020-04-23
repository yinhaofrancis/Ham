//
//  UIResponder+HMResponder.m
//  Ham_Example
//
//  Created by hao yin on 2020/4/17.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import "UIResponder+HMResponder.h"

@implementation UIResponder (HMResponder)
- (void)raiseResponseToHandle:(SEL)handle withSender:(nonnull id)sender{
    if([self respondsToSelector:handle]){
        IMP imp = [self methodForSelector:handle];
        void (*func)(id, SEL,id) = (void *)imp;
        func(self,handle,sender);
    }else{
        if(self.nextResponder){
            [self.nextResponder raiseResponseToHandle:handle withSender:sender];
        }
    }
    
}
@end
