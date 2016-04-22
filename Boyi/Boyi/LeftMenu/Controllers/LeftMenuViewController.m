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
@property (nonatomic, strong) NSArray *buttonColorArray;

@end

@implementation LeftMenuViewController

#pragma mark -数据源懒加载-
- (NSArray *)buttonColorArray {
    if (!_buttonColorArray) {
        self.buttonColorArray = @[[UIColor colorWithRed:0.95 green:0.45 blue:0.38 alpha:1.00], [UIColor colorWithRed:0.98 green:0.64 blue:0.31 alpha:1.00], [UIColor colorWithRed:0.29 green:0.70 blue:0.91 alpha:1.00], [UIColor colorWithRed:0.69 green:0.60 blue:0.95 alpha:1.00], [UIColor colorWithRed:0.29 green:0.69 blue:0.89 alpha:1.00], [UIColor colorWithRed:0.32 green:0.73 blue:0.70 alpha:1.00], [UIColor colorWithRed:0.93 green:0.98 blue:1.00 alpha:1.00]];
    }
    return _buttonColorArray;
}

- (NSMutableDictionary *)dict {
    if (!_dict) {
        self.dict = [NSMutableDictionary dictionary];
    }
    return _dict;
}

- (NSArray *)menuData {
    if (!_menuData) {
        self.menuData = @[@"首页", @"热门", @"@我", @"评论", @"点赞", @"私信", @"天气"];
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
    UIButton* (^initButtonBlock)(NSString*, CGRect, UIImage*, UIColor *) = ^(NSString *title, CGRect frame, UIImage *image, UIColor *color) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = frame;
        [button setImage:image forState:UIControlStateNormal];
        return button;
    };
    for (int i = 0; i < self.menuData.count; i ++) {
        UIButton *button = initButtonBlock(self.menuData[i], CGRectMake(0, i*buttonHeight, buttonWidth, buttonHeight), [UIImage imageNamed:self.menuData[i]], self.buttonColorArray[i]);
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
