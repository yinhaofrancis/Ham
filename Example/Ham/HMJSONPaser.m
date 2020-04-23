//
//  HMJSONPaser.m
//  Ham_Example
//
//  Created by hao yin on 2020/3/31.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import "HMJSONPaser.h"
#import <Ham/Ham.h>
@implementation HMJSONPaser{
    NSDateFormatter* format;
}
- (id)json:(NSObject *)obj{
    if(!obj){
        return nil;
    }
    if([obj isKindOfClass:NSNumber.class] || [obj isKindOfClass:NSString.class]){
        return obj;
    }else if ([obj isKindOfClass:NSArray.class]){
        NSMutableArray* array = [NSMutableArray new];
        for (id info in (NSArray *)obj) {
            id kv = [self json:info];
            if(kv){
                [array addObject:kv];
            }
        }
        return array;
    }else if([obj isKindOfClass:NSDictionary.class]){
        NSMutableDictionary* dic = [NSMutableDictionary new];
        for (id key in (NSDictionary *)obj) {
            if([key isKindOfClass:NSString.class]){
                id kv = [self json:((NSDictionary*)obj)[key]];
                if(kv){
                    dic[key] = kv;
                }
            }
        }
        return dic;
    }else if([obj isKindOfClass:NSDate.class]){
        NSDate *date = (NSDate *)obj;
        if(format){
            return [format stringFromDate:date];
        }else{
            return [[NSNumber alloc] initWithDouble:date.timeIntervalSince1970];
        }
    }else if([obj isKindOfClass:NSData.class]){
        NSData *date = (NSData *)obj;
        return [date base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }else{
        NSMutableDictionary* json = [NSMutableDictionary new];
        NSDictionary<NSString *,NSString *> *ty = [HMOCRunTimeTool propertyKeyTypeInClass:obj.class];
        for (NSString* key in ty) {
            id info = [obj valueForKey:key];
            if(info){
                id result = [self json:info];
                if(result){
                    json[key] = result;
                }else{
                    if([obj respondsToSelector:@selector(toJSON:)]){
                        json[key] = [obj performSelector:@selector(toJSON:) withObject:key];
                    }
                }
            }
        }
        return json;
    }
    return nil;
}
- (id)model:(id)json modelClass:(nonnull Class)cls {
    if([json isKindOfClass:NSDictionary.class]){
        NSDictionary* jsonDic = json;
        NSDictionary<NSString *,NSString *> *ty = [HMOCRunTimeTool propertyKeyTypeInClass:cls];
        id inst = [[cls alloc] init];
        if(inst){
            for (NSString * str in ty) {
                NSString * type = ty[str];
                if(![type hasPrefix:@"@"] && type.length == 1){
                    [inst setValue:jsonDic[str] forKey:str];
                }else if ([type hasPrefix:@"@"]){
                    NSArray<NSString *>* a = [type componentsSeparatedByString:@"\""];
                    if(a.count > 2){
                        id jsonobj = [self model:jsonDic[str] modelClass:NSClassFromString(a[1])];
                        [inst setValue:jsonobj forKey:str];
                    }
                }
            }
            return inst;
        }else{
            return json;
        }
        
    }else if ([json isKindOfClass:NSArray.class]){
        return json;
    }else{
        if(cls == NSDate.class){
            if(format){
                return [format dateFromString:json];
            }else{
                return [[NSDate alloc] initWithTimeIntervalSince1970:[json doubleValue]];
            }
        }
        if(cls == NSData.class){
            return [[NSData alloc] initWithBase64EncodedString:(NSString *)json options:NSDataBase64DecodingIgnoreUnknownCharacters];
        }
        return json;
    }
    
}
-(void)setDateFormat:(NSString *)dateFormat{
    if(!format){
        format = [[NSDateFormatter alloc] init];
    }
    format.dateFormat = dateFormat;
}
@end
