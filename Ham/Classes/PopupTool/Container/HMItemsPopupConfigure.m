//
//  HMItemsPopupConfigure.m
//  chufeng
//
//  Created by KnowChat02 on 2019/7/2.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMItemsPopupConfigure.h"

@implementation HMItemsPopupConfigure
- (void)displayDialog:(UIView *)container infomation:(HMItemsPopupModel *)infoObject{
    NSMutableArray<id<HMPopupConfigure>> *configs = [[NSMutableArray alloc] init];
    for (id<HMPopupModel> i in infoObject.items) {
        id<HMPopupConfigure> conf = [self.manager genConfigure:i];
        [configs addObject:conf];
        if([conf respondsToSelector:@selector(itemView)]){
            id<HMListItem> item = (id<HMListItem>)conf;
            [self.list addItem:item];
        }
        [conf displayDialog:conf.container infomation:i];
    }
    self.configs = configs;
    
}
- (void)reload{
    HMItemsPopupModel* mode = self.infoObject;
    for (int i = 0; i < self.configs.count; i++) {
        [self.configs[i] displayDialog:self.configs[i].container infomation:mode.items[i]];
    }
}
@end

@implementation HMItemsPopupModel



@synthesize configure;

@end
