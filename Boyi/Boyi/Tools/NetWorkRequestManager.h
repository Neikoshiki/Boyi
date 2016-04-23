//
//  NetWorkRequestManager.h
//  Boyi
//
//  Created by Shvier on 16/4/23.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestType) {
    GET,
    POST
};

typedef void (^RequestFinish)(NSData *data);

typedef void (^RequestError)(NSError *error);

@interface NetWorkRequestManager : NSObject

+ (void)requestWithType:(RequestType)type urlString:(NSString *)urlString parseDict:(NSDictionary *)parseDict finish:(RequestFinish)requestFinish error:(RequestError)requestError;

@end
