//
//  StatusModel.m
//  Boyi
//
//  Created by Shvier on 16/4/23.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import "StatusModel.h"
#import "GeoModel.h"
#import <WeiboUser.h>
#import "WeiboVisibleModel.h"
#import "PicUrlsModel.h"

@implementation StatusModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"weiboId"];
    }
}

@end
