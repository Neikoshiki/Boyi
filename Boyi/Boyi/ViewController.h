//
//  ViewController.h
//  Boyi
//
//  Created by Shvier on 16/4/15.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// 菜单点击
@property (nonatomic, copy) void(^menuDidClick)(NSString *viewControllerName);

@end

