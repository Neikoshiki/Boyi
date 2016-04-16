//
//  URLHeaderDefine.h
//  Boyi
//
//  Created by Shvier on 16/4/16.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#ifndef URLHeaderDefine_h
#define URLHeaderDefine_h


#endif /* URLHeaderDefine_h */

// 转发操作
#define kRepostURL @"https://api.weibo.com/2/statuses/repost.json"
// 关注用户
#define kFollowUserURL @"https://api.weibo.com/2/friendships/create.json"
// 获取最新公共微博
#define kGetWeibosURL @"https://api.weibo.com/2/statuses/public_timeline.json"
// 获取某条微博的转发数和评论数
#define kGetWeiboInfoURL @"https://api.weibo.com/2/statuses/count.json"
// 获取用户收藏列表
#define kGetCollectionWeiboURL @"https://api.weibo.com/2/favorites.json"
// 搜索用户
#define kSearchUserURL @"https://api.weibo.com/2/search/suggestions/users.json"
// 获取消息
#define kMessageListURL @"https://rm.api.weibo.com/2/remind/unread_count.json"
// 获取用户信息
#define kUserInfoURL @"https://api.weibo.com/2/users/show.json"
// 高级授权
#define kAuthorizeURL @"https://api.weibo.com/oauth2/authorize"