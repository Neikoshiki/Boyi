//
//  OAuthModel.h
//  Boyi
//
//  Created by Shvier on 16/4/22.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuthModel : NSObject

@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *expires_in;
@property (nonatomic, strong) NSString *remind_in;
@property (nonatomic, strong) NSString *uid;

@end
