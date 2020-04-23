//
//  HMManager.m
//  chufeng
//
//  Created by KnowChat02 on 2019/5/16.
//  Copyright © 2019 KnowChat02. All rights reserved.
//

#import "HMWindowManager.h"
#import "HMAnnotation.h"
#import "HMWindow.h"
@interface HMWindowManagerImp()
@property(nonatomic,nullable) HMWindow* window;

@property(nonatomic,weak) id<HMWindowObject> current;
@property(nonatomic,weak) UIWindow* lastKeyWindow;
@end



@HMService(HMWindowManager, HMWindowManagerImp)

@implementation HMWindowManagerImp

+(id<HMWindowManager>)shared{
    static HMWindowManagerImp *inst;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[HMWindowManagerImp alloc] init];
    });
    return inst;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        _windowObjects = [[NSMutableArray alloc] init];
        self.level = 0;
    }
    return self;
}

- (void)showWindow:(id<HMWindowObject>)windowObject withCurrentWindow:(nullable UIWindow *)currentWindow{
    if(self.window){
        [self.windowObjects addObject:windowObject];
    }else{
        if (@available(iOS 13.0, *)) {
            [self showWindow:windowObject withUIWindowScene:currentWindow.windowScene];
        } else {
            self.window = [[HMWindow alloc] init];
            [self configWindow:self.window withWindowObject:windowObject];
        }
    }
}

- (void)replaceWindow:(id<HMWindowObject>)windowObject withCurrentWindow:(nullable UIWindow *)currentWindow{
    if (@available(iOS 13.0, *)) {
        [self showWindow:windowObject withUIWindowScene:currentWindow.windowScene];
    } else {
       [self showWindow:windowObject withCurrentWindow:currentWindow];
    }
}

//MARK:innner function
- (void)showWindow:(id<HMWindowObject>)windowObject withUIWindowScene:(nullable UIWindowScene *)scene API_AVAILABLE(ios(13.0)){
    self.window = scene == nil ? [[HMWindow alloc] init] : [[HMWindow alloc] initWithWindowScene:scene];
    [self configWindow:self.window withWindowObject:windowObject];
}
- (void)configWindow:(UIWindow *)window withWindowObject:(id<HMWindowObject>)windowObject{
    self.window.windowLevel = self.level;
    self.window.animation = windowObject;
    if([windowObject respondsToSelector:@selector(showKeyWindow)] && [windowObject showKeyWindow]){
       [self.window makeKeyAndVisible];
    }
    if([windowObject respondsToSelector:@selector(userInteractionEnabled)]){
       self.window.userInteractionEnabled = windowObject.userInteractionEnabled;
    }
    self.current = windowObject;
    windowObject.manager = self;
    [self.window setOpaque:false];
    self.window.backgroundColor = UIColor.clearColor;
    self.window.rootViewController = windowObject.rootVC;
    [self.window visiableSelfComplete:^(BOOL flag) {
      
    }];
}
- (void)setLevel:(UIWindowLevel)level{
    self->level = level;
    self.window.windowLevel = level;
}
- (void)removeWindow{
    [self.window removeSelfComplete:^(BOOL flag) {
        UIWindow* w = self.window;
        self.window = nil;
        id<HMWindowObject> object = self.windowObjects.firstObject;
        if (object){
            [self showWindow:object withCurrentWindow:w];
            [self.windowObjects removeObject:object];
        }else{
            self.current = nil;
        }
    }];
}
- (UIWindow *)currentwindow{
    return self.window;
}
-(id<HMWindowObject>)firstWindowObject{
    return self.current;
}
@synthesize level;

+ (HMModuleMemoryType)memoryType {
    return HMModuleNew;
}

@synthesize windowObjects = _windowObjects;

@end
