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

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.remind_in = [aDecoder decodeObjectForKey:@"remind_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.remind_in forKey:@"remind_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
}

@end
