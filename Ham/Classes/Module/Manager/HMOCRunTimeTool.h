//
//  HMOCRunTimeTool.h
//  Ham
//
//  Created by KnowChat02 on 2019/10/24.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

typedef void(^didSetBlock)(id,void * _Nullable);

@interface HMOCRunTimeTool : NSObject

+ (void)assignIVar:(NSDictionary<NSString *,id> *)kv
          ToObject:(id)object;

+ (nullable Protocol *)createProtocolWithName:(NSString *)name
                                from:(Protocol *)protocol
                           implement:(NSDictionary<NSString *,NSString *> *)kv;


+ (void)swizzing:(SEL)originalSelector
            with:(SEL)swizzledSelector
             cls:(Class)className;

+ (BOOL)addSameMethod:(SEL)selector
            encodeSel:(SEL)sameSel
              toClass:(Class)cls
                  imp:(id)impBlock;

/// 尝试添加方法
/// @param cls 类
/// @param selector selecter
/// @param type code
/// @param impBlock block
+ (BOOL)addMethodToClass:(Class)cls
                selector:(SEL)selector
                withType:(const char *)type
                     imp:(id)impBlock;
                

+(NSArray<NSString *> *)propertyInClass:(Class)cls;

+(NSDictionary<NSString *,NSString *> *)propertyKeyAttributeInClass:(Class)cls;

+(NSDictionary<NSString *,NSString *> *)propertyKeyTypeInClass:(Class)cls;

//+ (BOOL)addPropertyDidSet:(NSString*)name
//             instantClass:(Class)cls
//              didSetBlock:(didSetBlock)block;

/// 实现protocol
/// @param proto 协议
/// @param selector selector
/// @param cls 类
/// @param block call
+ (BOOL)classImplamentProtocol:(Protocol *)proto
                      selector:(SEL)selector
                       toClass:(Class)cls
                           imp:(id)block;


+ (void)setAssociatedValue:(id)value withName:(NSString *)name toObject:(id)object;

+ (id)getAssociatedValueFromName:(NSString *)name atObject:(id)object;

@end


@interface NSString (OCRuntime)
@property(nonatomic,readonly) NSString* firstCapitalizedString;
@end
NS_ASSUME_NONNULL_END
