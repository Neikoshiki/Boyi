//
//  CommentModel.h
//  Boyi
//
//  Created by Shvier on 16/4/23.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WeiboUser;
@class StatusModel;

@interface CommentModel : NSObject

@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, strong) NSNumber *sourceId;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, strong) WeiboUser *user;
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, strong) StatusModel *status;
@property (nonatomic, strong) CommentModel *reply_comment;

@end
