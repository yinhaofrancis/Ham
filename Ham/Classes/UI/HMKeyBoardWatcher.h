//
//  HMKeyBoardWatcher.h
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_OPTIONS(NSUInteger, KeyBoardAction) {
    KeyBoardActionWillUp =      1 << 0,
    KeyBoardActionWillDown =    1 << 1,
    KeyBoardActionDidUp =       1 << 2,
    KeyBoardActionDidDown =     1 << 3,
    KeyBoardActionWillChange =  1 << 4,
    KeyBoardActionDidChange =   1 << 5
};

typedef void(^KeyBoardChangeBlock)(CGRect,CGRect,NSTimeInterval,UIViewAnimationCurve,KeyBoardAction);

@interface HMKeyBoardWatcher : NSObject
- (instancetype)initWithAction:(KeyBoardAction)action withBlock:(KeyBoardChangeBlock)block;
@end

NS_ASSUME_NONNULL_END
