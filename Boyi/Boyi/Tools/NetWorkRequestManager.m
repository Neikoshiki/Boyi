//
//  NetWorkRequestManager.m
//  Boyi
//
//  Created by Shvier on 16/4/23.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import "NetWorkRequestManager.h"

@implementation NetWorkRequestManager

+ (void)requestWithType:(RequestType)type urlString:(NSString *)urlString parseDict:(NSDictionary *)parseDict finish:(RequestFinish)requestFinish error:(RequestError)requestError {
    NetWorkRequestManager *manager = [[NetWorkRequestManager alloc] init];
    [manager requestWithType:type urlString:urlString parseDict:parseDict finish:requestFinish error:requestError];
}

- (void)requestWithType:(RequestType)type urlString:(NSString *)urlString parseDict:(NSDictionary *)parseDict finish:(RequestFinish)requestFinish error:(RequestError)requestError {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    if (type == POST) {
        request.HTTPMethod = @"POST";
        if (parseDict.count > 0) {
            request.HTTPBody = [self parseDictionaryToData:parseDict];
        }
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            requestFinish(data);
        } else {
            requestError(error);
        }
    }];
    [task resume];
}

- (NSData *)parseDictionaryToData:(NSDictionary *)dict {
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *key in [dict allKeys]) {
        NSString *str = [NSString stringWithFormat:@"%@=%@", key, dict[key]];
        [array addObject:str];
    }
    NSString *parseString = [array componentsJoinedByString:@"&"];
    return [parseString dataUsingEncoding:NSUTF8StringEncoding];
}

@end
