//
//  HMKeyBoardWatcher.m
//  Himalaya
//
//  Created by KnowChat02 on 2019/6/26.
//

#import "HMKeyBoardWatcher.h"
@interface HMKeyBoardWatcher()
@property (nonatomic,copy) KeyBoardChangeBlock blockCallBack;
@property (nonatomic,assign) KeyBoardAction action;
@end
@implementation HMKeyBoardWatcher
- (instancetype)initWithAction:(KeyBoardAction)action withBlock:(KeyBoardChangeBlock)block{
    self = [super init];
    if (self) {
        self.blockCallBack = block;
        self.action = action;
        [self addObs];
    }
    return self;
}
-(void)addObs{
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleKey:) name:UIKeyboardDidShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleKey:) name:UIKeyboardDidHideNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleKey:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleKey:) name:UIKeyboardWillHideNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleKey:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleKey:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)handleKey:(NSNotification *)noti{
    if([noti.name isEqualToString:UIKeyboardDidShowNotification] && (KeyBoardActionDidUp & self.action)){
        [self catch:KeyBoardActionDidUp notification:noti];
    }
    if([noti.name isEqualToString:UIKeyboardDidHideNotification] && (KeyBoardActionDidDown & self.action)){
        [self catch:KeyBoardActionDidDown notification:noti];
    }
    if([noti.name isEqualToString:UIKeyboardWillShowNotification] && (KeyBoardActionWillUp & self.action)){
        [self catch:KeyBoardActionWillUp notification:noti];
    }
    if([noti.name isEqualToString:UIKeyboardWillHideNotification] && (KeyBoardActionWillDown & self.action)){
        [self catch:KeyBoardActionWillDown notification:noti];
    }
    if([noti.name isEqualToString:UIKeyboardDidChangeFrameNotification] && (KeyBoardActionDidChange & self.action)){
        [self catch:KeyBoardActionDidChange notification:noti];
    }
    if([noti.name isEqualToString:UIKeyboardWillChangeFrameNotification] && (KeyBoardActionWillChange & self.action)){
        [self catch:KeyBoardActionWillChange notification:noti];
    }
}
-(void)catch:(KeyBoardAction)action notification:(NSNotification *)noti{
    
    NSNumber* number = noti.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    UIViewAnimationCurve cur = ((NSNumber *)noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]).integerValue;
    if(self.blockCallBack){
        NSValue * beginrect = noti.userInfo[UIKeyboardFrameBeginUserInfoKey];
        NSValue * endrect = noti.userInfo[UIKeyboardFrameEndUserInfoKey];
        self.blockCallBack(beginrect.CGRectValue,endrect.CGRectValue,number.doubleValue ,cur, action);
    }
    
}
- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
@end
