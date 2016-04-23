//
//  CommentModel.m
//  Boyi
//
//  Created by Shvier on 16/4/23.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import "CommentModel.h"
#import <WeiboUser.h>
#import "StatusModel.h"

@implementation CommentModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"sourceId"];
    }
}

@end
