//
//  GeoModel.h
//  Boyi
//
//  Created by Shvier on 16/4/23.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoModel : NSObject

@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *province_name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *pinyin;
@property (nonatomic, copy) NSString *more;

@end
