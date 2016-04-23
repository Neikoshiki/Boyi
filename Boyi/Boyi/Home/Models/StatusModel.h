//
//  StatusModel.h
//  Boyi
//
//  Created by Shvier on 16/4/23.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GeoModel;
@class WeiboUser;
@class WeiboVisibleModel;
@class PicUrlsModel;

@interface StatusModel : NSObject

@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, strong) NSNumber *weiboId;
@property (nonatomic, strong) NSNumber *mid;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL truncated;
@property (nonatomic, copy) NSString *in_reply_to_status_id;
@property (nonatomic, copy) NSString *in_reply_to_user_id;
@property (nonatomic, copy) NSString *in_reply_to_screen_name;
@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, copy) NSString *bmiddle_pic;
@property (nonatomic, copy) NSString *original_pic;
@property (nonatomic, strong) GeoModel *geo;
@property (nonatomic, strong) WeiboUser *user;
@property (nonatomic, strong) StatusModel *retweeted_status;
@property (nonatomic, strong) NSNumber *reposts_count;
@property (nonatomic, strong) NSNumber *comments_count;
@property (nonatomic, strong) NSNumber *attitudes_count;
@property (nonatomic, strong) NSNumber *mlevel;
@property (nonatomic, strong) WeiboVisibleModel *visible;
@property (nonatomic, strong) PicUrlsModel *pic_urls;

@end
