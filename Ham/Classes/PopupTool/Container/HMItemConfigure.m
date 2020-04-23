//
//  HMItemConfigure.m
//  Himalaya_Example
//
//  Created by KnowChat02 on 2019/7/2.
//  Copyright © 2019 yinhaofrancis. All rights reserved.
//

#import "HMItemConfigure.h"
#import "HMAnnotation.h"
@implementation HMItemConfigure

- (nonnull UIControl *)itemView {
    return (UIControl *)self.containerView;
}

- (void)onselect:(BOOL)select {
    
}
-(void)displayDialog:(UIView *)container infomation:(id<HMPopupModel>)infoObject{

}
@end

@implementation HMItemModel



@synthesize configure;

@end
@HMPopup(HMItemModel, HMItemConfigure)
