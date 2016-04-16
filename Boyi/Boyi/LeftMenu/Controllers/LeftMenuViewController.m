//
//  LeftMenuViewController.m
//  Boyi
//
//  Created by Shvier on 16/4/15.
//  Copyright © 2016年 Shvier. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "ViewController.h"
#import "FrameDefineHeader.h"

#define kReuseIdentifier @"reuseIdentifier"

@interface LeftMenuViewController ()

@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIView *buttonView;

@property (nonatomic, strong) NSArray *menuData;
@property (nonatomic, strong) NSArray *vcName;
@property (nonatomic, strong) NSMutableDictionary *dict;

@end

@implementation LeftMenuViewController

#pragma mark -数据源懒加载-
- (NSMutableDictionary *)dict {
    if (!_dict) {
        self.dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}

- (NSArray *)menuData {
    if (!_menuData) {
        self.menuData = @[@"首页", @"热门", @"@我的", @"评论", @"点赞", @"私信", @"天气"];
    }
    return _menuData;
}

- (NSArray *)vcName {
    if (!_vcName) {
        self.vcName = @[@"HomeViewController", @"HotViewController", @"AtViewController", @"CommentViewController", @"LikeViewController", @"MessageViewController", @""];
    }
    return _vcName;
}

#pragma mark -菜单按钮初始化-
- (void)initMenu {
    CGFloat menuHeight = kScreenHeight*0.55;
    CGFloat buttonHeight = menuHeight/self.menuData.count;
    CGFloat buttonWidth = kScreenWidth*2/3;
    self.topView.frame = CGRectMake(0, 0, kScreenWidth*2/3, kScreenHeight*1/4);
    self.bottomView.frame = CGRectMake(0, kScreenHeight*(1-1/5), kScreenWidth*2/3, kScreenHeight*1/5);
    self.buttonView.frame = CGRectMake(0, kScreenHeight*1/4, kScreenWidth*2/3, menuHeight);
    UIButton* (^initButtonBlock)(NSString*, CGRect, UIImage*) = ^(NSString *title, CGRect frame, UIImage *image) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = frame;
        button.backgroundColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1.0];
        [button setImage:image forState:UIControlStateNormal];
        return button;
    };
    for (int i = 0; i < self.menuData.count; i ++) {
        UIButton *button = initButtonBlock(self.menuData[i], CGRectMake(0, i*buttonHeight, buttonWidth, buttonHeight), [UIImage imageNamed:@""]);
        [button addTarget:self action:@selector(pushViewController:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000+i;
        [self.dict setObject:self.vcName[i] forKey:[NSString stringWithFormat:@"%ld", button.tag]];
        [self.buttonView addSubview:button];
    }
}

- (void)pushViewController:(UIButton *)button {
    self.rootVC.menuDidClick(self.dict[[NSString stringWithFormat:@"%ld", button.tag]]);
}

#pragma mark -视图加载-
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
