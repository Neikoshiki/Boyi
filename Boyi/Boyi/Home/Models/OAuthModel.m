//
//  OAuthModel.m
//  Boyi
//
//  Created by Shvier on 16/4/22.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import "OAuthModel.h"

@implementation OAuthModel

- (NSString *)description {
    return [NSString stringWithFormat:@"accessToken:%@\nexpires_in:%@\nremind_in:%@\nuid:%@", self.access_token, self.expires_in, self.remind_in, self.uid];
}

@end
