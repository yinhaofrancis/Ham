//
//  HMResourceLoader.m
//  Ham
//
//  Created by KnowChat02 on 2019/9/5.
//

#import "HMResourceLoader.h"
#import "HMCrypto.h"
#import "Ham.h"
@interface HMResourceLoader ()
@property (nullable,nonatomic) NSURLSessionDownloadTask* task;
@end

@implementation HMResourceLoader
- (void)loadResource:(NSURL *)url handle:(void (^)(NSData * _Nonnull))handle{
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        if(url.absoluteString.length > 0){
            if([self fileExistWithFileName:url.absoluteString]){
                NSURL *fileurl = [self fileLocalUrlWithLocalName:[self filenameGenerate:url.absoluteString]];
                NSData* data = [[NSData alloc] initWithContentsOfURL:fileurl];
                dispatch_async(dispatch_get_main_queue(), ^{
                    handle(data);
                });
            }else{
                if(self.task){
                    [self.task cancel];
                    self.task = nil;
                }
                self.task = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    if(location){
                        NSData* data = [[NSData alloc] initWithContentsOfURL:location];
                        NSURL *fileurl = [self fileLocalUrlWithLocalName:[self filenameGenerate:url.absoluteString]];
                        [data writeToURL:fileurl atomically:false];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            handle(data);
                        });
                    }
                }];
                [self.task resume];
            }
            
        }
    });
}
- (NSURL *)cacheUrl{
    NSError * e;

    NSURL *url = [NSFileManager.defaultManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:true error:&e];
    if(!e){
        return url;
    }
    return nil;
}
-(NSString*)filenameGenerate:(NSString *)name{
    return [[HMHash hashData:[name dataUsingEncoding:NSUTF8StringEncoding] hashFamily:HashFamilySha1] toHexString];
}
- (NSURL *)fileLocalUrlWithLocalName:(NSString*) localName{
    return [[self cacheUrl] URLByAppendingPathComponent:localName];
}
-(BOOL)fileExistWithFileName:(NSString*)name {
    NSString* localName = [self filenameGenerate:name];
    NSURL* fileUrl = [self fileLocalUrlWithLocalName:localName];
    if(fileUrl.path){
        return [NSFileManager.defaultManager fileExistsAtPath:fileUrl.path];
    }
    return false;
}
-(NSURL *)loadLocalUrl:(NSString *)name{
    NSURL *url = [self fileLocalUrlWithLocalName:[self filenameGenerate:name]];
    if([NSFileManager.defaultManager fileExistsAtPath:url.path]){
        return url;
    }else{
        return nil;
    }
}
@end

@HMService(HMResourceLoader, HMResourceLoader)
